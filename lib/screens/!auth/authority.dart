import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dungeon_master_death_dealer/screens/!auth/ext/man_reg.dart';
import 'package:dungeon_master_death_dealer/screens/auth/utility.dart';
import 'package:dungeon_master_death_dealer/state/app_state.dart';

class Authority extends StatelessWidget {
  const Authority({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map userData = AppStateScope.of(context).userData;
    final size = MediaQuery.of(context).size;
    // AppStateWidget.of(context).updateMiscData(
    //   {'media_query': firstSize},
    // );
    //   final size = AppStateScope.of(context).miscData['media_query'].size;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore dB = FirebaseFirestore.instance;
    PreferredSizeWidget? appBar() {
      return PreferredSize(
        preferredSize: Size(
          size.width,
          size.height * 0.15,
        ),
        child: const Center(
          child: Text(
            'Country Selector: Handled Internally',
            style: TextStyle(
                // color: Colors.white70,
                ),
          ),
        ),
      );
    }

    Widget? bodyContent() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 1,
            ),
            Text(
              'Dungeon Master: \n \n   Death Dealer',
              style: GoogleFonts.dancingScript(
                textStyle: const TextStyle(
                  // color: Colors.white70,
                  fontSize: 42.0,
                  // wordSpacing: 0.75,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            SizedBox(
              width: size.width,
              child: ElevatedButton(
                onPressed: () async {
                  // TODO: stop being lazy and link Facebook to||from firebase
                  final LoginResult loginResult =
                      await FacebookAuth.instance.login(
                    permissions: [
                      'public_profile',
                      'email',
                      'user_link',
                    ],
                  );
                  final OAuthCredential fbAuthCred =
                      FacebookAuthProvider.credential(
                          loginResult.accessToken!.token);
                  return auth.signInWithCredential(fbAuthCred).then((value) {
                    print('User Info ---------> ${value.user}');
                    User? data = value.user;
                    AppStateWidget.of(context).updateUserData({
                      'email': data!.email,
                      'profilePhoto': data.photoURL,
                      'fullName': data.displayName,
                      'firstName': data.displayName.toString().split(' ')[0],
                      'lastName': data.displayName.toString().split(' ')[1],
                      "lastActive": DateTime.now(),
                      'username': data.displayName,
                    });
                    dB.collection("users").doc(auth.currentUser!.uid).set(
                      {
                        'email': userData['email'],
                        'profilePhoto': userData['profilePhoto'],
                        'fullName': userData['fullName'],
                        'firstName': userData['firstName'],
                        'lastName': userData['lastName'],
                        'lastActive': DateTime.now(),
                        'username': userData['username'],
                      },
                    );
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) => const Utility(),
                      ),
                    );
                  });
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.facebook,
                      // color: Colors.white,
                    ),
                    Text('Login with Facebook'),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                        // color: Colors.white70,
                        ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 12,
                      right: 12,
                    ),
                    child: Text(
                      'OR',
                      style: TextStyle(
                          // color: Colors.white70,
                          ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                        // color: Colors.white70,
                        ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const ManualRegister(),
                  ),
                );
              },
              child: const Text(
                'Sign up with email or phone number',
                style: TextStyle(
                  // color: Colors.blue[300],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      );
    }

    Widget? bottomNav() {
      return null;
    }

    return Scaffold(
      appBar: appBar(),
      // backgroundColor: Colors.black,
      body: bodyContent(),
      bottomNavigationBar: bottomNav(),
    );
  }
}
