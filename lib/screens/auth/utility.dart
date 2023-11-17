import 'package:dungeon_master_death_dealer/screens/auth/ext/home.dart';
import 'package:dungeon_master_death_dealer/screens/auth/ext/messages.dart';
import 'package:dungeon_master_death_dealer/state/app_state.dart';
import 'package:flutter/material.dart';

class Utility extends StatelessWidget {
  const Utility({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController pageCont = AppStateScope.of(context).pageCont;
    return Scaffold(
      // backgroundColor: Colors.black45,
      body: Center(
        child: PageView(
          physics: const BouncingScrollPhysics(),
          controller: pageCont,
          children: const [
            HomeScreen(),
            MessageScreen(),
          ],
        ),
      ),
    );
  }
}