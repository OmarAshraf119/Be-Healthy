import 'package:be_healthy/nutritionist/FoodSize.dart';
import 'package:be_healthy/nutritionist/Nutrient.dart';
import 'package:be_healthy/nutritionist/Nutrition.dart';
import 'package:be_healthy/nutritionist/Size.dart';

class Food{

  String Name;
  Object ID;
  String Group;
  String Img;
  String Description;
  List<FoodSize> size;
  Nutrition nutrition;

  Food(this.Name, this.ID, this.Group, this.Img, this.Description, this.size,
      this.nutrition);
  Food.small({this.Name, this.ID, this.Group, this.Img});
  factory Food.fromJson2(Map<String, dynamic> data){
    return Food.small(
        Name: data["Long_Desc"],
        Group : data["FdGrp_Desc"],
        ID : data["NDB_No"],
        Img : data["Img"]
    );
  }
  Food.fromJson(Map<String, dynamic> data){
    Name = data["Long_Desc"];
    Group = data["FdGrp_Desc"];
    ID = data["NDB_No"];
    Img = data["Img"];
    Description = data["Description"];
  }
  Food.fromJsonAll(Map<String, dynamic> foodJson,Map<String, dynamic> NutritionJson,var SizeJson){
    Food.fromJson(foodJson);
    nutrition = Nutrition.fromJson(NutritionJson);
    size = SizeJson.map((item) {
      return FoodSize.fromJson(item);
    }).toList;
  }

  /*
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
  }*/

  double getNutrientVal(String Name){
    return nutrition.getNutrientVal(Name);
  }
  String getNutrientUnit(String Name){
    return nutrition.getNutrientUnit(Name);
  }
  Size getSize(Object seq){
    return size.firstWhere((s) => s.seq == seq).size;
  }
  double getGmWt(Object seq){
    return size.firstWhere((s) => s.seq == seq).Gm_wgt;
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