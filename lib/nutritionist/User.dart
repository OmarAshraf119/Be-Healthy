import 'package:be_healthy/nutritionist/Account.dart';
import 'package:be_healthy/nutritionist/Age.dart';
import 'package:be_healthy/nutritionist/BMI.dart';
import 'package:be_healthy/nutritionist/DietHistory.dart';
import 'package:be_healthy/nutritionist/FavMeal.dart';
import 'package:be_healthy/nutritionist/Goal.dart';
import 'package:be_healthy/nutritionist/Height.dart';
import 'package:be_healthy/nutritionist/Weight.dart';
import 'package:be_healthy/nutritionist/WeightList.dart';
import 'package:be_healthy/services/database.dart';

class User extends Account {
  String Gender;
  Weight weight;
  Height height;
  BMI Bmi;
  Age age;
  Goal goal;
  List<WeightList> wtList;
  FavMeal favMeals;
  DietHistory dietHistory;

  User(String Gender, Weight weight, Height height, BMI Bmi, Age age) {
    this.Gender = Gender;
    this.weight = new Weight.fromWeight(weight);
    this.height = new Height.fromHeight(height);
    this.Bmi = new BMI.fromBMI(Bmi);
    this.age = new Age.fromAge(age);
  }
  User.fromall(String Gender, Weight weight, Height height, DateTime BirthDate,
                String Name, String Password, String Img):super.fromall(Name: Name,Password: Password, Img: Img){
     User(Gender, weight, height, Bmi, age);
  }
  User.fromJson(Map<String, dynamic> json,Map<String, dynamic> GoalJson){/*,var WtJson) {*/
    Gender = json['Gender'];
    weight = Weight(double.tryParse(json['Weight']),"kg");
    height = Height(double.tryParse(json['Height']),"cm");
    Bmi = BMI(weight,height);
    int num = int.tryParse(json["Age"]);
    age = Age(num);
    Name = json["UserName"];
    ID = json['ID'];
    Img = json['Img'];
    Password = json["Password"];
    goal = Goal.fromJson(GoalJson);
    wtList = new List<WeightList>();

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
    json['ID'] = ID;
    json['Gender'] = Gender;
    weight.toMetric();
    json['Weight'] = weight.value;
    height.toMetric();
    json['Height'] = height.value;
    json['Age'] = age.getBirthDate().millisecondsSinceEpoch;
    json["Body Type"] = Bmi.BodyType;
    json["BMI"] = Bmi.value;
    json["LifeStage"] = age.LifeStage;
    return json;
  }

}