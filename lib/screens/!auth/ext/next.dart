import 'package:flutter/material.dart';
import 'package:dungeon_master_death_dealer/state/app_state.dart';
import 'package:dungeon_master_death_dealer/screens/!auth/ext/birthday.dart';

class Next extends StatefulWidget {
  const Next({Key? key}) : super(key: key);

  @override
  NextState createState() => NextState();}
class NextState extends State<Next> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameCont = TextEditingController();
  final TextEditingController passCont = TextEditingController();
  bool checkValue = true;
  bool validated = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    PreferredSizeWidget appBar() {
      return PreferredSize(
        preferredSize: Size(size.width, size.height * 0.015),
        child: const Center(
          child: Text(
            '',
          ),
        ),
      );
    }

    Widget bodyContent() {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Text(
                  'NAME AND PASSWORD',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                  child: TextFormField(
                    controller: nameCont,
                    validator: (String? value) {
                      if (value!.isEmpty || value.length < 3) {
                        return 'Please enter at least 3 characters.';
                      } else {
                        setState(() {
                          validated = true;
                        });
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.white70),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[800],
                      alignLabelWithHint: true,
                      hintStyle: const TextStyle(color: Colors.white38),
                      hintText: 'Full name',
                    ),
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  controller: passCont,
                  validator: (String? value) {
                    if (value!.isEmpty || value.length < 6) {
                      return 'Please enter at least 6 characters.';
                    } else {
                      setState(() {
                        validated = true;
                      });
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.white70),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[800],
                    alignLabelWithHint: true,
                    hintStyle: const TextStyle(color: Colors.white38),
                    hintText: 'Password',
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: checkValue,
                      onChanged: (bool? type) {
                        setState(() {
                          checkValue = !checkValue;
                        });
                      },
                    ),
                    const Text(
                      'Remember password',
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () {
                      //TODO: needs to gain access to device.contacts, scrape numbers || emails, snapshot && friend request known users
                      if (formKey.currentState == null) {
                      } else if (formKey.currentState!.validate()) {
                        if (validated) {
                          AppStateWidget.of(context).updateUserData({
                            'fullName': nameCont.text,
                          });
                          AppStateWidget.of(context)
                              .updateMiscData({'password': passCont.text});
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const Birthday()));
                        }
                      }
                    },
                    child: const Text(
                        'Continue and Sync Contacts(not yet actually)'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (formKey.currentState == null) {
                    } else if (formKey.currentState!.validate()) {
                      if (validated) {
                        AppStateWidget.of(context).updateUserData({
                          'fullName': nameCont.text,
                        });
                        AppStateWidget.of(context)
                            .updateMiscData({'password': passCont.text});
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const Birthday()));
                      }
                    }
                  },
                  child: const Text('Continue without Syncing Contacts'),
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Your contacts will be periodically synced and stored on Dungeon Master: Death Dealer servers to help you and others find friends, and to help us provide a better service. To remove contacts, go to Settings and disconnect.',
                      style: TextStyle(color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Learn More.',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget bottomNav() {
      //TODO: fix overflow
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Your contacts will be periodically synced and stored on Dungeon Master: Death Dealer servers to help you and others find friends, and to help us provide a better service. To remove contacts, go to Settings and disconnect.',
            style: TextStyle(color: Colors.white70),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Learn More.',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.black,
      bottomNavigationBar: bottomNav(), // TODO i think this was breaking due to overflow ??
      body: bodyContent(),
    );
  }
}
