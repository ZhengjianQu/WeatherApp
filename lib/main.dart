import 'package:flutter/material.dart';
import 'package:weather_app/screens/screen1.dart';
import 'package:weather_app/screens/combined_screen.dart';


//import 'delegates/custom_search_delegate.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes:
      {'/': (context) => const CombinedPage(),
      },
    );
  }
}
