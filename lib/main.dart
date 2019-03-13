import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payment_flow_challenge/pages/app.dart';

void main() => SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]).then((_) {
      runApp(new MyApp());
    });

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Brightness brightness = Brightness.dark;
    return MaterialApp(
      theme: ThemeData(
          brightness: brightness,
          primarySwatch: MaterialColor(
            Colors.white.hashCode,
            <int, Color>{
              50: Color(Colors.white.hashCode),
              100: Color(Colors.white.hashCode),
              200: Color(Colors.white.hashCode),
              300: Color(Colors.white.hashCode),
              400: Color(Colors.white.hashCode),
              500: Color(Colors.white.hashCode),
              600: Color(Colors.white.hashCode),
              700: Color(Colors.white.hashCode),
              800: Color(Colors.white.hashCode),
              900: Color(Colors.white.hashCode),
            },
          ),
          scaffoldBackgroundColor:
              brightness == Brightness.light ? Colors.grey.shade200 : null,
          accentColor: Color.fromARGB(255, 0, 204, 106),
          fontFamily: "Quicksand"),
      home: AppPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
