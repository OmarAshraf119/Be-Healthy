import 'package:be_healthy/nutritionist/Meal.dart';

class MealList{

  Meal meal;
  double Qty;
  DateTime dateAdded;

  MealList(this.meal, this.Qty, this.dateAdded);
  MealList.fromJson(Map<String,dynamic>json){
    meal = Meal.fromJson(json);
    Qty = double.tryParse(json["Qty"]);
    try {
      dateAdded =
          DateTime.fromMillisecondsSinceEpoch(int.tryParse(json["Date Added"]));
    }catch(e){}  }

  MealList.fromJsonAll(Map<String,dynamic>json,Map<String,dynamic>Mealjson,
                        var Foodjson,Map<String,dynamic>Junctionjson,Map<String,dynamic> NutJson){
    meal = Meal.fromJsonAll(Mealjson, Foodjson, Junctionjson, NutJson);
    Qty = double.tryParse(json["Qty"]);
    try {
      dateAdded =
          DateTime.fromMillisecondsSinceEpoch(int.tryParse(json["Date Added"]));
    }catch(e){}
  }
  Map <String,dynamic> toJson(Object userId){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["Qty"] = Qty;
    data["Date Added"] = dateAdded.millisecondsSinceEpoch;
    data["Meal"] = meal.ID;
    data["UserID"] = userId;
    return data;
  }

}