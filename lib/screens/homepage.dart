import 'package:flutter/material.dart';

class Home_Page extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lost&Found"),
        backgroundColor: const Color.fromARGB(255, 8, 60, 150),
        
        
      ),
      body: Center(
        child: Container (
          child: Text("Welcome to UPES's Lost and found App"),
          
          
          
        ),
      ),
      drawer: Drawer(),
      
    );
  }

  
  
}