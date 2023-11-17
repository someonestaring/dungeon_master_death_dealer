import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dungeon_master_death_dealer/screens/!auth/authority.dart';
import 'package:dungeon_master_death_dealer/state/app_state.dart';
import 'package:dungeon_master_death_dealer/screens/auth/utility.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> smsKey = GlobalKey<FormState>();
  final TextEditingController signInCont = TextEditingController();
  final TextEditingController passCont = TextEditingController();
  final TextEditingController smsCont = TextEditingController();
  final FirebaseFirestore store = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  PhoneAuthCredential? authCredential;
  List<dynamic> countries = [];
  bool verification = false;
  bool isActive = false;
  bool loading = false;
  String? phoneNumber;
  String userEmail = '';
  String userPassword = '';
  String? smsCode;
  String? verId;

  @override
  void initState() {
    super.initState();
    getCountries();
    signInCont.addListener(parseSignIn);
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        // print('User is currently signed out!');
      } else {
        // print('User is signed in!');
        navigate(context);
      }
    });
  }

  @override
  void dispose() {
    signInCont.dispose();
    passCont.dispose();
    smsCont.dispose();
    super.dispose();
  }

  Widget bodyContent(context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Spacer(
          flex: 1,
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: size.height * 0.025,
          ),
          child: Text(
            'DM: DD',
            style: GoogleFonts.dancingScript(
              textStyle: const TextStyle(
                // color: Colors.white70,
                fontSize: 42.0,
                // wordSpacing: 0.75,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: size.height * 0.01,
                  ),
                  child: TextFormField(
                    controller: signInCont,
                    style: const TextStyle(
                        // color: Colors.white38,
                        ),
                    decoration: const InputDecoration(
                      filled: true,
                      // fillColor: Colors.grey[800],
                      hintStyle: TextStyle(
                          // color: Colors.white38,
                          ),
                      hintText: 'Phone Number, Email, or Username',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter valid Phone Number, Email, or Username';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: size.height * 0.01,
                  ),
                  child: TextFormField(
                    controller: passCont,
                    obscureText: true,
                    style: const TextStyle(
                        // color: Colors.white38,
                        ),
                    decoration: const InputDecoration(
                      filled: true,
                      // fillColor: Colors.grey[800],
                      alignLabelWithHint: true,
                      hintStyle: TextStyle(
                          // color: Colors.white38,
                          ),
                      hintText: 'Password',
                      suffixIcon: Icon(
                        Icons.visibility_off,
                        // color: Colors.white38,
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Password';
                      }
                      setState(() {
                        userPassword = passCont.text;
                      });
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 0.0,
                  ),
                  child: SizedBox(
                    width: size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState == null) {
                          // print("formKey.currentState is null!");
                        } else if (formKey.currentState!.validate()) {
                          logIn();
                        }
                      },
                      child: const Text(
                        'Log In',
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Forgot your login details?',
                      style: TextStyle(
                          // color: Colors.white70,
                          ),
                    ),
                    TextButton(
                      onPressed: () {
                        // print('Handle "Get help logging in."');
                      },
                      child: const Text(
                        'Get help logging in.',
                        style: TextStyle(
                          // color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 12),
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
                ElevatedButton(
                  onPressed: () async {
                    await FacebookAuth.instance.login(permissions: [
                      'public_profile',
                      'email',
                      'user_link'
                    ]).then((value) {
                      FacebookAuth.instance.getUserData().then((data) {
                        // print(data);
                        AppStateWidget.of(context).updateUserData({
                          'email': data['email'],
                          'profilePhoto': data['picture']['url'],
                          'firstName': data['name'].toString().split(' ')[0],
                          'lastName': data['name'].toString().split(' ')[1],
                          "lastActive": DateTime.now(),
                          'username': data['name'],
                        });
                      });
                    });
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.facebook,
                        // color: Colors.white,
                      ),
                      Text(
                        'Login with Facebook',
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        const Spacer(
          flex: 1,
        ),
      ],
    );
  }

  Widget bottomNav(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const Authority()));
          },
          child: const Text(
            'Sign up.',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  void navigate(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => const Utility(),
      ),
    );
  }

  Future<void> getCountries() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString('assets/countries/country_list.json');
    final List<dynamic> countryList = jsonDecode(data);
    setState(() {
      countries = countryList;
    });
  }

  String parseSignIn() {
    String input = signInCont.text;
    final bool numPatt = RegExp(r'(\d+)').hasMatch(input);
    final bool emailPatt = RegExp(r'(\S+)@(\S+)\.(\w+)').hasMatch(input);
    List<Map<String, dynamic>> users = <Map<String, dynamic>>[];
    store.collection('users').get().then((QuerySnapshot snaps) {
      for (var doc in snaps.docs) {
        Map<String, dynamic> user = doc.data() as Map<String, dynamic>;
        users.add(user);
        users.retainWhere((user) => user['username'].toString() == input);
      }
    });
    if (users.isNotEmpty) {
      AppStateWidget.of(context).updateUserData(users[0]);
      AppStateWidget.of(context).updateUserData({'lastActive': DateTime.now()});
      return 'username';
    }
    if (numPatt) {
      Locale locale = Localizations.localeOf(context);
      String? countryCode = locale.countryCode!.toUpperCase();
      countries.retainWhere((item) => item['code'] == countryCode);
      if (countries.isNotEmpty) {
        String numericCode = countries[0]['dial_code'];
        setState(() {
          phoneNumber = '$numericCode${signInCont.text}';
        });
      }
      return 'number';
    } else if (emailPatt) {
      setState(() {
        userEmail = signInCont.text;
      });
      return 'email';
    } else {
      return 'null';
    }
  }

  void codeSent(String verificationId, int? resendToken) async {
    showSMS(context);
    setState(() {
      loading = false;
      verification = true;
      verId = verificationId;
    });
  }

  void veriFailed(FirebaseAuthException e) {
    // print('Verification FAILURE due to: $e');
  }

  void veriCompleted(PhoneAuthCredential credential) async {
    try {
      setState(() {
        authCredential = credential;
      });
      UserCredential user = await auth.signInWithCredential(authCredential!);
      if (user.user != null) {
        store.collection("users").doc(user.user!.phoneNumber).update({
          'lastActive': DateTime.now(),
        });
        AppStateWidget.of(context).updateUserData({
          'lastActive': DateTime.now(),
        });
        // print('User signed in, time to navigate');
      }
    } catch (e) {
      // print('veriCompleted error: $e');
    }
  }

  void autoRetrieval(String verificationId) {
    // print('code auto-retrieval timeout --> verificationId --> $verificationId');
  }

  void showSMS(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 3,
            actionsAlignment: MainAxisAlignment.center,
            scrollable: true,
            title: const Text('SMS Code:'),
            content: Form(
              key: smsKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: smsCont,
                    style: const TextStyle(
                        // color: Colors.white38,
                        ),
                    decoration: const InputDecoration(
                      filled: true,
                      // fillColor: Colors.grey[800],
                      hintStyle: TextStyle(
                          // color: Colors.white38,
                          ),
                      hintText: 'SMS Code',
                    ),
                    validator: (String? value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.contains(RegExp('[a-zA-Z]')) ||
                          value.length != 6) {
                        return 'Please use only 6 numbers';
                      } else {
                        setState(() {
                          smsCode = value;
                        });
                        return '';
                      }
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  setState(() {
                    smsCode = smsCont.text;
                  });
                  continuePhoneSignIn();
                  // print('this is the return string from showSMS: $smsCode');
                  Navigator.of(context).pop();
                  smsCont.clear();
                  signInCont.clear();
                  passCont.clear();
                },
                child: const Text('Submit'),
              ),
            ],
          );
        });
  }

  Future<void> continuePhoneSignIn() async {
    try {
      UserCredential? user = await auth.signInWithCredential(authCredential!);
      var checker = user.user;
      if (checker != null) {
        store.collection("users").doc(user.user!.uid).update({
          'lastActive': DateTime.now(),
        });
        AppStateWidget.of(context).updateUserData({
          'lastActive': DateTime.now(),
        });
      }
      setState(() {
        loading = false;
      });
    } catch (e) {
      // print('Error on _continueRegistration. $e');
    }
  }

  Future<void> continueUsernameSignIn() async {
    Map userData = AppStateScope.of(context).userData;
    try {
      UserCredential? user = await auth.signInWithCredential(authCredential!);
      var checker = user.user;

      if (checker != null) {
        await auth.signInWithEmailAndPassword(
            email: userData['email'], password: userPassword);
        await store.collection("users").doc(user.user!.uid).update({
          'lastActive': DateTime.now(),
        });
      }
      setState(() {
        loading = false;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        // print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> continueEmailSignIn() async {
    // Map userData = AppStateScope.of(context).userData;
    try {
      UserCredential user = await auth.signInWithEmailAndPassword(
          email: userEmail, password: userPassword);
      var checker = user.user;
      if (checker != null) {
        await auth.signInWithEmailAndPassword(
            email: userEmail, password: userPassword);
        await store.collection("users").doc(user.user!.uid).update({
          'lastActive': DateTime.now(),
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        // print('Wrong password provided for that user.');
      }
    }
  }

  void logIn() async {
    setState(() {
      loading = true;
    });
    try {
      switch (parseSignIn()) {
        case 'number':
          // print('parses number');
          if (!verification) {
            await auth.verifyPhoneNumber(
              timeout: const Duration(
                seconds: 60,
              ),
              phoneNumber: phoneNumber!,
              verificationCompleted: veriCompleted,
              verificationFailed: veriFailed,
              codeSent: codeSent,
              codeAutoRetrievalTimeout: autoRetrieval,
            );
          } else {
            setState(() {
              authCredential = PhoneAuthProvider.credential(
                  verificationId: verId!, smsCode: smsCode!);
            });
          }
          return continuePhoneSignIn();
        case 'username':
          // print('parses username');
          return continueUsernameSignIn();
        //handle username stuff
        case 'email':
          // print('parses email');
          return continueEmailSignIn();
      }
    } catch (e) {
      // print('Error on _login: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNav(context),
      // backgroundColor: Colors.black,
      body: Center(
        child: bodyContent(context),
      ),
    );
  }
}
