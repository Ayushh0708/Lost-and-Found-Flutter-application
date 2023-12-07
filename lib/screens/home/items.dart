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
  final PagingController<int, dynamic> _pagingController =
      PagingController(firstPageKey: 1);
  static const _pageSize = 10;

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener((pageKey) {
      fetchNewPage(pageKey);
    });

    print("initState");
  }

  Future getItems(int page) async {
    // List<Map<String, dynamic>> files = [];
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

      print(body);
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return data['items'];
      } else {
        return Future.error("Status code not 200");
      }
    } catch (e) {
      print(e);
      return Future.error(e);
    }
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

  fetchNewPage(int page) async{
    try {
      final newItems = await getItems(page);
      if(newItems.isEmpty){
        _pagingController.appendLastPage(newItems);
      }else{
        _pagingController.appendPage(newItems, ++page);
      }
      print(newItems);
    } catch (e) {
      _pagingController.error = e;
    }
    
  }

  @override
  Widget build(BuildContext context) {
    // widget.searchController.addListener(() {
    //   print("searchCOntroller: ${widget.searchController.text}");
    // });
    return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Center(
          child: PagedGridView(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<dynamic>(
              itemBuilder: (context, item, index){
                return card(
                    item['name'], "$API_URL/image/${item['images'][0]}");
              }
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // number of items in each row
              mainAxisSpacing: 0.0, // spacing between rows
              crossAxisSpacing: 0.0, // spacing between columns
            )
          )
        ));
  }

  Widget card(String name, String imageUrl) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(
        horizontal: 25.0,
        vertical: 25.0,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 25.0,
        vertical: 25.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          5.0,
        ),
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: Column(
        children: [
          //
          Image.network(
            imageUrl,
            width: 64,
          ),
          //
          SizedBox(
            height: 12.0,
          ),
          //
          Text(
            name,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }
}
