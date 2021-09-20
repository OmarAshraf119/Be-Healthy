import 'package:be_healthy/nutritionist/Meal.dart';

class FavMeal
{
  List<Meal> meal;

  FavMeal()
  {
    this.meal = new List<Meal>();
  }

  FavMeal.fromList(List<Meal> meal)
  {
    this.meal =(meal);
  }

  FavMeal.fromFav(FavMeal f)
  {
    this.meal =  (f.meal);

  }
  FavMeal.fromJson(var json){
   meal = json.map((item) {
    return Meal.fromJson(item);
    }).toList;
  }
 /* FavMeal.fromJsonAll(Map<String,dynamic>Mealjson,
                      var Foodjson,Map<String,dynamic>Junctionjson,
                      Map<String,dynamic> NutJson){

    meal = Mealjson.
  }*/
  Map<String, dynamic> toJson(){
    List<Map<String, dynamic>> x = meal.map((f) => f.toJson()).toList();
    Map<String, dynamic> map() => {'meal': x};
    return map();
  }


  FavMeal_(Object Id)
  {
   // Load(Id);
  }

  List<Meal> getMeal()
  {
    return meal;
  }

  Meal getMealfromIndex(int i)
  {
    return meal.elementAt(i);
  }

  void setMeal(List<Meal> meal)
  {
    this.meal = meal;

  }

  void addMeal(Meal m)
  {
    meal.add(m);
  }

  void removeMeal(Meal m)
  {
    meal.remove(m);
  }

  void clear()
  {
    meal.clear();
  }

}