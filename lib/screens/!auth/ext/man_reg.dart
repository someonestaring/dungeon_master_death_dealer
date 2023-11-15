import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dungeon_master_death_dealer/screens/!auth/ext/next.dart';
import 'package:dungeon_master_death_dealer/screens/!auth/ext/login.dart';
import 'package:dungeon_master_death_dealer/state/app_state.dart';

class ManualRegister extends StatefulWidget {
  const ManualRegister({Key? key}) : super(key: key);

  @override
  ManualRegisterState createState() => ManualRegisterState();
}

class ManualRegisterState extends State<ManualRegister> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController phoneCont = TextEditingController();
  final TextEditingController emailCont = TextEditingController();
  List<dynamic> countries = [];
  bool methodType = false;

  @override
  void initState() {
    super.initState();
    getCountries();
  }

  @override
  void dispose() {
    phoneCont.dispose();
    emailCont.dispose();
    super.dispose();
  }

  Future<void> getCountries() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString('assets/countries/country_list.json');
    final List<dynamic> countryList = jsonDecode(data);
    setState(() {
      countries = countryList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    void phoneNext() {
      Locale locale = Localizations.localeOf(context);
      String? countryCode = locale.countryCode!.toUpperCase();
      countries.retainWhere((item) => item['code'] == countryCode);
      AppStateWidget.of(context)
          .updateUserData({'phoneNumber': '$countryCode${phoneCont.text}'});
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => const Next(),
        ),
      );
    }

    void emailNext() {
      AppStateWidget.of(context).updateUserData({'email': emailCont.text});
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => const Next(),
        ),
      );
    }

    Widget bottomNav() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Already have an account?',
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => const Login(),
                ),
              );
            },
            child: const Text(
              'Log in.',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      );
    }

    Widget bodyContent() {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.02,
        ),
        //TODO: fix overflow when keyboard is opened
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CircleAvatar(
              radius: 85,
              child: Icon(
                Icons.account_circle_outlined,
                color: Colors.white70,
                size: 172,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width * 0.45,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border(
                          bottom: !methodType
                              ? const BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                )
                              : const BorderSide(
                                  color: Colors.white70,
                                  width: 1,
                                ),
                        ), //EdgeInsets.only(bottom: 1),
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            methodType = false;
                          });
                        },
                        child: Text(
                          'Phone',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: !methodType ? Colors.white : Colors.white70,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.45,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border(
                          bottom: !methodType
                              ? const BorderSide(
                                  color: Colors.white70,
                                  width: 1,
                                )
                              : const BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                        ), //EdgeInsets.only(bottom: 1),
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            methodType = true;
                          });
                        },
                        child: Text(
                          'Email',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: !methodType ? Colors.white70 : Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[800],
                      alignLabelWithHint: true,
                      hintStyle: const TextStyle(color: Colors.white38),
                      hintText: !methodType ? 'Phone Number' : 'Email',
                    ),
                    controller: !methodType ? phoneCont : emailCont,
                    validator: !methodType
                        ? (String? value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.contains(
                                  RegExp(r'(\D+)'),
                                )) {
                              return 'Phone Field not valid';
                            } else {
                              return null;
                            }
                          }
                        : (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Email Field not valid';
                            } else {
                              return null;
                            }
                          },
                    keyboardType: !methodType
                        ? TextInputType.phone
                        : TextInputType.emailAddress,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                    child: Text(
                      !methodType
                          ? 'You may receive SMS updates from Demo_Gram and can opt out at any time.'
                          : '',
                      style: const TextStyle(color: Colors.white54),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: size.width * 0.9,
                        child: ElevatedButton(
                          child: const Text('Next'),
                          onPressed: () {
                            if (formKey.currentState == null) {
                              print("formKey.currentState is null!");
                            } else if (formKey.currentState!.validate()) {
                              !methodType ? phoneNext() : emailNext();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width * 0.4,
                    child: const Divider(
                      color: Colors.white70,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 12, right: 12),
                    child: Text(
                      'OR',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.4,
                    child: const Divider(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.02),
              child: OutlinedButton(
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                    const BorderSide(
                        color: Colors.white70,
                        width: 1.0,
                        style: BorderStyle.solid),
                  ),
                ),
                onPressed: () {},
                child: SizedBox(
                  width: size.width,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.facebook,
                      ),
                      Text(
                        'Continue with Facebook',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: bodyContent(),
      bottomNavigationBar: bottomNav(),
    );
  }
}
