import 'package:flutter/material.dart';
import 'package:laf_1/screens/home/items.dart';

import '../../../size_config.dart';
import 'home_header.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          HomeHeader(searchController: searchController),
          SizedBox(height: getProportionateScreenHeight(20)),
          Container(
            height: MediaQuery.of(context).size.height,
            child: Items(searchController: searchController),
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
        ],
      ),
    );
  }
}
