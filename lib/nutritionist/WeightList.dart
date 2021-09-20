import 'package:be_healthy/nutritionist/User.dart';
import 'package:be_healthy/nutritionist/Weight.dart';

class WeightList{
  Weight weight;
  DateTime dateAdded;
  WeightList.def(){
   weight = Weight(0,"Kg");
   dateAdded = DateTime.fromMillisecondsSinceEpoch(111111);
  }

  WeightList({this.weight, this.dateAdded});
  factory WeightList.fromJson2(Map<String, dynamic> json){
    return WeightList(
      weight: Weight(double.tryParse(json['Weight']),"Kg"),
      dateAdded:  DateTime.fromMillisecondsSinceEpoch(int.tryParse(json["Date Added"]))
    );
  }
  WeightList.fromJson(var json){
    weight = Weight(double.tryParse(json['Weight']),"Kg");
    dateAdded = DateTime.fromMillisecondsSinceEpoch(int.tryParse(json["Date Added"]));
  }
  Map<String, dynamic> toJson(Object userID){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    weight.toMetric();
    data["Weight"] = weight.value;
    data["Date Added"] = dateAdded.millisecondsSinceEpoch;
    data["UserID"] = userID;
  }
}