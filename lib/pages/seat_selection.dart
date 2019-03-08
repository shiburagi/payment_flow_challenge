import 'package:flutter/material.dart';

class SeatSelection extends StatefulWidget {
  SeatSelection({
    this.adult,
    this.children,
    Key key,
  }) : super(key: key);
  final int adult;
  final int children;

  @override
  _SeatSelectionState createState() {
    return _SeatSelectionState();
  }
}

class _SeatSelectionState extends State<SeatSelection> {
  double seatSize = 120;

  List<List<int>> seats = [
    [1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1],
    [1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1],
    [1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1],
    [1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1],
    [1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1],
    [1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1],
    [1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1],
    [1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1],
    [1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1],
    [1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1],
    [1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1],
    [1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 2, 2, 0, 0, 2, 2, 0, 0, 2, 2, 0, 0, 2, 2, 0],
  ];
  List<List<int>> transposeSeats = [];

  List<Map> seatSelected = [];
  List<Map> list = [];

  @override
  void initState() {
    super.initState();
    int i = 0;
    seats.forEach((seat) {
      bool hasChair = false;
      int j = 1;
      seat.forEach((s) {
        list.add({
          "index": list.length,
          "type": s,
          "label": "${String.fromCharCode(i + 65)}${j}",
        });

        if (s > 0) {
          hasChair = true;
          j++;
        }
      });
      if (hasChair) i++;
    });
    for (int j = 0; j < seats[0].length; j++) {
      transposeSeats.add([]);

      for (int i = 0; i < seats.length; i++) {
        transposeSeats[j].add(seats[i][j]);
      }
    }
  }

  String addS(value) {
    return value > 1 ? "s" : "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: AppBar(),
      body: Builder(builder: (context) => buildLayout(context)),
    );
  }

  buildSeatLayout(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          minWidth: 2000,
          maxHeight: MediaQuery.of(context).size.height -
              Scaffold.of(context).widget.appBar.preferredSize.height -
              MediaQuery.of(context).padding.top),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this would produce 2 rows.
        crossAxisCount: seats[0].length,
        // Generate 100 Widgets that display their index in the List
        children: list.map((item) {
          return buildSeat(context, item);
        }).toList(),
      ),
    );
  }

  buildSeatLayout3(BuildContext context) {
    int i = 0;
    bool hasChair = false;
    List<List<int>> seats = transposeSeats;

    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext context) {
          return CustomScrollView(
            scrollDirection: Axis.horizontal,
            key: PageStorageKey<String>("0"),
            slivers: <Widget>[
              SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverPadding(
                padding: EdgeInsets.only(top: 100),
                sliver: SliverFixedExtentList(
                  itemExtent: seatSize,
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {


                      List<int> list = seats[index];
                      if (hasChair) i++;
                      int j = 0;
                      hasChair = false;

                      return Column(
                          children: list.map((s) {
                        if (s > 0) {
                          hasChair = true;
                          j++;
                        }
                        return buildSeat(context, {
                          "index": index,
                          "type": s,
                          "label":
                              "${String.fromCharCode(i + 64)}${j.toString()}",
                        });
                      }).toList());
                    },
                    // The childCount of the SliverChildBuilderDelegate
                    // specifies how many children this inner list
                    // has. In this example, each tab has a list of
                    // exactly 30 items, but this is arbitrary.
                    childCount: seats.length ,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  buildSeatLayout2(BuildContext context) {
    int i = 0;
    bool hasChair = false;

    return ConstrainedBox(
      constraints: BoxConstraints(
          minWidth: 2000,
          maxHeight: MediaQuery.of(context).size.height -
              Scaffold.of(context).widget.appBar.preferredSize.height -
              MediaQuery.of(context).padding.top),
      child: Column(
        // Generate 100 Widgets that display their index in the List
        children: seats.map((list) {
          if (hasChair) i++;
          int j = 0;
          hasChair = false;
          return ListView.builder(
            itemBuilder: (context, index) {
              int s = list[index];
              if (s > 0) {
                hasChair = true;
                j++;
              }
              return buildSeat(context, {
                "index": index,
                "type": s,
                "label": "${String.fromCharCode(i + 64)}${j.toString()}",
              });
            },
          );
        }).toList(),
      ),
    );
  }

  void seatSelect(index) {
    setState(() {
      int i = seatSelected.indexOf(index);
      if (i != -1)
        seatSelected.remove(index);
      else if (widget.children + widget.adult > seatSelected.length)
        seatSelected.add(index);

      print("select ${i} ${index} ${seatSelected.toString()}");
    });
  }

  Widget buildSeat(BuildContext context, Map item) {
    int type = item["type"];
    String label = item["label"];
    return GestureDetector(
      onTap: () {
        seatSelect(item);
      },
      child: Container(
        width: seatSize,
        height: seatSize,
        alignment: Alignment.center,
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: type != 0
              ? seatSelected.contains(item)
                  ? Theme.of(context).primaryColor
                  : Colors.white54
              : null,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: type == 2
            ? Icon(
                Icons.favorite,
                color: Colors.pinkAccent,
                size: 12,
              )
            : type == 1
                ? Text(
                    label,
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(fontSize: 10),
                  )
                : null,
      ),
    );
  }

  singleScrollView(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 200),
        child: LayoutBuilder(
            builder: (context, constraints) => Column(
                  children: <Widget>[
                    Container(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 12),
                      width: constraints.maxWidth,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.white, width: 2))
//                              color: Colors.white54,
                          ),
                      child: Text(
                        "Screen",
                        style: Theme.of(context).textTheme.subhead.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Container(
                      height: 40,
                    ),
                    buildSeatLayout2(context),
                    Container(
                      height: 120,
                    )
                  ],
                )),
      ),
    );
  }

  nestedScrollView(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          // These are the slivers that show up in the "outer" scroll view.
          return <Widget>[
            SliverOverlapAbsorber(
              // This widget takes the overlapping behavior of the SliverAppBar,
              // and redirects it to the SliverOverlapInjector below. If it is
              // missing, then it is possible for the nested "inner" scroll view
              // below to end up under the SliverAppBar even when the inner
              // scroll view thinks it has not been scrolled.
              // This is not necessary if the "headerSliverBuilder" only builds
              // widgets that do not overlap the next sliver.
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              child: SliverAppBar(
                // This is the title in the app bar.
                pinned: true,
                // The "forceElevated" property causes the SliverAppBar to show
                // a shadow. The "innerBoxIsScrolled" parameter is true when the
                // inner scroll view is scrolled beyond its "zero" point, i.e.
                // when it appears to be scrolled below the SliverAppBar.
                // Without this, there are cases where the shadow would appear
                // or not appear inappropriately, because the SliverAppBar is
                // not actually aware of the precise position of the inner
                // scroll views.
                forceElevated: innerBoxIsScrolled,
              ),
            ),
          ];
        },
        body: buildSeatLayout3(context));
  }

  buildLayout(BuildContext context) {
    return Stack(
      children: <Widget>[
        nestedScrollView(context),
        Positioned(
          bottom: 0,
          child: Container(
            height: 120,
            padding: EdgeInsets.only(bottom: 24, top: 24, left: 24, right: 24),
            color: Colors.black,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Seat${addS(seatSelected.length)} selected : ${seatSelected.length}",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(
                            "Requested seat${addS(widget.adult + widget.children)} : ${widget.adult + widget.children}",
                            style: Theme.of(context).textTheme.subtitle),
                        Container(
                          height: 2,
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
                  ),
                  flex: 1,
                ),
                Container(
                  child: FloatingActionButton(
                    child: Icon(Icons.credit_card),
                    heroTag: "next",
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
