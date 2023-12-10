import 'package:flutter/material.dart';
import 'package:laf_1/constants.dart';
import 'package:laf_1/screens/sign_in/sign_in_screen.dart';
import 'package:laf_1/size_config.dart';


import '../components/splash_content.dart';
import '../../../components/default_button.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0,bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Image.asset("assets/images/logo.png",
                height: 100, width: double.infinity),
            Column(
              children: [
                Image.asset("assets/images/splash.png",
                    height: 200, width: double.infinity),
                    Text("We are searching for\nyour lost items",style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),textAlign: TextAlign.center,)
              ],
            ),
            Image.asset("assets/images/upes.png",
                height: 50,
                width: double.infinity,
                ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
