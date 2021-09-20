import 'package:be_healthy/nutritionist/Serving.dart';
import 'package:be_healthy/nutritionist/Size.dart';
import 'package:be_healthy/nutritionist/Volume.dart';

class FoodSize{
  Size size;
  double Gm_wgt;
  Object seq;

  FoodSize(this.size, this.Gm_wgt, this.seq);
  FoodSize.fromJson(Map<String, dynamic> data){
    String unit = data["Msre_Desc"];
    double value = double.tryParse(data["Amount"]);
    if(unit.contains("oz")||unit.contains("ml")){
      size = new Volume(value, unit);
    }
    else
      size = new Serving(value, unit);

    Gm_wgt = double.tryParse(data["Gm_Wgt"]);
    seq = data["Seq"];
  }
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["Msre_Desc"] = size.unit;
    data["Amount"] = size.value;
    data["Gm_Wgt"] = Gm_wgt;
    data["Seq"] = seq;
  }
  double getSize(){
    return size.value;
  }
}