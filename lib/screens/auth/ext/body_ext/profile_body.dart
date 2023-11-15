import 'package:flutter/material.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  ProfileBodyState createState() => ProfileBodyState();
}

class ProfileBodyState extends State<ProfileBody> {
  // TODO: probably start here after all login methods are written to be able to change user data [ --> definitely throw a dialog in there to annoy user to give me all data if they haven't already <-- ] 
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Profile Body',
      ),
    );
  }
}
