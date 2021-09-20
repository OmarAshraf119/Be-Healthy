class Energy
{
  String unit;
  double value;

  Energy(String unit, double value)
  {
    this.unit = unit;
    this.value = value;
  }

  Energy.fromEnergy(Energy e)
  {
    this.unit = e.unit;
    this.value = e.value;
    }

  String getUnit()
  {
    return unit;
  }

  void setUnit(String unit)
  {
    this.unit = unit;
  }

  double getValue()
  {
    return value;
  }

  void setValue(double value)
  {
    this.value = value;
  }

  void toKcal()
  {
    if (unit == "Kcal") {
      return;
    }
    value = (value / 4.184);
    unit = "Kcal";
  }

  void toKj()
  {
    if (unit == "Kj") {
      return;
    }
    value = (value * 4.184);
    unit = "Kj";
  }
}
