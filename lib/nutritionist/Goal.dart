
import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:be_healthy/nutritionist/BMI.dart';
import 'package:be_healthy/nutritionist/Energy.dart';
import 'package:be_healthy/nutritionist/User.dart';
import 'package:be_healthy/nutritionist/Weight.dart';

class Goal{

LinkedHashMap<String,double> nutrients ;
Weight weight;
Energy energy;
BMI Bmi;

Goal({this.nutrients,this.energy,this.weight,this.Bmi});

Goal.fromJson(Map<String, dynamic> json){
  weight = Weight(double.tryParse(json['Weight (Kg)']),'Kg');
  Bmi = BMI.fromValue(double.tryParse(json['BMI']));
  energy = Energy("Kcal", double.tryParse(json['Energy (Kcal/day)']));
  json.remove('Weight (Kg)');
  json.remove('BMI');
  json.remove('Energy (Kcal/day)');
  json.remove('UserID');
  nutrients = new LinkedHashMap<String,double>();
  json.forEach((key,value){
    nutrients[key] = double.tryParse(value);
  });
}
Map<String, dynamic> toJson() {
  var map = new Map<String, dynamic>();
  map = nutrients.map((a, b) => MapEntry(a as String, b as dynamic));
  map['Energy (Kcal/day)'] = energy.value;
  map['Weight (Kg)'] = weight.value;
  map['BMI']= Bmi.value;
  return map;
}

void setup(User u , Map<String, dynamic> RDAjson,Map<String, dynamic> REEjson){

  weight = new Weight(BMI.nextCategoryWt(u.Bmi, u.height), "Kg");
  Bmi = new BMI(weight, u.height);
  double ree = double.tryParse(REEjson['Weight Factor'])* weight.value + double.tryParse(REEjson['Sum']);
  energy = new Energy("Kcal", ree* double.tryParse(REEjson['REE Factor']));
  double temp =  double.tryParse(RDAjson['Protein (g/Kg)'])* weight.value;
  nutrients.clear();
  nutrients["Protein (g)"] = temp;
  temp =  double.tryParse(RDAjson["Fat (% per Calories) min"])/100.0;
  temp*=( energy.value/9.0);
  nutrients["Fat (g) min"] = temp;
  temp =  double.tryParse(RDAjson["Fat (% per Calories) max"])/100.0;
  temp*=( energy.value/9.0);
  nutrients["Fat (g) max"] = temp;
  temp *= (double.tryParse(RDAjson["Sat Fat  (% per Fat)"])/100.0);
  nutrients["Sat Fat (g)"] = temp;
  temp =  (double.tryParse(RDAjson["Sugar (% per Calories)"])/100.0);
  temp *= ( energy.value/4.0);
  nutrients["Sugar (g)"] = temp;
  temp =  (double.tryParse(RDAjson["Carbohydrates (% per Calories) min"])/100.0);
  temp *= ( energy.value/4.0);
  nutrients["Carbohydrates (g) min"] = temp;
  temp =  (double.tryParse(RDAjson["Carbohydrates (% per Calories) max"])/100.0);
  temp *= ( energy.value/4.0);
  nutrients["Carbohydrates (g) max"] = temp;

  RDAjson.remove("ID");
  RDAjson.remove("Category");
  RDAjson.remove("Age (Start)");
  RDAjson.remove("Age (End)");
  RDAjson.remove("Protein (g/Kg)");
  RDAjson.remove("Sugar (% per Calories)");
  RDAjson.remove("Sat Fat  (% per Fat)");
  RDAjson.remove("Fat (% per Calories) max");
  RDAjson.remove("Fat (% per Calories) min");
  RDAjson.remove("Carbohydrates (% per Calories) min");
  RDAjson.remove("Carbohydrates (% per Calories) max");

  RDAjson.forEach((key,value){
    nutrients.putIfAbsent(key, ()=> double.tryParse(value));
  });
}

}