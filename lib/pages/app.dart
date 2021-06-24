import 'dart:async';

import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_flow_challenge/action/event.dart';
import 'package:payment_flow_challenge/bloc/settings.dart';
import 'package:payment_flow_challenge/bloc/ticket.dart';
import 'package:payment_flow_challenge/dummy/movies.dart';
import 'package:payment_flow_challenge/entities/ticket.dart';
import 'package:payment_flow_challenge/resources/session_manager.dart';
import 'package:payment_flow_challenge/view/history.dart';
import 'package:payment_flow_challenge/view/movie_list.dart';

class AppPage extends StatefulWidget {
  AppPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  var selectedMenuItemId = '1';

  List<MenuItem> items = [
    MenuItem(id: "1", title: "Now Showing".toUpperCase()),
    MenuItem(id: "2", title: "History".toUpperCase()),
    MenuItem(id: "3", title: "Promotion".toUpperCase()),
  ];
  StreamSubscription? subscription;
  @override
  void initState() {
    super.initState();
    subscription = context.read<TicketBloc>().stream.listen((event) {
      setState(() {
        selectedMenuItemId = "2";
      });
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DrawerScaffold(
      appBar: AppBar(
          brightness: Theme.of(context).brightness,
          iconTheme: IconThemeData(color: Theme.of(context).hintColor),
          backgroundColor: Theme.of(context).cardColor,
          title: Text(
            items
                .where((item) => item.id == selectedMenuItemId)
                .toList()[0]
                .title,
            style: TextStyle(color: Theme.of(context).hintColor),
          ),
          elevation: 4),
      builder: (context, value) {
        return IndexedStack(
          index: selectedMenuItemId == "2" ? 1 : 0,
          children: [
            MovieList(
              items: movies,
            ),
            HistoryView(),
          ],
        );
      },
      drawers: [
        SideDrawer(
          headerView: SafeArea(
            child: Container(
              padding: EdgeInsets.fromLTRB(48, 0, 0, 12),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Theme.of(context).dividerColor, width: 1))),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        "Dark Mode".toUpperCase(),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      BlocBuilder<SettingBloc, SettingState>(
                          builder: (context, state) {
                        bool isDarkMode = state.mode == ThemeMode.dark;

                        return Switch(
                          value: isDarkMode,
                          onChanged: (b) {
                            setState(() {
                              context
                                  .read<SettingBloc>()
                                  .changeTheme(b ? 1 : 0);
                              // DynamicTheme.of(context).setBrightness(
                              //     b ? Brightness.dark : Brightness.light);
                            });
                          },
                        );
                      })
                    ],
                  )
                ],
              ),
            ),
          ),
          selectedItemId: selectedMenuItemId,
          menu: Menu(items: items),
          color: Theme.of(context).cardColor,
          textStyle: Theme.of(context).textTheme.headline5!.copyWith(),
          onMenuItemSelected: (s) {
            setState(() {
              selectedMenuItemId = s;
            });
          },
        )
      ],
    );
  }
}
