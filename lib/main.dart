import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_flow_challenge/bloc/settings.dart';
import 'package:payment_flow_challenge/bloc/ticket.dart';
import 'package:payment_flow_challenge/pages/app.dart';
import 'package:payment_flow_challenge/resources/session_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SessionManager.instance.initialize();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//    Brightness brightness = Brightness.dark;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SettingBloc(),
        ),
        BlocProvider(
          create: (context) => TicketBloc(),
        ),
      ],
      child: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          return MaterialApp(
            themeMode: state.mode,
            theme: createTheme(scaffoldBackgroundColor: Colors.grey.shade200),
            darkTheme: createTheme(brightness: Brightness.dark),
            home: AppPage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

ThemeData createTheme(
    {Brightness? brightness, Color? scaffoldBackgroundColor}) {
  return ThemeData(
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
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      accentColor: Color.fromARGB(255, 0, 204, 106),
      fontFamily: "Quicksand");
}
