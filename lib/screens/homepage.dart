import 'package:flutter/material.dart';

class Home_Page extends StatelessWidget{
  List pics=["https://theawesomedaily.com/wp-content/uploads/2017/01/random-pictures-that-make-no-sense-1.jpeg",
             "https://i.pinimg.com/originals/59/69/5a/59695afcbea919b65a8d43e995e0a754--funny-things-funny-stuff.jpg",
             "https://i.pinimg.com/originals/b7/8f/4a/b78f4a1823e9bee8c6bbf963116b0924.jpg",
             "https://i.pinimg.com/originals/dd/fa/ac/ddfaac7c0f4c680466a0598c51427ea4.jpg",
             "https://i.pinimg.com/originals/75/b5/f4/75b5f40a2d4319f1f9a8fe8655108106--funny-babies-cute-babies.jpg",
             "https://i.pinimg.com/originals/c6/8c/13/c68c13dbe397b234141ecc17a3785ef2--funny-dogs-funny-animals.jpg",];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lost&Found"),
        backgroundColor: const Color.fromARGB(255, 8, 60, 150),
        
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(itemBuilder: (BuildContext ctx ,int index ){
            return Image.network(pics[index]);
        },itemCount: pics.length,
        ),
      ),





      drawer: Drawer(),
      
    );
  }

  
  
}