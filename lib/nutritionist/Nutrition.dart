import 'package:be_healthy/nutritionist/Energy.dart';
import 'package:be_healthy/nutritionist/Nutrient.dart';

class Nutrition {

  List<Nutrients> nutrients;
  Energy energy;

  Nutrition(this.nutrients, this.energy);

  Nutrition.fromNutrition(Nutrition n){
    nutrients = n.nutrients;
    energy = n.energy;
  }

  Nutrition.fromJson(var json){
    nutrients = json.map((item) {
      return Nutrients.fromJson(item);
    }).toList;
    Nutrients n = nutrients.firstWhere((n) => n.Name == "Energy");
    energy = Energy(n.Unit, n.Value);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> x = nutrients.map((f) => f.toJson()).toList();
  Map<String, dynamic> map() => {'nutrients': x};
  return map();
}

  double getNutrientVal(String Name) {
    try {
        return nutrients.firstWhere((n) => n.Name == "Energy").Value;
    } catch (e) {
      print("error in getting Nutrient value with Name: " + Name+ " "+ e);
      return 0;
    }
  }

  String getNutrientUnit(String Name) {
    try {
      return nutrients.firstWhere((n) => n.Name == "Energy").Unit;
    } catch (e) {
      print("error in getting Nutrient Unit with Name: " + Name+ " "+ e);
      return "";
    }
  }
  bool setNutrientVal(double y,String Name){
    try{
      nutrients.firstWhere((n)=> n.Name==Name).Value=y;
      return true;
    }catch(e){
    print("Nutrient["+Name+"] Not Found");
    return false;
    }
  }
  bool setNutrientValByIndex(double y,int i){
    try{
      nutrients.elementAt(i).Value=y;
      return true;
    }catch(e){
    print("Nutrient["+i.toString()+"] Not Found");
    return false;
    }
  }
  void setEnergyVal(double y){
   energy.value = y;
  }
  Nutrients getNutrientByName(String Name) {
    return nutrients.firstWhere((f)=>f.Name == Name);
  }
  double getNutrientValByIndex(int i){
    return nutrients.elementAt(i).Value;
  }
  Nutrients getNutrientByIndex(int i) {
    return nutrients.elementAt(i);
  }
}