class Nutrients{
  String Name;
  Object ID;
  String Type;
  String Description;
  String Unit;
  double Value;

  Nutrients(this.Name, this.ID, this.Unit, this.Value);

  Nutrients.fromall(this.Name, this.ID, this.Type, this.Description, this.Unit,
      this.Value);
  Nutrients.fromJson(Map<String, dynamic> json){
    Name = json["NutrDesc"];
    ID = json["Nutr_No"];
    Unit = json["Units"];
    Value = double.tryParse(json["Nutr_Val"]);
  }
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["Nutr_No"] = ID;
    data["Units"] = Unit;
    data["NutrDesc"] = Name;
    data["Nutr_Val"] = Value;
  }
  
}