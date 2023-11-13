import 'package:flutter/material.dart';

class PostEditing extends StatefulWidget {
  const PostEditing({Key? key}) : super(key: key);

  @override
  PostEditingState createState() => PostEditingState();
}

class PostEditingState extends State<PostEditing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('GoBackToDemo'),
        ),
      ),
    );
  }
}