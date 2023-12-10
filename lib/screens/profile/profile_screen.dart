import 'package:flutter/material.dart';

// import 'package:firebase_storage/firebase_storage.dart';
import 'package:laf_1/components/coustom_bottom_nav_bar.dart';
import 'package:laf_1/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileItem extends StatefulWidget {
  static String routeName = "/profile";
  const ProfileItem({Key? key}) : super(key: key);

  @override
  State<ProfileItem> createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfileItem> {
  double profileHeight = 170;
  double coverHeight = 200;
  String name = "-";
  String email = "-";


  setData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("name") ?? '-';
      email = prefs.getString("username") ?? '-';
    });
    
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.profile),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  color: Colors.amber,
                  height: coverHeight,
                  width: double.infinity,
                ),
                Positioned(
                  top: coverHeight - (profileHeight/2),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: profileHeight/2,
                    child: CircleAvatar(
                      radius: (profileHeight/2)-7,
                      backgroundImage: AssetImage("assets/images/profile.jpg"),
                  ),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, profileHeight/2, 0, 0),
              child: Column(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 15
                    )
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
