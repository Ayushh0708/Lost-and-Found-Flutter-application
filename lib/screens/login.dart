import "package:flutter/material.dart";
import 'package:my_first_app/utils/routes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class login_Page extends StatefulWidget {
  @override
  State<login_Page> createState() => _login_PageState();
}

class _login_PageState extends State<login_Page> {
  var usernameText = TextEditingController();
  var passwordText = TextEditingController();

  String name = "";
  bool changeBut = false;

  final _formkey = GlobalKey<FormState>();
  final apiUrl = Uri.parse('https://lost-found-rho.vercel.app/user/login');

  
  Future<void> loginUser(String username, String password) async {
    try {
      final data = {
        'username': username,
        'password': password,
      };

      final response = await http.post(
        apiUrl,
        body: data,
      );
        print('Response: ${response.body}');
        var body = json.decode(response.body);
        if(body['status'] == true){
          // success
          var name = body['user']['name'];
          var token = body['user']['token'];

          print("Name: ${name}\ntoken: ${token}");

        }else{
          // auth failed
          print("auth failed");
        }

    } catch (e) {
        // auth failed
        print("auth failed !!");
        print(e);
    }
    
  }
  
  moveToHome(BuildContext context) async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        changeBut = true;
      });
      await Future.delayed(Duration(seconds: 1));
      await Navigator.pushNamed(context, Myroutes.homepage);
      setState(() {
        changeBut = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
          child: Form(
        key: _formkey,
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              "UPES",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "Lost & Found",
              style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
            ),
            Image.asset('android/assets/images/loginimg.png',
                fit: BoxFit.cover, height: 220),
            Text(
              "Welcome $name",
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Enter Username", labelText: "Username"),
                  controller: usernameText,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Username can't be Empty";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    name = value;
                    setState(() {});
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Enter Password", labelText: "Password"),
                  controller: passwordText,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Password Can't be Empty");
                    } else if (value.length < 6) {
                      return "Password length can't be less than 6";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    loginUser(usernameText.text, passwordText.text);
                  },
                  child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      width: changeBut ? 70 : 150,
                      height: 50,
                      alignment: Alignment.center,
                      child: changeBut
                          ? Icon(
                              Icons.done,
                              color: Colors.white,
                            )
                          : Text("Login",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 107, 128, 244),
                          borderRadius: BorderRadius.circular(7))
                      // onPressed:(){},

                      ),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  child: Text("Don't have an account?"),
                  onTap: () {
                    setState(() {});
                    Navigator.pushNamed(context, Myroutes.siup);
                  },
                )
              ]),
            ),
          ],
        ),
      )),
    );
  }
}
