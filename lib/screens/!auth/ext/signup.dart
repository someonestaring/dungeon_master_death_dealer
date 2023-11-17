import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:dungeon_master_death_dealer/state/app_state.dart';
import 'package:dungeon_master_death_dealer/screens/auth/utility.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  // TODO decipher between email&&phone signup and add phone stuff accordingly
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _dB = FirebaseFirestore.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  User? user;
  bool authed = false;
  void userSignIn() async {
    setState(() {
      user = auth.currentUser;
    });
    var checker = user;
    if (checker != null) {
      String? token = await _messaging.getToken();
      await _dB.collection('users').doc(auth.currentUser!.uid).get().then(
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
                  'tokens': FieldValue.arrayUnion(
                    [token],
                  ),
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
          //TODO: this is redudndant af check following logic
          user != null ? authed = true : authed = false;
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    userSignIn();
    auth.authStateChanges().listen(
      (User? user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          print('User is signed in!');
          navigate(context);
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void navigate(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => const Utility(),
      ),
    );
  }

  //TODO: adapt phone number authentication, already grabbing it, just run it through firestore ceremonies
  // Future<void> continuePhoneSignIn(n,p) async {}

  Future<void> continueEmailSignIn(e, p) async {
    Map userData = AppStateScope.of(context).userData;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: userData['email'],
        password: AppStateScope.of(context).miscData['password'],
      );
      var checker = userCredential.user;
      if (checker != null) {
        await auth.signInWithEmailAndPassword(email: e, password: p);
        await _dB.collection("users").doc(userCredential.user!.uid).set(
          {
            'email': userData['email'],
            // 'profilePhoto': userData['picture']['url'],
            'fullName': userData['fullName'],
            "lastActive": DateTime.now(),
            'username': userData['username'],
            //TODO: store the rest of user data
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Map userData = AppStateScope.of(context).userData;
    Size size = MediaQuery.of(context).size;

    Widget bodyContent() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: size.height * 0.025,
                left: size.width * 0.25,
                right: size.width * 0.25,
              ),
              child: Text(
                'Sign up as ${userData['username']}?',
                style: const TextStyle(
                  // color: Colors.white,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: size.height * 0.025,
              ),
              child: const Text(
                'You can always change your username later.',
                style: TextStyle(
                    // color: Colors.white54,
                    ),
              ),
            ),
            SizedBox(
              width: size.width * 0.9,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    continueEmailSignIn(userData['email'],
                        AppStateScope.of(context).miscData['password']);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Text(
                  'Sign Up',
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget bottomNav() {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
        ),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'By tapping Sign Up, you agree to our ',
            style: const TextStyle(
                // color: Colors.white54,
                ),
            children: [
              TextSpan(
                text: 'Terms',
                style: const TextStyle(
                    // color: Colors.white,
                    ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => {
                        // TODO: do stuff for the terms}
                      },
              ),
              const TextSpan(
                text: ', ',
                style: TextStyle(
                  // color: Colors.white54,
                ),
              ),
              TextSpan(
                text: 'Data Policy ',
                style: const TextStyle(
                  // color: Colors.white,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => {
                        // TODO: do stuff for the data policy},
                      },
              ),
              const TextSpan(
                text: 'and ',
                style: TextStyle(
                  // color: Colors.white54,
                ),
              ),
              TextSpan(
                text: 'Cookie Policy',
                style: const TextStyle(
                  // color: Colors.white,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => {
                        // TODO: do stuff for the cookie policy
                      },
              ),
              const TextSpan(
                text: '.',
                style: TextStyle(
                  // color: Colors.white54,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: bodyContent(),
      bottomNavigationBar: bottomNav(),
      // backgroundColor: Colors.black,
    );
  }
}
