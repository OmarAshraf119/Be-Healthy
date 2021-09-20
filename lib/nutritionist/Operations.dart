import 'dart:convert';

import 'package:be_healthy/nutritionist/Food.dart';
import 'package:be_healthy/nutritionist/FoodList.dart';
import 'package:be_healthy/nutritionist/Meal.dart';
import 'package:be_healthy/nutritionist/MealList.dart';
import 'package:be_healthy/nutritionist/Nutrition.dart';

class Operations{


  static List<FoodList> getFoodByHr(DateTime d, List<FoodList> food){
    List<FoodList> f =new List<FoodList>();
    for(int i =0;i<food.length;i++){
      if(food.elementAt(i).dateAdded.difference(d).inHours==0){
        f.add(FoodList(food.elementAt(i).food,food.elementAt(i).foodSeq,food.elementAt(i).Qty,food.elementAt(i).dateAdded));
      }
    }
    return f;
  }

  static List<FoodList> getFoodByDay(DateTime d, List<FoodList> food){
    List<FoodList> f =new List<FoodList>();
    for(int i =0;i<food.length;i++){
      if(food.elementAt(i).dateAdded.difference(d).inDays==0){
        f.add(FoodList(food.elementAt(i).food,food.elementAt(i).foodSeq,food.elementAt(i).Qty,food.elementAt(i).dateAdded));
      }
    }
    return f;
  }

  static List<FoodList> getFoodByDate(DateTime d, List<FoodList> food){
    List<FoodList> f =new List<FoodList>();
    for(int i =0;i<food.length;i++){
      if(food.elementAt(i).dateAdded.compareTo(d)==0){
        f.add(FoodList(food.elementAt(i).food,food.elementAt(i).foodSeq,food.elementAt(i).Qty,food.elementAt(i).dateAdded));
      }
    }
    return f;
  }

  static List<MealList> getMealByHr(DateTime d, List<MealList> food){
    List<MealList> f =new List<MealList>();
    for(int i =0;i<food.length;i++){
      if(food.elementAt(i).dateAdded.difference(d).inHours==0){
        f.add(MealList(food.elementAt(i).meal,food.elementAt(i).Qty,food.elementAt(i).dateAdded));
      }
    }
    return f;
  }

  static List<MealList> getMealByDay(DateTime d, List<MealList> food){
    List<MealList> f =new List<MealList>();
    for(int i =0;i<food.length;i++){
      if(food.elementAt(i).dateAdded.difference(d).inDays==0){
        f.add(MealList(food.elementAt(i).meal,food.elementAt(i).Qty,food.elementAt(i).dateAdded));
      }
    }
    return f;
  }

  static List<MealList> getMealByDate(DateTime d, List<MealList> food){
    List<MealList> f =new List<MealList>();
    for(int i =0;i<food.length;i++){
      if(food.elementAt(i).dateAdded.compareTo(d)==0){
        f.add(MealList(food.elementAt(i).meal,food.elementAt(i).Qty,food.elementAt(i).dateAdded));
      }
    }
    return f;
  }
  static Nutrition calculateFoodWithQty(Food f,Object seq,double Qty,Map<String,dynamic> json){
    Nutrition n =new Nutrition.fromJson(json);
    double wt;
    wt = f.getGmWt(seq)/100;
    for(int i=0;i<n.nutrients.length;i++){
      n.getNutrientByName(f.getNutrientByIndex(i).Name).Value = f.getNutrientValByIndex(i);
    }
    n.setEnergyVal(f.getEnergyVal()*wt*Qty);
    return n;
  }

