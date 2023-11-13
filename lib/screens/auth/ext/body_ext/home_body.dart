import 'package:flutter/material.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  HomeBodyState createState() => HomeBodyState();
}

class HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SingleChildScrollView(
        primary: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Text('Home Body'),
            // StreamBuilder(builder: builder),
            // StreamBuilder(builder: builder),
          ],
        ),
      ),
    );
  }
}

// possible multi-picture/video post solution --> https://stackoverflow.com/questions/58088799/flutter-3d-cube-rotation-transform-matrix-like-instagram-stories