import 'dart:math';

import 'package:be_healthy/nutritionist/Food.dart';
import 'package:be_healthy/nutritionist/FoodList.dart';
import 'package:be_healthy/nutritionist/Meal.dart';
import 'package:be_healthy/nutritionist/MealList.dart';
import 'package:be_healthy/nutritionist/MyQueue.dart';
import 'package:be_healthy/nutritionist/Nutrition.dart';
import 'package:be_healthy/nutritionist/Operations.dart';
import 'package:date_calendar/date_calendar.dart';

class DietHistory{
  MyQueue<List<MealList>> meals;
  MyQueue<List<FoodList>> food;
  MyQueue<DateTime> Day;

  DietHistory(this.meals, this.food, this.Day);
  DietHistory.Def(){
    meals = new MyQueue<List<MealList>>();
    food = new MyQueue<List<FoodList>> ();
    Day = new  MyQueue<DateTime>();
  }
  DietHistory.fromObj(DietHistory d) {
    this.meals = new MyQueue.fromList(d.meals.getQueue());
    this.food = new MyQueue.fromList(d.food.getQueue());
    this.Day = new MyQueue.fromList(d.Day.getQueue());
  }
  DietHistory.fromJson(var Foodjson,var Mealjson,Map<String,dynamic>Dietjson){
    List<FoodList> f = Foodjson.map((item) {
      return FoodList.fromJson(item);
    }).toList;
    List<MealList> m = Mealjson.map((item) {
      return MealList.fromJson(item);
    }).toList;
    for(int i=0;i<7;i++){
      if(Dietjson["Day"+i.toString()].toString()!="Null") {
        DateTime d = DateTime.fromMillisecondsSinceEpoch(
            int.tryParse(Dietjson["Day" + i.toString()]));
        Day.add(d);
        List list= getDietByDay(d, f, m);
        food.add(list[0]);
        meals.add(list[1]);
      }
      else
        break;
    }
  }
  DietHistory.fromJsonAll(Map<String,dynamic>Dietjson,
                          var foodListJson,var foodJson,
                          Map<String, dynamic> FoodNutritionJson,var FoodSizeJson,
                          var MealListjson,var Mealjson,
                          var MealListFoodjson,Map<String,dynamic>Junctionjson,
                          Map<String,dynamic> MealNutJson){
    List<FoodList> f = foodListJson.map((item) {
      return FoodList.fromJsonAll(item,foodJson,FoodNutritionJson,FoodSizeJson);
    }).toList;
    List<MealList> m = MealListjson.map((item) {
      return MealList.fromJsonAll(item,Mealjson,MealListFoodjson,Junctionjson,MealNutJson);
    }).toList;
    for(int i=0;i<7;i++){
      if(Dietjson["Day"+i.toString()].toString()!="Null") {
        DateTime d = DateTime.fromMillisecondsSinceEpoch(
            int.tryParse(Dietjson["Day" + i.toString()]));
        Day.add(d);
        List list= getDietByDay(d, f, m);
        food.add(list[0]);
        meals.add(list[1]);
      }
      else
        break;
    }
  }
  Map<String,dynamic> toDietJson(Object userID){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    for(int i=0;i<Day.getQueue().length;i++) {
      data["Day" + (i+1).toString()] = Day.get(i).millisecondsSinceEpoch;
    }
    data["UserID"] = userID;
    return data;
  }
  Map<String,dynamic> toFoodJson(Object userID ){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    for(int i=0;i<Day.getQueue().length;i++) {
     food.get(i).forEach((f)=> data.addAll(f.toJson(userID)));
    }
    return data;
  }
  Map<String,dynamic> toMealJson(Object userID ){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    for(int i=0;i<Day.getQueue().length;i++) {
      meals.get(i).forEach((f)=> data.addAll(f.toJson(userID)));
    }
    return data;
  }
  MyQueue<List<MealList>> getMeals() {
    return meals;
  }
  MyQueue<List<FoodList>> getFood() {
    return food;
  }
  MyQueue<DateTime> getDay() {
    return Day;
  }
  DateTime getDayByIndex(int i) {
    return Day.get(i);
  }
  List<MealList> getMealList(int i) {
    return meals.get(i);
  }
  List<FoodList> getFoodList(int i) {
    return food.get(i);
  }
  List<MealList> getMealListByDate(DateTime day) {
    return meals.get(Day.indexOf(day));
  }
  List<FoodList> getFoodListByDate(DateTime day) {
    return food.get(Day.indexOf(day));
  }
  add(List<FoodList> f,List<MealList> m ,DateTime day){
    meals.add(m);
    food.add(f);
    Day.add(day);
  }
  clear(){
    meals.clear();
    food.clear();
    Day.clear();
  }
  void addFood(Food f,double qty,DateTime d,Object seq){
    int i =0;
    for(;i<Day.size();i++){
      if(Day.get(i)==null)
        break;
      if(Day.get(i).millisecondsSinceEpoch==d.millisecondsSinceEpoch){
        food.get(i).add(FoodList(f,seq, qty, d));
        break;
      }
    }
    if(i==Day.size()){
      List<MealList> m ;
      List<FoodList> f1 ;
      f1.add(FoodList(f,seq, qty, d));
      this.add(f1,m,getDayByDate(d));
    }

  }
  void addMeal(Meal m,double qty,DateTime d){
    int i =0;
    for(;i<Day.size();i++){
      if(Day.get(i)==null)
        break;
      if(Day.get(i).millisecondsSinceEpoch==d.millisecondsSinceEpoch){
        meals.get(i).add(MealList(m, qty, d));
        break;
      }
    }
    if(i==Day.size()){
      List<MealList> m1 ;
      List<FoodList> f ;
      m1.add(MealList(m, qty, d));
      this.add(f,m1,getDayByDate(d));
    }
  }
  List getDietByDay(DateTime d,List<FoodList> food,List<MealList> meals){
    // You must enter d with years/month/day only not hours
    int i=0;
    for(;i<Day.size();i++){
      if(Day.get(i).compareTo(d)==0)
        break;
    }
    if(i<Day.size()){
      food.clear();
      List<FoodList> f = (Operations.getFoodByDate(d,this.food.get(i)));
      for(int j =0;j<f.length;j++){
        food.add(FoodList(f.elementAt(i).food,f.elementAt(i).foodSeq,f.elementAt(i).Qty,f.elementAt(i).dateAdded));
      }
      meals.clear();
      List<MealList> m =(Operations.getMealByDate(d,this.meals.get(i)));
      for(int j =0;j<m.length;j++){
        meals.add(MealList(m.elementAt(i).meal,m.elementAt(i).Qty,f.elementAt(i).dateAdded));
      }
      return [food,meals];
    }
    return null;

  }
  List getDietByHr(DateTime d,List<FoodList> food,List<MealList> meals){
    int i=0;
    for(;i<Day.size();i++){
      if((d.difference(Day.get(i)).inDays==0))
        break;
    }
    if(i<Day.size()){food.clear();
    List<FoodList> f = (Operations.getFoodByHr(d, this.food.get(i)));
    for(int j =0;j<f.length;j++){
      food.add(FoodList(f.elementAt(i).food,f.elementAt(i).foodSeq,f.elementAt(i).Qty,f.elementAt(i).dateAdded));
    }
    meals.clear();
    List<MealList> m =(Operations.getMealByHr(d,this.meals.get(i)));
    for(int j =0;j<m.length;j++){
      meals.add(MealList(m.elementAt(i).meal,m.elementAt(i).Qty,f.elementAt(i).dateAdded));
    }
    return [food,meals];
    }
    return null;
  }

