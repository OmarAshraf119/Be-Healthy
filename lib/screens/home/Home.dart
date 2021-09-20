import 'package:be_healthy/nutritionist/Food.dart';
import 'package:be_healthy/nutritionist/User.dart';
import 'package:be_healthy/screens/home/search.dart';
import 'package:be_healthy/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatelessWidget {
  final User user;
  Home({Key key,  @required this.user,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    /*return Container(
      child:  Text(
          "Home " + user.Name + "  " + user.goal.weight.toString()
      ),
    );*/
     return MaterialApp(
        home: DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: AppBar(title: Text("Be Healthy"),
                        bottom: TabBar(
                        tabs: [
                          Tab(icon: Icon(Icons.calendar_today,)),
                          Tab(icon: Icon(Icons.fastfood)),
                          Tab(icon: Icon(Icons.history)),
                          Tab(icon: Icon(Icons.outlined_flag)),
                          ],
                        ),
                backgroundColor: Colors.orange[600],
                    ),
                      body: Container(child:TabBarView(
                          children: [
                           // Icon(Icons.directions_car),
                            _getHome(),
                            //Icon(Icons.directions_transit),
                            _getFood(),
                            //Icon(Icons.directions_bike),
                            _historyPane(),
                           // Icon(Icons.outlined_flag)
                            _goalPane(),
                      ]),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/bg6.jpg'),
                            //alignment: Alignment.bottomLeft,
                            fit: BoxFit.fill,
                            // fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
              drawer: _createDrawer(context),

            ),

            )
        );
     //);
  }
  Widget _createDrawerItem({IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
  Widget _createDrawer(BuildContext context){
    return  Drawer(
        child:ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: ListView(
                children: <Widget>[
                  ListTile(
                      title: Row(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.zero,
                                child:  Icon(Icons.person,size: 40,))]
                      ),
                      subtitle: Padding(
                        child: Text('Hi ,\n'+user.Name,style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),),
                        padding:EdgeInsets.only(left: 10) , )
                  )

                ],
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/hh.jpeg'),
                  fit: BoxFit.fill,
                ),
                color: Colors.blue,
              ),

            ),
            _createDrawerItem(icon: Icons.subdirectory_arrow_left,text: "Log Out",onTap: ()=> 
                Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false)),
          /*  ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),*/
          ],
        )

    );
  }
  Widget _historyPane(){
      return Container(
        child:  ListView.builder(
      itemCount: user.wtList ?.length ??0,
          itemBuilder: (context,index){
            return ListTile(
              title: Text(
                user.wtList.elementAt(index).weight.toString(),
              ),
              subtitle: Text(user.wtList.elementAt(index).dateAdded.toString()),
            );
          }
        /*ListView(
          children: <Widget>[
            ListTile(
              title: Text(
                user.wtList.elementAt(0).weight.toString(),
              ),
              subtitle: Text(user.wtList.elementAt(0).dateAdded.toString()),
            )
          ],
        ),*/
      ));
  }
  Widget _goalPane(){
    return Container(
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20,),
          Text("Target",style: TextStyle(fontSize: 30,fontStyle: FontStyle.italic),),
          SizedBox(height: 20,),
          Padding(
              padding: const EdgeInsets.all(20.0),
               child: Table(

                   border: TableBorder.all(width: 2.0,style: BorderStyle.solid, color: Colors.black),
                   children: [
                      TableRow(children: [
                    TableCell(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                 new Text("Weight :"),
                                 new Text(user.goal.weight.value.round().toString()),
                              ],
                    ),
                  )
                  ]),
                     TableRow(children: [
                       TableCell(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: <Widget>[
                             new Text("BMI :"),
                             new Text(user.goal.Bmi.value.round().toString()),
                           ],
                         ),
                       )
                     ]),
                     TableRow(children: [
                       TableCell(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: <Widget>[
                             new Text("Energy :"),
                             new Text(user.goal.energy.value.round().toString()+" Kcal/day"),
                           ],
                         ),
                       )
                     ]),
                     TableRow(children: [
                       TableCell(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: <Widget>[
                             new Text("Protein :"),
                             new Text(user.goal.nutrients["Protein (g)"].round().toString()+" Gm/day"),
                           ],
                         ),
                       )
                     ]),
                     TableRow(children: [
                       TableCell(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: <Widget>[
                             new Text("Calcium :"),
                             new Text(user.goal.nutrients["Calcium (mg)"].round().toString()+" mg/day"),
                           ],
                         ),
                       )
                     ]),
                     TableRow(children: [
                       TableCell(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: <Widget>[
                             new Text("Fats :"),
                             new Text(user.goal.nutrients["Fat (g) min"].round().toString()+" <--> "+
                                 user.goal.nutrients["Fat (g) max"].round().toString()+" g/day"),
                           ],
                         ),
                       )
                     ]),
                     TableRow(children: [
                       TableCell(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: <Widget>[
                             new Text("Carbs :"),
                             new Text(user.goal.nutrients["Carbohydrates (g) min"].round().toString()+" <--> "+
                                 user.goal.nutrients["Carbohydrates (g) max"].round().toString()+" g/day"),
                           ],
                         ),
                       )
                     ]),

        ])
      )
      ,
    ]));
  }
  Widget _getHome(){
    return Container(
        child:  ListView(
          children: <Widget>[
            ListTile(
              title: Text(
                user.Name.toString(),
              ),
              subtitle: Text("Age: "+user.age.years.toString()+" years old" + "\n"+
                              "Life stage: "+user.age.LifeStage),
              isThreeLine: true,
            ),
            ListTile(
              title: Text(
                user.weight.toString(),
              ),
                   subtitle: Text("Body type : "+user.Bmi.BodyType+"\nBMI: "+user.Bmi.value.round().toString()),
              isThreeLine: true,
            ),

          ],

      /*ListView.builder(
            itemCount: user.wtList ?.length ??0,
            itemBuilder: (context,index){
              return ListTile(
                title: Text(
                  user.weight.toString(),
                ),
                subtitle: Text("Body type : "+user.Bmi.BodyType),
              );
            }*/
          /*ListView(
          children: <Widget>[
            ListTile(
              title: Text(
                user.wtList.elementAt(0).weight.toString(),
              ),
              subtitle: Text(user.wtList.elementAt(0).dateAdded.toString()),
            )
          ],
        ),*/
        ));
  }
  Widget _getFood(){

    return  SearchDB();
    /* Container(
      child: Column(
          children: <Widget>[
             Padding(
            padding: const EdgeInsets.all(18.0),
                child: TextField(
                  onSubmitted: (values) async {
                    List<Food> fdl = await DatabaseService().getFoodSmall(values);
                    fdl.forEach((f)=>print(f.Name));
                  },
                  decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),

                ),
    ),

              ]
      ));*/
    }
}
