import 'package:flutter/material.dart';
import 'package:payment_flow_challenge/pages/booking.dart';
import 'package:payment_flow_challenge/utils/clip_shadow_path.dart';
import 'package:payment_flow_challenge/utils/custom_clipper.dart';
import 'package:payment_flow_challenge/entities/movie.dart';

class MovieList extends StatelessWidget {
  MovieList({Key key, this.items}) : super(key: key);

  final List items;
  static double imageWidth = 120;
  static double reserveWidth = imageWidth + 45.0;

  Widget itemView(context, movie) {

    Widget widget = Container(
      key: Key(movie.id),
      margin: EdgeInsets.only(bottom: 1),
      color: Theme.of(context).primaryColor,

      child: Row(
        children: <Widget>[
          Hero(
            tag: "${movie.id}-image",
            child: Container(
              height: 160,
              color: Theme.of(context).primaryColor,
              child: Image.network(
                movie.detail.urlforGraphic,
                width: imageWidth,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Container(
            width: 12,
          ),
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 6),
                child: Column(
                  children: <Widget>[
                    Container(
                      width:
                          MediaQuery.of(context).size.width - reserveWidth - 10,
                      child: Text(
                        movie.name.toUpperCase(),
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
                      "(${movie.detail.censor}) ${movie.detail.content}",
                      style: Theme.of(context)
                          .textTheme
                          .subhead
                          .copyWith(wordSpacing: 0),
                    ),
                    Text(
                      "${movie.detail.duration} minutes",
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
                width: MediaQuery.of(context).size.width - reserveWidth - 8,
                child: Row(
                  children: <Widget>[
                    Row(children: <Widget>[
                      FloatingActionButton(
                        onPressed: () {},
                        heroTag: "${movie.id}-info",
                        mini: true,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.info_outline,
                          size: 16,
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () {},
                        heroTag: "${movie.id}-share",
                        mini: true,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.share,
                          size: 16,
                        ),
                      ),
                    ]),
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
              shadow: Shadow(color: Colors.black54), clipper: LeftClipRectClipper(), child: widget),
//        widget,
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
        border: Border(
          bottom: BorderSide(color: Theme.of(context).cardColor, width: 1),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget listView = ListView.builder(
      itemCount: items.length,
      itemBuilder: (c, position) {
        var movie = Movie().fromJson(items[position]);
        return GestureDetector(
          child: itemView(context, movie),
          onTap: () {
//            Navigator.push(context, SlideLeftRoute(widget: BookingPage(title: movie["Name"],)));
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BookingPage(
                          movie: movie,
                        )));
          },
        );
      },
    );
    return Container(
      child: listView,
    );
  }
}
