
import 'package:be_healthy/nutritionist/Food.dart';
import 'package:be_healthy/nutritionist/FoodList.dart';
import 'package:be_healthy/nutritionist/Nutrient.dart';
import 'package:be_healthy/nutritionist/Nutrition.dart';
import 'package:be_healthy/nutritionist/Recipe.dart';
import 'package:be_healthy/nutritionist/User.dart';

class Meal{
  String Name;
  Object ID;
  String Img;
  String Description;
  List<FoodList> foodList;
  Nutrition nutrition;
  Recipe recipe;

  Meal.fromall(this.Name, this.ID, this.Img, this.Description,
                this.foodList,this.nutrition, this.recipe);
  Meal(this.Name, this.ID, this.Img,this.foodList);
  Meal.fromMeal(Meal m){
    Name = m.Name;
    ID = m.ID;
    Img = m.Img;
    Description = m.Description;
    foodList = m.foodList;
    nutrition = Nutrition.fromNutrition(m.nutrition);
    recipe = Recipe.fromRecipe(m.recipe);
  }
  Meal.fromJson(Map<String,dynamic>json){
    Name = json["MealName"];
    ID = json["ID"];
    Description = json["Description"];
    Img = json["Img"];
    try{
    Duration d = Duration(minutes: (int.tryParse(json["Preparation Time"])));
    String des = json["Recipe Directions"].toString();
    recipe = Recipe.fromDesc(Desription: des,duration: d);
    }catch(e){}

  }
  Meal.fromJsonAll(Map<String,dynamic>json,var Foodjson,Map<String,dynamic>Junctionjson,Map<String,dynamic> NutJson){
    Meal.fromJson(json);
    nutrition = Nutrition.fromJson(NutJson);
    foodList = Foodjson.map((item) {
      return FoodList.fromJson(item);
    }).toList;
  }
  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["MealName"] = Name;
    data["Description"] = Description;
    data["Img"] = Img;
    try {
      data["Preparation Time"] = recipe.duration.inMinutes;
    }catch(e){}
    data["Recipe Directions"] = recipe.Desription;
   // data.addAll(foodList.forEach((f)=> f.toJson(Null)));
    return data;
  }
  Map<String,dynamic> toJsonfood(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    foodList.forEach((f)=> data.addAll(f.toJson(Null)));
    return data;
  }

  double getNutrientVal(String Name){
    return nutrition.getNutrientVal(Name);
  }
  String getNutrientUnit(String Name){
    return nutrition.getNutrientUnit(Name);
  }
  double getEnergyVal(){
    return nutrition.energy.value;
  }
  double getNutrientValByIndex(int i){
    return nutrition.getNutrientValByIndex(i);
  }
  Nutrients getNutrientByIndex(int i) {
    return nutrition.getNutrientByIndex(i);
  }
  Nutrients getNutrientByName(String Name) {
    return nutrition.getNutrientByName(Name);
  }
}