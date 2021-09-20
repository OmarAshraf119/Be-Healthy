import 'package:be_healthy/screens/route_generator.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


   return MaterialApp(

     initialRoute: '/',
     onGenerateRoute: RouteGenerator.generateRoute,
   );
  }
}

