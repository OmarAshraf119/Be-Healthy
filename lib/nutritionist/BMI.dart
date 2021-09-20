import 'package:be_healthy/nutritionist/Height.dart';
import 'package:be_healthy/nutritionist/Weight.dart';

class BMI
{
  double value;
  String BodyType;

  BMI.fromType(double value, String BodyType)
  {
    this.value = value;
    this.BodyType = BodyType;
  }

  BMI.fromValue(double value)
  {
    this.value = value;
    this.BodyType = calcBodyType(value);
  }

  BMI(Weight w, Height h)
  {
    value = calcValue(w, h);
    BodyType = calcBodyType(value);
  }

  BMI.fromBMI(BMI b)
  {
    this.value = b.value;
    this.BodyType = b.BodyType;
  }

  void setBodyType(double value)
  {
    BodyType = calcBodyType(value);
  }


  double getValue()
  {
    return value;
  }
  void setValue(Weight w, Height h)
  {
    value = calcValue(w, h);
  }

  String getBodyType()
  {
    return BodyType;
  }

  static double calcValue(Weight w, Height h)
  {
    w.toMetric();
    h.toMetric();
    double wt = w.getValue();
    double H = 1;
    if (h.getUnit() == "cm") {
      H = (h.getValue() / 100);
    } else {
      H = h.getValue();
    }
    return wt / (H * H);
  }

  static String calcBodyType(double value)
  {
    if (value < 16) {
      return "Severe Thinness";
    } else {
      if (value < 17) {
        return "Moderate Thinness";
      } else {
        if (value < 18.5) {
          return "Mild Thinness";
        } else {
          if (value <= 25) {
            return "Normal";
          } else {
            if (value < 30) {
              return "Overweight";
            } else {
              if (value < 35) {
                return "Obese Class I";
              } else {
                if (value <= 40) {
                  return "Obese Class II";
                } else {
                  return "Obese Class III";
                }
              }
            }
          }
        }
      }
    }
  }
  static String backToNormal(BMI b, Height h)
  {
    h.toMetric();
    double H = 1;
    if (h.getUnit() == "cm") {
      H = (h.getValue()/ 100);
    } else {
      H = h.getValue();
    }
    double wtneed = 0;
    double wtfinal = 0;
    if (b.value < 18.5) {
      wtneed = (((18.5 - b.value) * H) * H);
      wtfinal = ((18.5 * H) * H);
      return "You Will Need To Gain " + wtneed.toString() + " Kg To Reach Normal BMI Of 18.5 "
                + " & Weight " + wtfinal.toString() + " Kg";
    }
    if (b.value > 25) {
      wtneed = (((b.value - 25) * H) * H);
      wtfinal = ((25 * H) * H);
      return ((((("You Will Need To Lose " + wtneed.toString()) + " Kg To Reach Normal BMI Of ")
          + "25") + " & Weight ") + wtfinal.toString()) + " Kg";
    }
    if ((b.value >= 18.5) && (b.value <= 25)) {
      wtneed = ((18.5 * H) * H);
      wtfinal = ((25 * H) * H);
      return ((((((("You Are At Normal Range For This Height BMI( " + "18.5") + "-") + "25")
          + " ) & Weight( ") + wtneed.toString()) + " Kg - ") + wtfinal.toString()) + " Kg)";
    }
    return "Error";
  }

  static double backToNormalWt(BMI b, Height h)
  {
    h.toMetric();
    double H = 1;
    if (h.getUnit() == "cm") {
      H = (h.getValue() / 100);
    } else {
      H = h.getValue();
    }
    double wtneed = 0;
    if (b.value < 18.5) {
      wtneed = (((18.5 - b.value) * H) * H);
      return wtneed;
    }
    if (b.value > 25) {
      wtneed = (((b.value - 25) * H) * H);
      return wtneed;
    }
    if ((b.value >= 18.5) && (b.value <= 25)) {
      return 0;
    }
    return -1;
  }

  static double nextCategoryWt(BMI b, Height h)
  {
    h.toMetric();
    double H = 1;
    if (h.getUnit() == "cm") {
      H = (h.getValue() / 100);
    } else {
      H = h.getValue();
    }
    double wt = 0;
    if (b.value < 16) {
      return (16 * H) * H;
    } else {
      if (b.value < 17) {
        return (17 * H) * H;
      } else {
        if (b.value < 18.5) {
          return (18.5 * H) * H;
        } else {
          if (b.value <= 25) {
            return (22 * H) * H;
          } else {
            if (b.value < 30) {
              return (25 * H) * H;
            } else {
              if (b.value < 35) {
                return (30 * H) * H;
              } else {
                if (b.value <= 40) {
                  return (35 * H) * H;
                } else {
                  return (40 * H) * H;
                }
              }
            }
          }
        }
      }
    }
  }

  String toString()
  {
    return (("BMI: " + value.toString()) + " Type: ") + BodyType;
  }
}