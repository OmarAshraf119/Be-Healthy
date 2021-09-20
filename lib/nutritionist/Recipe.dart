class Recipe
{
  String Desription;
  Duration duration;

  Recipe()
  {
    Desription = "";
    duration = Duration(hours: 0);
  }

  Recipe.fromDesc({this.Desription,this.duration});


  Recipe.fromRecipe(Recipe r)
  {
    this.Desription = r.Desription;
    this.duration = r.duration;
  }

  String getDesription()
  {
    return Desription;
  }

  void setDesription(String Desription)
  {
    this.Desription = Desription;
  }

  Duration getDuration()
  {
    return duration;
  }

  void setDuration(Duration duration)
  {
    this.duration = duration;
  }
}