import 'package:flutter/material.dart';
import 'package:laf_1/constants.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';

TextStyle ktextStyle = GoogleFonts.lato(
    textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
        letterSpacing: 1.15,
        color: Colors.black87));

// ignore: must_be_immutable
class DetailPage extends StatelessWidget {
  List imgUrls;
  String itemName;
  String foundby;
  String contact;
  String des;
  DetailPage(
      {Key? key,
      required this.imgUrls,
      required this.itemName,
      required this.foundby,
      required this.contact,
      required this.des})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("${this.itemName}");
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Expanded(
            child: Card(
              // Set the shape of the card using a rounded rectangle border with a 8 pixel radius
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              // Set the clip behavior of the card
              clipBehavior: Clip.antiAliasWithSaveLayer,
              // Define the child widgets of the card
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Display an image at the top of the card that fills the width of the card and has a height of 160 pixels
                  CarouselSlider(
                    options: CarouselOptions(height: 300.0),
                    items: imgUrls.map((url) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(color: Colors.amber),
                            // child: Image.network()
                            child: Expanded(
                          flex: 1,
                          child: Image.network(
                            "$API_URL/image/$url",
                            fit: BoxFit.cover,
                          ),
                        ),
                          );
                        },
                      );
                    }).toList(),
                  )
,
                  // Image.network(
                  //   ,
                  //   height: 160,
                  //   width: double.infinity,
                  //   fit: BoxFit.cover,
                  // ),
                  // Add a container with padding that contains the card's title, text, and buttons
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Display the card's title using a font size of 24 and a dark grey color
                        Text(
                          itemName!,
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.grey[800],
                          ),
                        ),
                        // Add a space between the title and the text
                        Container(height: 5),
                        // Display the card's text using a font size of 15 and a light grey color
                        Text(
                          des!,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                          ),
                        ),
                        Container(height: 20),
                        Text(
                          "Founded By: $foundby",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(
                          "Contact Number: $contact",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
                          ),
                        ),
                        // Add a row with two buttons spaced apart and aligned to the right side of the card
                      ],
                    ),
                  ),
                  // Add a small space between the card and the next widget
                  Container(height: 5),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  primary: Colors.white,
                  backgroundColor: kPrimaryColor,
                ),
                onPressed: () async {
                  await FlutterPhoneDirectCaller.callNumber(contact!);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Call Now",
                      style: TextStyle(fontSize: 25.0),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Icon(
                      Icons.call,
                      size: 25.0,
                    ),
                  ],
                )),
          )
        ],
      )),
    );
  }
}
