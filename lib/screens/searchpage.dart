import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_first_app/utils/globals.dart';
import 'dart:convert';

class Search_Page extends StatefulWidget {
  Search_Page({super.key});

  @override
  State<Search_Page> createState() => _Search_PageState();
}

class _Search_PageState extends State<Search_Page> {
  String query = "";
  String username = "";
  bool isLoadingItems = false;
  bool hasMore = false;
  int page = 1;
  int maxCount = 10;

  List items = [];

  Future getItems() async {
    print("sending");
    isLoadingItems = true;
    http.Response response = await http.post(Uri.parse("${GlobalValues.API_URL}/item/search/"), body: {
      "query": query,
      "category": "",
      "page": page.toString(),
      "count": maxCount.toString()
    });

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      // print(body);
      if (body['status'] == true) {
        body['items'].forEach((item) => {items.add(item)});

        isLoadingItems = false;
        page = page + 1;
        hasMore = body['items'].isEmpty ? false : true;
        setState(() {});
      }
    }
  }
  @override
  void initState(){
    super.initState();
    // query = ModalRoute.of(context)!.settings.arguments as String;
    getItems();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lost&Found - Search"),
        backgroundColor: const Color.fromARGB(255, 8, 60, 150),
      ),
      body: SafeArea(
        top: true,
        child: GridView.custom(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            (BuildContext context,int index){
                print("$index == ${items.length} && $hasMore && $isLoadingItems && $page");
                if(index == items.length && hasMore && !isLoadingItems){
                  getItems();
                  return const SizedBox(
                    height: 30,
                    width: 30,
                    child: FittedBox(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return GestureDetector(
                  child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color:
                              Colors.white,
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                // "$url/image/${items[index]['images'][0]}",
                                "https://picsum.photos/seed/476/600",
                                width: 300,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.00, 1.00),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(9),
                                    bottomRight: Radius.circular(9),
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(0),
                                  ),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 2,
                                      sigmaY: 2,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5, 5, 5, 5),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(),
                                        child: Text(
                                          items[index]['name'],
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  onTap: (){
                    print('Tapped on category #$index: ${items[index]}');
                  },
                );
              },
              childCount: items.length+ (hasMore ? 1 : 0),
          ),
        ),
      ),
      drawer: const Drawer(),
    );
  }
}
