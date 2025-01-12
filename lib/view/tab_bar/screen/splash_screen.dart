import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../tab_bar_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
     super.initState();
     Timer(Duration(seconds: 3), (){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TabBarPage()));
     });
   }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Center(
            child: RichText(text: TextSpan(
                  style: TextStyle(fontSize: 32 ,fontWeight: FontWeight.bold,color: Colors.black),
                    children: [
            TextSpan( text:'ToDo ' ,),
            TextSpan(text: 'Manager',style: TextStyle(color: Colors.deepPurple)),
                    ])),
          ),



    ],),
    );
  }
}
