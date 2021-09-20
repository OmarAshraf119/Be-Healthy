import 'package:be_healthy/nutritionist/Size.dart';

class Height extends Size {

  Height.fromall(double value, String unit, String Description):
        super.fromall(value, unit, Description);

  Height(double value, String unit):    super(value, unit);

  Height.fromHeight(Height w):super.fromall(w.value, w.unit, w.Description);
  void toMetric()
  {
    if (unit.contains("m")) {
      return;
    }
    if (unit.contains("in")) {
      value = (value * 2.254);
      unit = "cm";
    } else {
      value = (value / 3.281);
      unit = "m";
    }
  }

  void toImperial()
  {
    if (unit.contains("in") || unit.contains("f")) {
      return;
    }
    if (unit == "cm") {
      value = (value / 2.254);
      unit = "in";
    } else {
      value = (value * 3.281);
      unit = "ft";
    }
  }

  String getType()
  {
    return "Height";
  }

  String toString()
  {
    return super.toString();
  }

}