  static Nutrition calculateFood(Food f,Object seq,Map<String,dynamic> json){
    Nutrition n =new Nutrition.fromJson(json);
    double wt;
    wt = f.getGmWt(seq)/100;
    for(int i=0;i<n.nutrients.length;i++){
      n.getNutrientByName(f.getNutrientByIndex(i).Name).Value = f.getNutrientValByIndex(i);
    }
    n.setEnergyVal(f.getEnergyVal()*wt);
    return n;
  }
  static Nutrition calculateNutrition(Nutrition n1,double Qty){
    Nutrition n =new Nutrition.fromNutrition(n1);

    for(int i=0;i<n.nutrients.length;i++){
      n.getNutrientByName(n1.getNutrientByIndex(i).Name).Value = n1.getNutrientValByIndex(i)*Qty;
    }
    n.setEnergyVal(n1.energy.value*Qty);

    return n;
  }
  static Nutrition addNutrition(Nutrition n1,List<Nutrition> args){
    Nutrition n = Nutrition.fromNutrition(n1);
    for(int i=0;i<n.nutrients.length;i++){
      String name = n.getNutrientByIndex(i).Name;
      n.getNutrientByIndex(i).Value +=getSum(args,name);
      }
    n.energy.value += getEnergySum(args);
    return n;
  }
  static double getSum(List<Nutrition> n,String Name){
    double sum = 0;
    for(int i=0;i<n.length;i++) {
      sum+= n.elementAt(i).getNutrientVal(Name);
    }
    return sum;
  }
  static double getEnergySum(List<Nutrition> n){
    double sum = 0;
    for(int i=0;i<n.length;i++) {
      sum+= n.elementAt(i).energy.value;
    }
    return sum;
  }
  static Nutrition subtractNutrition(Nutrition n1,List<Nutrition> args){
    Nutrition n = Nutrition.fromNutrition(n1);
    for(int i=0;i<n.nutrients.length;i++){
      String name = n.getNutrientByIndex(i).Name;
      n.getNutrientByIndex(i).Value -=getDiff(args,name);
    }
    n.energy.value -= getEnergyDiff(args);
    return n;
  }
  static double getDiff(List<Nutrition> n,String Name){
    double sum = 0;
    for(int i=0;i<n.length;i++) {
      sum-= n.elementAt(i).getNutrientVal(Name);
    }
    return sum;
  }
  static double getEnergyDiff(List<Nutrition> n){
    double sum = 0;
    for(int i=0;i<n.length;i++) {
      sum-= n.elementAt(i).energy.value;
    }
    return sum;
  }
  static Nutrition calculateMeal(Meal m,double Qty,Map<String,dynamic> json){

    Nutrition n = new Nutrition.fromNutrition(calculateFoodWithQty(m.foodList.elementAt(0).food,m.foodList.elementAt(0).foodSeq
        ,m.foodList.elementAt(0).Qty,json));

    for(int i=1;i<m.foodList.length;i++){
      Nutrition temp =new Nutrition.fromNutrition(calculateFoodWithQty(m.foodList.elementAt(i).food,m.foodList.elementAt(i).foodSeq
          ,m.foodList.elementAt(i).Qty,json));

      n = addNutrition(n,[temp]);
    }
    n = calculateNutrition(n, Qty);
    return n;
  }
  static Nutrition calculateFoodList(List<FoodList> f,Map<String,dynamic> json){
    Nutrition n = new Nutrition.fromNutrition(calculateFoodWithQty(f.elementAt(0).food,f.elementAt(0).foodSeq
        ,f.elementAt(0).Qty,json));
    for(int i=1;i<f.length;i++){
      Nutrition temp =new Nutrition.fromNutrition(calculateFoodWithQty(f.elementAt(i).food,f.elementAt(i).foodSeq
          ,f.elementAt(i).Qty,json));

      n = addNutrition(n,[temp]);
    }
    return n;
  }
  static Nutrition calculateMealList(List<MealList> m,Map<String,dynamic> json){
    Nutrition n = new Nutrition.fromNutrition(calculateMeal(m.elementAt(0).meal
        ,m.elementAt(0).Qty,json));
    for(int i=1;i<m.length;i++){
      Nutrition temp =new Nutrition.fromNutrition(calculateMeal(m.elementAt(i).meal
          ,m.elementAt(i).Qty,json));

      n = addNutrition(n,[temp]);
    }
    return n;
  }

}
