import 'package:be_healthy/nutritionist/Size.dart';

class Serving extends Size {


  Serving.fromall(double value, String unit, String Description):
        super.fromall(value, unit, Description);

  Serving(double value, String unit):    super(value, unit);

  Serving.fromServing(Serving s):super.fromall(s.value, s.unit, s.Description);

  void toMetric()
  {
    if (unit.contains("ml")) {
      return;
    }
    if (unit.contains("cup")) {
      value = (value * 240);
      unit = "ml";
    } else {
      if (unit.contains("tsp")) {
        value = (value * 14.787);
        unit = "ml";
      } else {
        if (unit.contains("tbsp")) {
          value = (value * 4.929);
          unit = "ml";
        }
      }
    }
  }

  void toImperial()
  {
    if (unit.contains("oz")) {
      return;
    }
    if (unit.contains("cup")) {
      value = (value * 8.115);
      unit = "fl oz";
    } else {
      if (unit.contains("tsp")) {
        value = (value / 6);
        unit = "fl oz";
      } else {
        if (unit.contains("tbsp")) {
          value = (value / 1.665);
          unit = "fl oz";
        }
      }
    }
  }

  String getType()
  {
    return "Serving";
  }

  String toString()
  {
    return super.toString();
  }

  void toGrams()
  {
    if (unit.contains("gm")) {
      return;
    }
    if (unit.contains("cup")) {
      value = (value * 150);
      unit = "gm";
    } else {
      if (unit.contains("tsp")) {
        value = (value * 4.2);
        unit = "gm";
      } else {
        if (unit.contains("tbsp")) {
          value = (value * 14.3);
          unit = "gm";
        }
      }
    }
  }
}