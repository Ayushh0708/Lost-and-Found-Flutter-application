import 'package:flutter/material.dart';
import 'package:my_first_app/screens/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_first_app/screens/searchpage.dart';
import 'package:my_first_app/screens/signup.dart';
import 'package:my_first_app/splash.dart';
import 'package:my_first_app/utils/routes.dart';
import 'package:my_first_app/screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        fontFamily: GoogleFonts.lato().fontFamily
        ),
      initialRoute: Myroutes.homepage,
      darkTheme:ThemeData(brightness:Brightness.light),
      routes: {
        Myroutes.loginpage:(context)=> const login_Page(),
        Myroutes.homepage:(context)=> Home_Page(),
        Myroutes.signup:(context) => const signup(),     
        Myroutes.searchpage:(context) => Search_Page()
      },
      );


  }
}
