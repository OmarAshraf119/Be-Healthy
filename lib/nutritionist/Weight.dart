import 'package:be_healthy/nutritionist/Size.dart';

class Weight extends Size
{

  Weight.fromall(double value, String unit, String Description):
        super.fromall(value, unit, Description);

  Weight(double value, String unit):    super(value, unit);

  Weight.fromWeight(Weight w):super.fromall(w.value, w.unit, w.Description);


  void toMetric()
  {
    if (unit.contains("g")) {
      return;
    }
    if ((unit == "lbs") || (unit == "lb")) {
      value = (value / 2.205);
      unit = "kg";
    } else {
      value = (value * 28.35);
      unit = "gm";
    }
  }

  void toImperial()
  {
    if (unit.contains("lb") || unit.contains("oz")) {
      return;
    }
    if (unit.contains("kg")) {
      value = (value * 2.205);
      unit = "lbs";
    } else {
      value = (value / 28.35);
      unit = "oz";
    }
  }

  String getType()
  {
    return "Weight : ";
  }

  String toString()
  {
    return super.toString();
  }
}