import 'package:flutter/material.dart';
import 'package:laf_1/screens/home/home_screen.dart';
import 'package:laf_1/screens/sign_in/sign_in_screen.dart';
import 'package:laf_1/screens/splash/components/body.dart';
import 'package:laf_1/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PromptScreen extends StatefulWidget {
  static String routeName = "/prompt";

  const PromptScreen({Key? key}) : super(key: key);

  @override
  State<PromptScreen> createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen> {

  @override
  void initState() {
    super.initState();

    // Add a delay of 2 seconds before navigating to the next screen
    Future.delayed(Duration(seconds: 2), () {
      // Navigate to the next screen
      Navigator.pushNamed(
        context,
        SignInScreen.routeName
      );
    });
  }



  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      body: Body(),
    );
  }
}