  List getDietByDate(DateTime d,List<FoodList> food,List<MealList> meals){
    int i=0;
    for(;i<Day.size();i++){
      if((d.difference(Day.get(i)).inDays==0))
        break;
    }
    if(i<Day.size()){food.clear();
    List<FoodList> f = (Operations.getFoodByDate(d, this.food.get(i)));
    for(int j =0;j<f.length;j++){
      food.add(FoodList(f.elementAt(i).food,f.elementAt(i).foodSeq,f.elementAt(i).Qty,f.elementAt(i).dateAdded));
    }
    meals.clear();
    List<MealList> m =(Operations.getMealByDate(d,this.meals.get(i)));
    for(int j =0;j<m.length;j++){
      meals.add(MealList(m.elementAt(i).meal,m.elementAt(i).Qty,f.elementAt(i).dateAdded));
    }
    return [food,meals];
    }
    return null;
  }
  static DateTime getDayByDate(DateTime d){
    // Must Be Used For Inserting Days in Diet History .....
     DateTime d1 = new GregorianCalendar(d.year,d.month,
         d.day).toDateTimeLocal();
    return d1;
  }
  Nutrition getNutritionByDay(DateTime d,Map<String,dynamic> json){

    List<FoodList> f = new List<FoodList>();
    List<MealList> m = new List<MealList>();
    Nutrition nf;
    Nutrition nm;
    Nutrition n;
    List list = getDietByDay(d, f, m);
    if(list!=null){
      f = list[0];
      m = list[1];

      if(f.length!=0)
        nf = new Nutrition.fromNutrition(Operations.calculateFoodList(f,json));
      if(m.length!=0)
        nm = new Nutrition.fromNutrition(Operations.calculateMealList(m,json));
      if(nf.energy!=null&&nm.energy!=null)
        n = new Nutrition.fromNutrition(Operations.addNutrition(nf, [nm]));
      else if(nf.energy==null&&nm.energy==null)
        return null;
      else if(nf.energy==null)
        n = new Nutrition.fromNutrition(nm);
      else if(nm.energy==null)
        n = new Nutrition.fromNutrition(nf);
      return n;
    }
    return null;
  }

  Nutrition getNutritionByDate(DateTime d,Map<String,dynamic> json){

    List<FoodList> f = new List<FoodList>();
    List<MealList> m = new List<MealList>();
    Nutrition nf;
    Nutrition nm;
    Nutrition n;
    List list = getDietByDate(d, f, m);
    if(list!=null){
      f = list[0];
      m = list[1];

      if(f.length!=0)
        nf = new Nutrition.fromNutrition(Operations.calculateFoodList(f,json));
      if(m.length!=0)
        nm = new Nutrition.fromNutrition(Operations.calculateMealList(m,json));
      if(nf.energy!=null&&nm.energy!=null)
        n = new Nutrition.fromNutrition(Operations.addNutrition(nf, [nm]));
      else if(nf.energy==null&&nm.energy==null)
        return null;
      else if(nf.energy==null)
        n = new Nutrition.fromNutrition(nm);
      else if(nm.energy==null)
        n = new Nutrition.fromNutrition(nf);
      return n;
    }
    return null;
  }

}