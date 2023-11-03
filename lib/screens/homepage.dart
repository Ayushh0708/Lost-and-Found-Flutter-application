import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_first_app/screens/searchpage.dart';
import 'package:my_first_app/utils/globals.dart';
import 'package:my_first_app/utils/routes.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


class Home_Page extends StatefulWidget{
  Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  String token = "";
  String username = "";
  List categories = [];

  Future apiCall() async{
    http.Response response;
    response = await http.get(
      Uri.parse("${GlobalValues.API_URL}/category/")
    );
    if(response.statusCode == 200){
      var body = json.decode(response.body);
      if(body['status'] == true){
        setState(() {
          categories = body['categories'];
        });
      }
    }
  }

  void ItemTapCallback(BuildContext ctx,String name) async {
   Navigator.pushNamed(ctx, Myroutes.searchpage,arguments: name);
  }

  @override
  void initState(){
    apiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lost&Found"),
        backgroundColor: const Color.fromARGB(255, 8, 60, 150),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.custom(childrenDelegate: SliverChildBuilderDelegate(
          (BuildContext context,int index){
            return GestureDetector(
              child: Card(
                color: Colors.lightBlueAccent,
                 child: Padding(
                  child: Text(categories[index]['name']),
                  padding: EdgeInsets.all(50),
                 ),
              ),
              onTap: (){
                ItemTapCallback(context,categories[index]['name']);
                // print('Tapped on category #$index: ${categories[index]}');
              },
            );
          },
          childCount: categories.length
        ))
      ),





      drawer: const Drawer(),
      
    );
  }
}