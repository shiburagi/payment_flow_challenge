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
          return Center(
            child: MaterialApp(
              themeMode: state.mode,
              theme: createTheme(scaffoldBackgroundColor: Colors.grey.shade200),
              darkTheme: createTheme(
                  brightness: Brightness.dark, cardColor: Colors.grey.shade900),
              home: AppPage(),
              debugShowCheckedModeBanner: false,
            ),
          );
        },
      ),
    );
  }
}

ThemeData createTheme(
    {Brightness? brightness,
    Color? scaffoldBackgroundColor,
    Color? cardColor}) {
  return ThemeData(
      brightness: brightness,
      cardColor: cardColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      accentColor: Color.fromARGB(255, 0, 204, 106),
      fontFamily: "Quicksand");
}
