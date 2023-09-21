import 'package:flutter/material.dart';
import 'package:my_first_app/utils/routes.dart';

class signup extends StatefulWidget{
  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  String name="";
  bool changeBut=false;

  final _formkey=GlobalKey<FormState>();

  moveToHome(BuildContext context)async{
    if(_formkey.currentState!.validate()){
    setState(() {
      changeBut=true;
      });
      await Future.delayed(Duration(seconds: 1)); 
      await Navigator.pushNamed(context, Myroutes.homepage);
      setState(() {
        changeBut=false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign UP"),
        backgroundColor: const Color.fromARGB(255, 8, 60, 150),
        
        
      ),
      body: Container(
        child: Form(
          key: _formkey,
          child: Column(
          children: [
            SizedBox(height: 200,),
                   
        
        
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children:[TextFormField(
                decoration: InputDecoration(hintText: "Enter Phone Number",labelText: "Phone Number"),
                validator: (value) {
                  if(value!.isEmpty){
                    return "You have to provide your Phone Number";
                  }
                  else if(value.length<10  || value.length>10){
                    return "Phone Number should have 10 digits";
                  }
                  return null;
                },
                onChanged: (value) {
                  name=value;
                  setState(() {});
                },
              ),
   
                TextFormField(
                decoration: InputDecoration(hintText: "Enter Username",labelText: "Username"),
                validator: (value) {
                  if(value!.isEmpty){
                    return "Username can't be Empty";
                  }
                  return null;
                },
                onChanged: (value) {
                  name=value;
                  setState(() {});
                },
              ),

              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter Password",
                labelText: "Password"),

                validator: (value) {
                  if(value!.isEmpty){
                    return ("Password Can't be Empty");
                  }
                  else if(value.length<6){
                    return "Password length can't be less than 6";
                  } 
                  return null;  
                },
              ),
              
              SizedBox(height: 30),
              
              InkWell(
                onTap: ()=>moveToHome(context),
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                    width:changeBut? 70 : 150,
                    height: 50,
                    alignment: Alignment.center,
                    
                    child:changeBut
                    ?Icon(
                      Icons.done,
                      color: Colors.white,
                     )
                     :Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 18)),
                    
                    decoration:BoxDecoration(
                      color :Color.fromARGB(255, 107, 128, 244),
                      borderRadius: BorderRadius.circular(7)
                             
                    )
             
                ),
              ), 
                ]
              ),           
            ),            
          ],
              ),
        )),
      );
      
      
  
  }
}