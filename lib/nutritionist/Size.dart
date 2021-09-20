abstract class Size
{
  double value;
  String unit;
  String Description;

  void toMetric();

  void toImperial();

  String getType();

  Size(double value, String unit)
  {
    this.value = value;
    this.unit = unit.toLowerCase();
    this.Description = "No Description";

  }
  Size.fromall(double value, String unit, String Description)
  {
    this.value = value;
    this.unit = unit.toLowerCase();
    this.Description = Description;

  }

  Size.fromSize(Size s)
  {
    this.value = s.value;
    this.unit = s.unit.toLowerCase();
    this.Description = s.Description;

  }

  double getValue()
  {
    return value;
  }

  void setValue(double value)
  {
    this.value = value;

  }

  String getUnit()
  {
    return unit;
  }

  void setUnit(String unit)
  {
    this.unit = unit.toLowerCase();

  }

  String getDescription()
  {
    return Description;
  }

  void setDescription(String Description)
  {
    this.Description = Description;

  }

  @override
  String toString()
  {
    return getType() + " "+ value.toString() + " " +unit;
  }

}