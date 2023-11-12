import 'package:dungeon_master_death_dealer/screens/!auth/authority.dart';
import 'package:dungeon_master_death_dealer/screens/auth/utility.dart';
import 'package:dungeon_master_death_dealer/state/app_state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class Splish extends StatefulWidget {
  const Splish({Key? key}) : super(key: key);

  @override
  SplishState createState() => SplishState();
}

class SplishState extends State<Splish> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore dB = FirebaseFirestore.instance;
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  User? user;
  bool authed = false;
  void userSignIn() async {
    setState(
      () {
        user = auth.currentUser;
      },
    );
    var checker = user;
    if (checker != null) {
      String? token = await messaging.getToken();
      await dB.collection('users').doc(auth.currentUser!.uid).get().then(
        (res) {
          Map<String, dynamic>? data = res.data();
          if (data!.containsKey('tokens')) {
            List tokens = data['tokens'];
            if (tokens.contains(token)) {
              return;
            } else {
              res.reference.update(
                {
                  'lastActive': DateTime.now(),
                  'tokens': FieldValue.arrayUnion([token]),
                },
              );
            }
          } else {
            res.reference.update(
              {
                'lastActive': DateTime.now(),
                'tokens': [token],
              },
            );
          }
          AppStateWidget.of(context).updateUserData(data);
        },
      );
      setState(
        () {
          user != null ? authed = true : authed = false;
        },
      );
    }
  }

  timer() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, autoNav);
  }

  Future<void> autoNav() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => userAuthState(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    userSignIn();
    timer();
  }

  Widget userAuthState() {
    if (!authed) {
      return const Authority();
    } else {
      return const Utility();
    }
  }

  @override
  Widget build(BuildContext context) {
    return splash(context);
  }
}

Widget splash(BuildContext context) {
  final size = MediaQuery.of(context).size;
  AppStateWidget.of(context).updateMiscData(
    {'media_query': size},
  );
  return Scaffold(
    //TODO: remove this manual color control and get theme stuff done
    backgroundColor: Colors.black45,
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(
            flex: 3,
          ),
            //TODO: change all this UI stuff to: --> utilize Theme data --> Use app specific assets
          const Icon(
            Icons.photo_camera,
            color: Colors.white54,
            size: 150,
          ),
          const Spacer(
            flex: 3,
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.085),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'From',
                  style: TextStyle(
                    fontSize: 32.0,
                    color: Colors.white54,
                  ),
                ),
                Text(
                  'CHIPPERTON',
                  style: TextStyle(
                    fontSize: 32.0,
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
