class Account
{
  String ID;
  String Name;
  String Password;
  String Img;


  Account({this.ID,this.Name,this.Password,this.Img});
  Account.fromall({this.Name,this.Password,this.Img});
  Account.fromJson(Map<String, dynamic> data)
      : Name = data['Userame'],
        ID = data['ID'],
        Img = data['Img'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserName'] = this.Name;
    data['ID'] = this.ID;
    data['Img'] = this.Img;
    return data;
  }
  String getImg()
  {
    return Img;
  }

  void setImg(String Img)
  {
    this.Img = Img;
  }

  String getName()
  {
    return Name;
  }

  void setName(String Name)
  {
    this.Name = Name;
  }

  String getPassword()
  {
    return Password;
  }

  void setPassword(String Password)
  {
    this.Password = Password;
  }
}