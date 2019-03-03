import 'package:flutter/material.dart';
import 'package:payment_flow_challenge/utils/clip_shadow_path.dart';
import 'package:payment_flow_challenge/utils/layout.dart';

class MovieList extends StatelessWidget {
  MovieList({Key key, this.items}) : super(key: key);

  final List items;
  final double imageWidth = 172.0;

  Widget itemView(context, Movie) {
    Widget widget = Container(
      key: Key(Movie["_id"]),
      margin: EdgeInsets.only(bottom: 1),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Row(
        children: <Widget>[
          Container(
            height: 160,
            color: Theme.of(context).primaryColor,
            child: Image.network(
              Movie["Detail"]["URLforGraphic"],
              width: 140,
              fit: BoxFit.fitHeight,
            ),
          ),
          Container(
            width: 4,
          ),
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 6),
                child: Column(
                  children: <Widget>[
                    Container(
                      width:
                          MediaQuery.of(context).size.width - imageWidth - 38,
                      child: Text(
                        Movie["Name"].toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(fontWeight: FontWeight.w700),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    Container(
                      height: 6,
                    ),
                    Text(
                      "(${Movie["Detail"]["Censor"]}) ${Movie["Detail"]["Content"]}",
                      style: Theme.of(context)
                          .textTheme
                          .subhead
                          .copyWith(wordSpacing: 0),
                    ),
                    Text(
                      "${Movie["Detail"]["Duration"]} minutes",
                      style: Theme.of(context)
                          .textTheme
                          .subhead
                          .copyWith(wordSpacing: 0),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
              Container(
                height: 6,
              ),
              Container(
                width: MediaQuery.of(context).size.width - imageWidth - 8,
                child: Row(
                  children: <Widget>[
                    Row(children: <Widget>[
                      FloatingActionButton(
                        onPressed: () {},
                        mini: true,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.info_outline,
                          size: 16,
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () {},
                        mini: true,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.share,
                          size: 16,
                        ),
                      ),
                    ]),
//                    FloatingActionButton(
//                      onPressed: () {},
//                      mini: true,
//                      backgroundColor: Theme.of(context).primaryColor,
//                      foregroundColor: Theme.of(context).accentColor,
//                      child: Icon(
//                        Icons.shopping_cart,
//                        size: 16,
//                      ),
//                    ),
//                    FlatButton(
//
//                        onPressed: () {},
//                        child: Text(
//                          "BUY",
//                          style: Theme.of(context)
//                              .textTheme
//                              .button
//                              .copyWith(color: Theme.of(context).accentColor),
//                        ))
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                ),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          )
        ],
        mainAxisSize: MainAxisSize.max,
      ),
    );

    return Container(
      child: Row(
        children: <Widget>[
          ClipShadowPath(
              shadow: Shadow(), clipper: LeftClipRectClipper(), child: widget),
          Container(
            padding: EdgeInsets.all(12),
            child: Text(
              "B\nU\nY",
              style: Theme.of(context).textTheme.subhead.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).accentColor),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withAlpha(100),
    
//        border: Border(
//          bottom: BorderSide(color: Theme.of(context).primaryColor, width: 1),
//        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Layout.fill(context,
            child: ListView(
              children: items.map((Movie) => itemView(context, Movie)).toList(),
            )));
  }
}
