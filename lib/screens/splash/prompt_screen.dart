import 'package:flutter/material.dart';
import 'package:laf_1/screens/home/home_screen.dart';
import 'package:laf_1/screens/splash/components/body.dart';
import 'package:laf_1/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PromptScreen extends StatefulWidget {
  static String routeName = "/home";

  const PromptScreen({Key? key}) : super(key: key);

  @override
  State<PromptScreen> createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen> {
  getScreen() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    if(token == null){
      print("token: nf");
    }else{
      print("token: $token");
      Navigator.pushNamed(context, HomeScreen.routeName);
    }
  }

  @override
  void initState() {
    super.initState();
    getScreen();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      body: Body(),
    );
  }
}
