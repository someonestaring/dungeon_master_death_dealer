import 'package:flutter/material.dart';

class ActivityBody extends StatefulWidget {
  const ActivityBody({Key? key}) : super(key: key);

  @override
  ActivityBodyState createState() => ActivityBodyState();
}

class ActivityBodyState extends State<ActivityBody> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Activity Body',
      ),
    );
  }
}
