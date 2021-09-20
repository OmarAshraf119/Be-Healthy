import 'package:date_calendar/date_calendar.dart';
class Age {

  DateTime BirthDate;
  int years;
  String LifeStage;


  Age.fromall(DateTime BirthDate, int years, String LifeStage)
  {
    this.BirthDate = BirthDate;
    this.years = years;
    this.LifeStage = LifeStage;
  }

  Age.fromAge(Age a)
  {
    BirthDate = a.BirthDate;
    years = a.years;
    LifeStage = a.LifeStage;
  }

  Age.froBirth(DateTime BirthDate)
  {
    this.BirthDate = BirthDate;
    years = calcAge(BirthDate);
    LifeStage = calcLifeStage(years);
  }

  Age.fromymd(int year, int month, int day)
  {
    BirthDate = new GregorianCalendar(year, month, day).toDateTimeLocal();
    years = calcAge(BirthDate);
    LifeStage = calcLifeStage(years);
  }
  Age(int time){
    BirthDate = new DateTime.fromMillisecondsSinceEpoch(time);
    years = calcAge(BirthDate);
    LifeStage = calcLifeStage(years);
  }

  DateTime getBirthDate()
  {
    return BirthDate;
  }

  int getYears()
  {
    return years;
  }

  String getLifeStage()
  {
    return LifeStage;
  }

  static String calcLifeStage(int years)
  {
    if (years < 14) {
      return "Child";
    }
    if (years < 18) {
      return "Teen";
    }
    return "Adult";
  }
  static int calcAge(DateTime birthDate){

      DateTime currentDate = DateTime.now();
      int age = currentDate.year - birthDate.year;
      int month1 = currentDate.month;
      int month2 = birthDate.month;
      if (month2 > month1) {
        age--;
      } else if (month1 == month2) {
        int day1 = currentDate.day;
        int day2 = birthDate.day;
        if (day2 > day1) {
          age--;
        }
      }
      return age;
  }
}