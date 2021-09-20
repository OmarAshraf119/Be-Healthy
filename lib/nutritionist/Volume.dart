import 'package:be_healthy/nutritionist/Size.dart';

class Volume extends Size {

  Volume.fromall(double value, String unit, String Description):super.fromall(value,unit,Description);

  Volume(double value, String unit): super(value,unit);

  Volume.fromVolume(Volume v):super.fromall(v.value, v.unit, v.Description);


  void toMetric()
  {
    if (unit.contains("ml") || unit.contains("milli")) {
      return;
    }
    if (unit.contains("oz")) {
      value = (value * 29.574);
      unit = "ml";
    }
  }

  void toImperial()
  {
    if (unit.contains("oz")) {
      return;
    }
    if (unit.contains("ml") || unit.contains("milli")) {
      value = (value / 29.574);
      unit = "fl oz";
    }
  }

  String getType()
  {
    return "Volume";
  }

  String toString()
  {
    return super.toString();
  }
}
