import 'package:flutter/material.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  ProfileBodyState createState() => ProfileBodyState();
}

class ProfileBodyState extends State<ProfileBody> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Profile Body',
      ),
    );
  }
}
