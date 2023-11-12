import 'package:flutter/material.dart';
import 'package:dungeon_master_death_dealer/state/app_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String bodyNav = 'home';
  @override
  Widget build(BuildContext context) {
    final size = AppStateScope.of(context).miscData['media_query'];
    //TODO: fill this stuff in
    PreferredSizeWidget? appBarContent() {
      return null;
    }

    Widget? bodyContent() {
      return null;
    }

    Widget? bottomNav() {
      return null;
    }

    return Scaffold(
      primary: true,
      appBar: appBarContent(),
      body: bodyContent(),
      bottomNavigationBar: bottomNav(),
    );
  }
}
