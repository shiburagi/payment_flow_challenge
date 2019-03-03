import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/material.dart';
import 'package:payment_flow_challenge/dummy/movies.dart';
import 'package:payment_flow_challenge/view/movie_list.dart';

class AppPage extends StatefulWidget {
  AppPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  var selectedMenuItemId = '1';

  var items = [
    MenuItem(id: "1", title: "Now Showing".toUpperCase()),
    MenuItem(id: "2", title: "History".toUpperCase()),
    MenuItem(id: "3", title: "Promotion".toUpperCase()),
  ];

  @override
  Widget build(BuildContext context) {
    return DrawerScaffold(
      appBar: AppBarProps(
        title: Text(widget.title),
        elevation: 4
      ),
      contentView: Screen(
        contentBuilder: (context) => Container(
          child: MovieList(items: movies,),
        ),
        color: Theme.of(context).primaryColor.withAlpha(10),
      ),
      menuView: MenuView(
        selectedItemId: selectedMenuItemId,
        menu: Menu(items: items),
        color: Theme.of(context).primaryColor,
        textStyle: Theme.of(context).textTheme.headline.copyWith(),
      ),
    );
  }
}
