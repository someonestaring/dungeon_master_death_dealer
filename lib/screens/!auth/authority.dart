import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class Authority extends StatelessWidget {
  const Authority({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore dB = FirebaseFirestore.instance;
    PreferredSizeWidget? appBar(){
      return null;
    }
    Widget? bodyContent(){
      return null;
    }
    Widget? bottomNav(){
      return null;
    }
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.black,
      body: bodyContent(),
      bottomNavigationBar: bottomNav(),
    );
  }
}
