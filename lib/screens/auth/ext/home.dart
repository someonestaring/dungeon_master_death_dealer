import 'package:flutter/material.dart';
import 'package:dungeon_master_death_dealer/screens/auth/ext/body_ext/home_body.dart';
import 'package:dungeon_master_death_dealer/screens/auth/ext/body_ext/search_body.dart';
import 'package:dungeon_master_death_dealer/screens/auth/ext/body_ext/post_body.dart';
import 'package:dungeon_master_death_dealer/screens/auth/ext/body_ext/activity_body.dart';
import 'package:dungeon_master_death_dealer/screens/auth/ext/body_ext/profile_body.dart';
import 'package:dungeon_master_death_dealer/state/app_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String bodyNav = 'home';
  @override
  Widget build(BuildContext context) {
    final size = AppStateScope.of(context).miscData['media_query'];
    //TODO: fill this stuff in 
    PreferredSizeWidget? appBarContent(){}
    Widget? bodyContent(){}
    Widget? bottomNav(){}
    return Scaffold(
      primary: true,
      appBar: appBarContent(),
      body: bodyContent(),
      bottomNavigationBar: bottomNav(),
    );
  }
}
