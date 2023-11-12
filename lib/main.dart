import 'package:flutter/material.dart';
import 'package:dungeon_master_death_dealer/screens/splish.dart';
import 'package:dungeon_master_death_dealer/state/app_state.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const AppStateWidget(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dungeon Master: Death Dealer',
        home: Splish(),
      ),
    );
  }
}
