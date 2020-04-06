import 'package:flutter/material.dart';
import 'package:ffo/screens/home.dart';
import 'package:ffo/screens/recipes.dart';
import 'package:ffo/screens/recipeDetails.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      title: 'FFO',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: const Color(0xffEF383F),
      ),
      initialRoute: '/',
   //   home: MyHomePage(title: 'FFO'),
      routes: {
        '/': (context) => MyHomePage(title: 'FFO'),
   //     'recipes': (context) => Recipes(),
      },
    );
  }
}


