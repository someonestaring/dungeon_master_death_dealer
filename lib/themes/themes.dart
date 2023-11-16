import 'dart:ffi';

import 'package:flutter/material.dart';

// ThemeData darkMode() {
//   return ThemeData(
//     useMaterial3: true,
//     colorScheme: ColorScheme(
//       brightness: brightness,
//       primary: primary,
//       onPrimary: onPrimary,
//       secondary: secondary,
//       onSecondary: onSecondary,
//       error: error,
//       onError: onError,
//       background: background,
//       onBackground: onBackground,
//       surface: surface,
//       onSurface: onSurface,
//     ),
//     textTheme: TextTheme(),
//   );
// }

// ThemeData lightMode() {
//   return ThemeData(
//     useMaterial3: true,
//     colorScheme: ColorScheme(
//       brightness: brightness,
//       primary: primary,
//       onPrimary: onPrimary,
//       secondary: secondary,
//       onSecondary: onSecondary,
//       error: error,
//       onError: onError,
//       background: background,
//       onBackground: onBackground,
//       surface: surface,
//       onSurface: onSurface,
//     ),
//     textTheme: TextTheme(),
//   );
// }

ThemeData nativeMode () {
  
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.amberAccent.shade400,
      onPrimary: Colors.black54,
      secondary: Colors.tealAccent.shade700,
      onSecondary: Colors.black54,
      error: Colors.red.shade900,
      onError: Colors.black,
      background: Colors.blueGrey.shade800,
      onBackground: Colors.black54,
      surface: Colors.black38,
      onSurface: Colors.white60,
    ),
    // textTheme: const TextTheme(),
  );
}
