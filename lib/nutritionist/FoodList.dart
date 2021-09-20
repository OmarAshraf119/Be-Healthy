import 'package:be_healthy/nutritionist/Food.dart';

class FoodList{

  Food food;
  Object foodSeq;
  double Qty;
  DateTime dateAdded;

  FoodList(this.food, this.foodSeq, this.Qty, this.dateAdded);
  FoodList.fromJson(Map<String,dynamic>json){
    food = Food.fromJson(json);
    Qty = double.tryParse(json["Qty"]);
    try {
      dateAdded =
          DateTime.fromMillisecondsSinceEpoch(int.tryParse(json["Date Added"]));
    }catch(e){}
    foodSeq = json["Food Seq"];
  }
  FoodList.fromJsonAll(Map<String,dynamic>json,Map<String, dynamic> foodJson,Map<String, dynamic> NutritionJson,var SizeJson){
    food = Food.fromJsonAll(foodJson, NutritionJson, SizeJson);
    Qty = double.tryParse(json["Qty"]);
    try {
      dateAdded =
          DateTime.fromMillisecondsSinceEpoch(int.tryParse(json["Date Added"]));
    }catch(e){}
    foodSeq = json["Food Seq"];
  }

  Map <String,dynamic> toJson(Object userId){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["Food Seq"] =  foodSeq;
    data["Qty"] = Qty;
    data["Date Added"] = dateAdded.millisecondsSinceEpoch;
    data["NDB_No"] = food.ID;
    data["UserID"] = userId;
    return data;
  }

}