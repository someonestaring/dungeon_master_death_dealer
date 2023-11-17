import 'package:flutter/material.dart';
import 'package:dungeon_master_death_dealer/screens/splish.dart';
import 'package:dungeon_master_death_dealer/state/app_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // final ThemeData initialTheme = nativeMode();
  @override
  Widget build(BuildContext context) {
    return AppStateWidget(
      child: MaterialApp(
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme(
            brightness: Brightness.dark,
            primary: Colors.amberAccent.shade400,
            onPrimary: Colors.black38,
            secondary: Colors.tealAccent.shade700,
            onSecondary: Colors.black38,
            error: Colors.red.shade900,
            onError: Colors.black,
            background: Colors.blueGrey.shade800,
            onBackground: Colors.black38,
            surface: Colors.blueGrey.shade700,
            onSurface: Colors.amberAccent.shade400,
          ),
        ),
        debugShowCheckedModeBanner: false,
        title: 'Dungeon Master: Death Dealer',
        home: const Splish(),
      ),
    );
  }
}
