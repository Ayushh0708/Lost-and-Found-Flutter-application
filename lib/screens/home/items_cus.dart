import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:laf_1/constants.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:laf_1/screens/home/detailspage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'components/gesturebox.dart';
import 'package:http/http.dart' as http;

class Items extends StatefulWidget {
  final TextEditingController searchController;
  const Items({Key? key, required this.searchController}) : super(key: key);

  @override
  State<Items> createState() => _ItemsState();
}

const TextStyle ktextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: 'Caveat',
    letterSpacing: 1.15,
    color: Colors.black87);

class _ItemsState extends State<Items> {
  static const _pageSize = 20;
  final List<Map<String, dynamic>> ITEMS = [];


  getItems(int page) async {
    try {
      Map<String, Object> body = {"page": page, "count": _pageSize};
      // if(query.isNotEmpty){
      //   body['query'] = query;
      // }
      final res = await http.post(
        Uri.parse("$API_URL/item/search"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body),
      );
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        // return data['items'];
      } else {
        // return Future.error("Status code not 200");
      }
    } catch (e) {
      print(e);
      // return Future.error(e);
    }
    setState(() {});
    // final ListResult result = await storage.ref('lost_items/').list();
    // final List<Reference> allFiles = result.items;

    // await Future.forEach<Reference>(allFiles, (file) async {
    //   final String fileUrl = await file.getDownloadURL();
    //   final FullMetadata fileMeta = await file.getMetadata();
    //   files.add({
    //     "url": fileUrl,
    //     "item_name": fileMeta.customMetadata?['item_name'] ?? 'no name',
    //     "uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? 'No uploader',
    //     "contact_info": fileMeta.customMetadata?['contact_info'] ?? 'No info',
    //     "description":
    //         fileMeta.customMetadata?['description'] ?? 'No description'
    //   });
    // });

    // return files;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getItems(1);
  }
  

  @override
  Widget build(BuildContext context) {
    // widget.searchController.addListener(() {
    //   print("searchCOntroller: ${widget.searchController.text}");
    // });
    return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Center(
          child: ListView.separated(
            itemBuilder: (context,index){
              return Container(
                child: Text(ITEMS[index]['name']),
              );
            },
            separatorBuilder: ((context, index) => const SizedBox(height: 10,)),
            itemCount: ITEMS.length
          )
        ));
  }

 
}
