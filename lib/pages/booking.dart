import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:payment_flow_challenge/components/dropdown.dart';
import 'package:payment_flow_challenge/pages/seat_selection.dart';

class BookingPage extends StatefulWidget {
  BookingPage({Key key, this.title, this.movie}) : super(key: key);
  final String title;
  final movie;

  @override
  _BookingPageState createState() {
    // TODO: implement createState
    return _BookingPageState();
  }
}

class _BookingPageState extends State<BookingPage> {
  double itemHeight = 100.0;
  double radius = 24.0;
  int totalField = 2;

  int diffPerTone = 12;

  Color getColor(index) {
    int color = diffPerTone * totalField + 20 - diffPerTone * (index + 1);

    return Color.fromRGBO(color, color, color, 1);
  }

  Widget itemContainer(context, constraints, {child, int index, colorIndex}) {
    double top = (itemHeight - radius) * index + 0;
    return Container(
      margin: EdgeInsets.only(top: top),
      child: ClipRRect(
        child: Container(
          padding: EdgeInsets.only(top: 16, left: 24, right: 24),
          height: itemHeight,
          color: getColor(colorIndex),
          width: constraints.maxWidth,
          child: child,
        ),
        borderRadius: BorderRadius.only(topRight: Radius.circular(24)),
      ),
    );
  }

  buildPreview(BuildContext context, BoxConstraints constraints) {
    Image image = Image.network(
      widget.movie["Detail"]["URLforGraphic"],
      width: constraints.maxWidth,
      fit: BoxFit.fitHeight,
    );
    return new Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: NetworkImage(widget.movie["Detail"]["URLforGraphic"]),
          fit: BoxFit.cover,
        ),
      ),
      child: new BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          height: 280,
          padding: EdgeInsets.only(bottom: radius),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
          ),
          child: Hero(
            tag: "${widget.movie["Id"]}-image",
            child: image,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.movie["Name"]),
          elevation: 0,
        ),
        backgroundColor: getColor(totalField - 1),
        body: LayoutBuilder(
          builder: (context, constraints) => Container(
                height: constraints.maxHeight,
                color: getColor(totalField - 1),
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: constraints.maxHeight,
                      child: SingleChildScrollView(
                        child: Container(
                          child: Stack(
                            children: <Widget>[
                              buildPreview(context, constraints),
                              Container(
                                margin: EdgeInsets.only(top: 280 - radius),
                                child: Stack(
                                  children: <Widget>[
                                    itemContainer(
                                      context,
                                      constraints,
                                      index: 0,
                                      colorIndex: 0,
                                      child: DropDown(
                                        hint: "Hall Type",
                                        items: [
                                          "ATMOS",
                                          "3D",
                                          "Normal",
                                        ],
                                      ),
                                    ),
                                    itemContainer(
                                      context,
                                      constraints,
                                      colorIndex: 0,
                                      index: 1,
                                      child: DropDown(
                                        hint: "Date",
                                        items: [
                                          "Tue - Mar 05, 2019",
                                          "Wed - Mar 06, 2019",
                                          "Thu - Mar 07, 2019",
                                          "Fri - Mar 08, 2019",
                                        ],
                                      ),
                                    ),
                                    itemContainer(
                                      context,
                                      constraints,
                                      index: 2,
                                      colorIndex: 0,
                                      child: DropDown(
                                        hint: "Time",
                                        items: [
                                          "12:00 PM",
                                          "3:30 PM",
                                          "7:00 PM",
                                        ],
                                      ),
                                    ),
                                    itemContainer(
                                      context,
                                      constraints,
                                      index: 3,
                                      colorIndex: 1,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            hintText: "Adult",
                                            contentPadding: EdgeInsets.fromLTRB(
                                                24, 16, 24, 16),
                                            border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 0,
                                                    color: Colors.transparent)),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 0,
                                                    color:
                                                        Colors.transparent))),
                                      ),
                                    ),
                                    itemContainer(
                                      context,
                                      constraints,
                                      index: 4,
                                      colorIndex: 1,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            hintText: "Children",
                                            contentPadding: EdgeInsets.fromLTRB(
                                                24, 16, 24, 16),
                                            border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 0,
                                                    color: Colors.transparent)),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 0,
                                                    color:
                                                        Colors.transparent))),
                                      ),
                                    ),
                                    Container(
                                      height: constraints.maxHeight,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 24,
                        left: constraints.maxWidth / 2 - 24,
                        child: FloatingActionButton(
                          child: Icon(Icons.event_seat),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => SeatSelection()));
                          },
                        )),
                  ],
                ),
              ),
        ));
  }
}
