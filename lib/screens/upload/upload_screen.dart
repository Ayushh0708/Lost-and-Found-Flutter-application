import 'package:flutter/material.dart';
import 'package:laf_1/constants.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';

// import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:laf_1/components/coustom_bottom_nav_bar.dart';
import 'package:laf_1/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

const kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

class UploadItem extends StatefulWidget {
  static String routeName = "/upload";
  const UploadItem({Key? key}) : super(key: key);

  @override
  State<UploadItem> createState() => _UploadItemState();
}

class _UploadItemState extends State<UploadItem> {
  // FirebaseStorage storage = FirebaseStorage.instance;
  String? title;
  String? description;
  String? contact;
  List<String> IMAGES = [];
  final texEditingControllertitle = TextEditingController();
  final textEditingControllerdescription = TextEditingController();
  final TextEditingControllercontact = TextEditingController();
  // Select and image from the gallery or take a picture with the camera
  // Then upload to Firebase Storage
  Future<void> _upload(String inputSource) async {
    final picker = ImagePicker();
    PickedFile? pickedImage;
    try {
      pickedImage = await picker.getImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);

      if (pickedImage == null) return;

      // final String fileName = path.basename(pickedImage!.path);
      // final String fileName = path.basename(pickedImage!.path);
      // File imageFile = File(pickedImage.path);

      try {
        // Refresh the UI
        setState(() {
          IMAGES.add(pickedImage!.path);
        });
      } on Exception catch (error) {
        print(error);
      }
    } catch (err) {
      print(err);
    }
  }

  addLostItem() async {
    // save all images
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    List<String> ImageId = [];
    for (int i = 0; i < IMAGES.length; i++) {
      var request =
          http.MultipartRequest('POST', Uri.parse("$API_URL/admin/image"));

      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data',
      });

      var file = File(IMAGES[i]);
      var fileStream = http.ByteStream(file.openRead());
      var length = await file.length();
      var multipartFile = http.MultipartFile('data', fileStream, length,
          filename: 'Image_$i.png');

      request.files.add(multipartFile);

      try {
        var response = await request.send();
        if (response.statusCode == 200) {
          var data = jsonDecode(await response.stream.bytesToString());
          ImageId.add(data['msg']);
        } else {
          print(
              'Failed to upload Image $i. Status code: ${response.statusCode}');
        }
      } catch (error) {
        print('Error uploading Image $i: $error');
      }
    }

    // add item to db
    try {
      final res = await http.post(
        Uri.parse("$API_URL/admin/item"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<String, dynamic>{
          'name': title!,
          'desc': description!,
          "images": ImageId,
          "phNo": contact!
        }),
      );
      print(res.body);

      if (res.statusCode == 200) {
        // remove all images and clear everything
        texEditingControllertitle.clear();
        textEditingControllerdescription.clear();
        TextEditingControllercontact.clear();
        setState(() {
          IMAGES.clear();
        });
        Fluttertoast.showToast(
            msg: 'Item is added',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Color(0xFFFFECDF),
            textColor: kPrimaryColor);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.favourite),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Center(
                  child: Text(
                "Upload Any Items You Have Found",
                style: TextStyle(
                    fontFamily: 'Caveat',
                    letterSpacing: 1.5,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600),
              )),
              const SizedBox(
                height: 25.0,
              ),

              //Item Name
              TextField(
                controller: texEditingControllertitle,
                keyboardType: TextInputType.text,
                // textAlign: TextAlign.center,
                onChanged: (value) {
                  title = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(labelText: "Item Name"),
              ),
              const SizedBox(
                height: 10.0,
              ),

              ///contact info
              TextField(
                controller: TextEditingControllercontact,
                // textAlign: TextAlign.center,
                onChanged: (value) {
                  contact = value;

                  //Do something with the user input.
                },
                decoration:
                    kTextFieldDecoration.copyWith(labelText: 'Contact Info'),
              ),
              const SizedBox(
                height: 10.0,
              ),

              ///description
              TextField(
                controller: textEditingControllerdescription,
                // textAlign: TextAlign.center,
                onChanged: (value) {
                  description = value;

                  //Do something with the user input.
                },
                decoration: kTextFieldDecoration.copyWith(
                    labelText: 'Item Description'),
              ),

              const SizedBox(
                height: 15.0,
              ),

              Column(
                children: [
                  ElevatedButton.icon(
                      onPressed: addLostItem,
                      icon: const Icon(Icons.add),
                      label: const Text('Save')),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton.icon(
                          onPressed: () => _upload('camera'),
                          icon: const Icon(Icons.camera),
                          label: const Text('camera')),
                      ElevatedButton.icon(
                          onPressed: () {
                            _upload('gallery');
                          },
                          icon: const Icon(Icons.library_add),
                          label: const Text('Gallery')),
                    ],
                  ),
                ],
              ),
              IMAGES.isNotEmpty
                  ? Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1 / 2,
                            crossAxisCount: 3, // Number of elements in each row
                            crossAxisSpacing:
                                8.0, // Spacing between elements horizontally
                            mainAxisSpacing:
                                8.0, // Spacing between elements vertically
                          ),
                          itemCount: IMAGES.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              child: Column(children: [
                                Expanded(
                                    child: Image.file(
                                  File(IMAGES[index]),
                                  fit: BoxFit.cover,
                                )),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    // Add your delete logic here
                                    // For example, you can remove the image from the list
                                    setState(() {
                                      IMAGES.removeAt(index);
                                    });
                                  },
                                ),
                              ]),
                            );
                          },
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
