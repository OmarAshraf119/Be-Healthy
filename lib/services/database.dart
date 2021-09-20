import 'dart:math';

import 'package:be_healthy/nutritionist/DietHistory.dart';
import 'package:be_healthy/nutritionist/Food.dart';
import 'package:be_healthy/nutritionist/Goal.dart';
import 'package:be_healthy/nutritionist/User.dart';
import 'package:be_healthy/nutritionist/Weight.dart';
import 'package:be_healthy/nutritionist/WeightList.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DatabaseService {
  User user;
  var url;
  var data;
  var response;
  var result;
  //Sign in ..........................
  Future SignIn(String email, String password) async {
    try{
      // SERVER LOGIN API URL
       url = 'https://pertinent-diagonals.000webhostapp.com/login.php';
      // Store all data with Param Name.
       data = {'email': email, 'password' : password};
      // Starting Web API Call.
       response = await http.post(url, body: json.encode(data));
      // Getting Server response into variable.
       result = jsonDecode(response.body.toString());
      if(result.toString().contains('Invalid')){
        print('Invalid');
        return null;
      }
      else{
        try {

         // await _getGoal();

          user = User.fromJson(result,await _getGoal());//,await _getWtHistory());
          List<WeightList>  wtList =await getWtHistory();
          user.wtList = wtList;

          print(user.wtList.elementAt(0).weight.toString());
          // print(user.wtList.elementAt(0).toString());

          /*       try{
            Goal goal = Goal.fromJson(result);
            print(goal.weight.toString());
            user.goal = Goal.fromJson(result);
            print(user.goal.weight.toString());
          }catch(e){
            print("Error Mapping Goal"+e);
          }*/
          return user;
        }catch(ee){
          print("Error : Mapping User    "+ee);
          return null;
        }/*
        //get goal ..................
        url = 'https://pertinent-diagonals.000webhostapp.com/query.php';
        data.clear();
        String str = result["ID"].toString();
        data = {'tname': 'goal', 'condition' : "UserID = $str"};
        response = await http.post(url, body: json.encode(data));
        result = jsonDecode(response.body.toString());
        // ..............................

        // get RDAJson ....................
        url = 'https://pertinent-diagonals.000webhostapp.com/query.php';
        data.clear();
        //str = "Category = " +user.Gender + " AND "+user.age.value+ " BETWEEN `Age (Start)` AND `Age (End)`";
        data = {'tname': 'rda', 'condition' : "$str"};
        response = await http.post(url, body: json.encode(data));
        result = jsonDecode(response.body.toString());

        //.................................*/
      }
    }catch(e){
      print("hh  "+e.toString());
      return null;
    }
  }
  Future  _getGoal() async {
    url = 'https://pertinent-diagonals.000webhostapp.com/query.php';
    data.clear();
    String str = result["ID"].toString();
    data = {'tname': 'goal', 'condition' : "UserID = $str"};
    response = await http.post(url, body: json.encode(data));
    var Goalresult = jsonDecode(response.body.toString());

    return Goalresult;
  }
  Future<List<WeightList>>  getWtHistory() async {
    url = 'https://pertinent-diagonals.000webhostapp.com/query2.php';
    data.clear();
    String str = result["ID"].toString();
    //
    data = {'tname': 'wthistory','sel': '`Date Added`, Weight' ,'condition' : "UserID = $str "};
    response = await http.post(url, body: json.encode(data));
    final Goalresult = jsonDecode(response.body.toString()).cast<Map<String, dynamic>>();
    return Goalresult.map<WeightList>((json)=> WeightList.fromJson(json)).toList();
  }
  Future<DietHistory>  _getDietHistory() async {
    url = 'https://pertinent-diagonals.000webhostapp.com/query2.php';
    data.clear();
    String str = result["ID"].toString();
    //
    data = {
      'tname': '`diet history`',
      //'sel': '`Date Added`, Weight',
      'condition': "UserID = $str "
    };
    response = await http.post(url, body: json.encode(data));
    final DietJson = jsonDecode(response.body.toString());//.cast<Map<String, dynamic>>();
    data.clear();
    //
    data = {
      'tname': '`eaten food`',
      //'sel': '`Date Added`, Weight',
      'condition': "UserID = $str "
    };
    response = await http.post(url, body: json.encode(data));
    final foodListJson = jsonDecode(response.body.toString()).cast<Map<String, dynamic>>();
    //List<FoodList> fl = foodListJson.map((json)=> )
    data.clear();
    data =  { 'query': "SELECT `food_des1`.`NDB_No`,`food_des1`.`Long_Desc`,`food_des1`.`Img`,`food_des1`.`Description`,`fd_group`.FdGrp_Desc FROM `food_des` `food_des1` INNER JOIN fd_group ON food_des1.FdGrp_Cd= fd_group.FdGrp_CD WHERE NDB_No IN (SELECT  `eaten food`.NDB_No FROM `eaten food` WHERE UserID = 11)"};
    url = 'https://pertinent-diagonals.000webhostapp.com/query3.php';
    response = await http.post(url, body: json.encode(data));
    final foodJson = jsonDecode(response.body.toString()).cast<Map<String, dynamic>>();

    //
    /* String str1 = foodListJson["NDB_No"].toString();
    data = {
      'tname': '`food_des`',
      //'sel': '`Date Added`, Weight',
      'condition': "NDB_No = $str1 "
    };
    response = await http.post(url, body: json.encode(data));
    final foodJson = jsonDecode(response.body.toString()).cast<Map<String, dynamic>>();

    return DietHistory.fromJsonAll(DietJson,
                  foodListJson, foodJson, FoodNutritionJson, FoodSizeJson,
                  MealListjson, Mealjson, MealListFoodjson, Junctionjson, MealNutJson)
*/
    //Goalresult.map<WeightList>((json) => WeightList.fromJson(json))
           //.toList();
  }
  Future<List<Food>>  getFoodSmall(String search) async {
    data !=null? data.clear():null;
    data =  { 'query': "SELECT `food_des1`.`NDB_No`,`food_des1`.`Long_Desc`,`food_des1`.`Img`,`food_des1`.`Description`,`fd_group`.FdGrp_Desc FROM `food_des` `food_des1` INNER JOIN fd_group ON food_des1.FdGrp_Cd= fd_group.FdGrp_CD WHERE `food_des1`.`Long_Desc` LIKE '% $search %' "};
    url = 'https://pertinent-diagonals.000webhostapp.com/query3.php';
    response = await http.post(url, body: json.encode(data));
    final foodJson = jsonDecode(response.body.toString()).cast<Map<String, dynamic>>();

    return foodJson.map<Food>((json)=> Food.fromJson2(json)).toList();
  }
}
