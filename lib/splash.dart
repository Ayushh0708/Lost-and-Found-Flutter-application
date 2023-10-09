import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/screens/homepage.dart';
import 'package:my_first_app/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  
  static const String KEYLOGIN ="Login";
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    whereToGo();

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amberAccent[300],
        child: Center(
          child: Text(
            'Lost And found',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
      ),
    );
  }
  
  void whereToGo()async {

    var sharedPref=await SharedPreferences.getInstance();
    var isLoggedIn =sharedPref.getBool(KEYLOGIN);


    Timer(Duration(seconds: 2), () {
      if(isLoggedIn != null){
        if(isLoggedIn){
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home_Page(),
          ));
        }else{
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => login_Page(),
          ));
        }
      }else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => login_Page(),
          ));
      }

      
    });
  }
}
