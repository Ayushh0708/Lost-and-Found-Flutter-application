// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:laf_1/constants.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// import 'package:laf_1/screens/home/detailspage.dart';
// import 'components/gesturebox.dart';
// import 'package:http/http.dart' as http;

// class Items extends StatefulWidget {
//   final TextEditingController searchController;
//   const Items({Key? key, required this.searchController}) : super(key: key);

//   @override
//   State<Items> createState() => _ItemsState();
// }

// const TextStyle ktextStyle = TextStyle(
//     fontSize: 16,
//     fontWeight: FontWeight.w400,
//     fontFamily: 'Caveat',
//     letterSpacing: 1.15,
//     color: Colors.black87);

// class _ItemsState extends State<Items> {
//   // FirebaseStorage storage = FirebaseStorage.instance;
//   // TODO: Retriew the uploaded images
//   // This function is called when the app launches for the first time or when an image is uploaded or deleted
//   final List<Map<String, dynamic>> FILES = [];

//   Future<bool> getItems(String query,int page, int count) async {
//     try {
//       Map<String, Object> body = {
//         "page": page,
//         "count": count
//       };
//       if(query.isNotEmpty){
//         body['query'] = query;
//       }
//       final res = await http.post(
//         Uri.parse("$API_URL/item/search"),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(body),
//       );
//       if(res.statusCode == 200){
//         final data = jsonDecode(res.body);
//         print(data);
//         return true;
//       }else{
//         return false;
//       }
//     } catch (e) {
//       print(e);
//       return false;
//     }
//     // final ListResult result = await storage.ref('lost_items/').list();
//     // final List<Reference> allFiles = result.items;

//     // await Future.forEach<Reference>(allFiles, (file) async {
//     //   final String fileUrl = await file.getDownloadURL();
//     //   final FullMetadata fileMeta = await file.getMetadata();
//     //   files.add({
//     //     "url": fileUrl,
//     //     "item_name": fileMeta.customMetadata?['item_name'] ?? 'no name',
//     //     "uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? 'No uploader',
//     //     "contact_info": fileMeta.customMetadata?['contact_info'] ?? 'No info',
//     //     "description":
//     //         fileMeta.customMetadata?['description'] ?? 'No description'
//     //   });
//     // });

//     // return files;
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     widget.searchController.addListener(() {
//       print("searchCOntroller: ${widget.searchController.text}");
//     });
//     return Padding(
//       padding: const EdgeInsets.only(top: 20.0),
//       child: SizedBox(
//         child: FutureBuilder(
//           // future: _loadImages(),
//           builder:
//               (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               return GridView.builder(
//                 scrollDirection: Axis.vertical,
//                 primary: false,
//                 shrinkWrap: true,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2),
//                 itemCount: snapshot.data?.length ?? 0,
//                 itemBuilder: (context, index) {
//                   final Map<String, dynamic> image = snapshot.data![index];

//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: ((context) => DetailPage(
//                                     imgUrl: image['url'],
//                                     itemName: image['item_name'],
//                                     foundby: image['uploaded_by'],
//                                     contact: image['contact_info'],
//                                     des: image['description'],
//                                   ))));
//                     },
//                     child: Container(
//                         margin: const EdgeInsets.all(3),
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade200,
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Flexible(
//                                 flex: 4,
//                                 child: Image.network(
//                                   image['url'],
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                               Flexible(
//                                 flex: 1,
//                                 child: Row(
//                                   children: [
//                                     Flexible(
//                                       child: Padding(
//                                         padding:
//                                             const EdgeInsets.only(left: 11.0),
//                                         child: Text(
//                                           image['item_name'],
//                                           style: ktextStyle,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )),
//                   );
//                 },
//               );
//             }
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
