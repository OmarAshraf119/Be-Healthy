import 'package:be_healthy/nutritionist/Food.dart';
import 'package:be_healthy/services/database.dart';
import 'package:flutter/material.dart';

class SearchDB extends StatefulWidget {
  SearchDB({Key key}) : super(key: key);
  @override
  SearchDBState createState() => SearchDBState();
}

class SearchDBState extends State<SearchDB> {
  List<Food> foodList = List<Food>();
  final focus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          children: <Widget>[
          Padding(
             padding: const EdgeInsets.all(18.0),
              child: TextField(
                focusNode: focus,
                onTap: (){
                  if(foodList!=null)
                    if(foodList.length>0)
                      setState(() {
                        foodList.clear();
                      });
                },
                onSubmitted: (values) async {
                  try {
                    List<Food> fdl = await DatabaseService().getFoodSmall(
                        values);
                    fdl.forEach((f) => print(f.Name));
                    setState(() {
                      foodList.addAll(fdl);
                    });
                  }catch (e){
                    print ("connection error : " +e);
                  }
                },
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)))),

      ),
        ),
         Expanded(

                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: foodList?.length ??0,
                    itemBuilder: (context,index){
                      return ListTile(
                        leading: CircleAvatar(radius: 20,
                          backgroundImage: AssetImage('assets/bg8.jpg'),
                          backgroundColor: Colors.orangeAccent,),
                        title: Text(
                          foodList.elementAt(index).Name.toString(),
                        ),
                        subtitle: Text("Food group : "+  foodList.elementAt(index).Group,
                        )
                      );
                    }

    )),
         //   SizedBox(height: 200,),
          ]));
  }
}
