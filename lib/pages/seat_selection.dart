import 'package:flutter/material.dart';

class SeatSelection extends StatefulWidget {
  @override
  _SeatSelectionState createState() {
    return _SeatSelectionState();
  }
}

class _SeatSelectionState extends State<SeatSelection> {
  double seatSize = 40;

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

  List<Map> seatSelected = [];
  List<Map> list = [];

  @override
  void initState() {
    // TODO: implement initState
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: LayoutBuilder(
                  builder: (context, constraints) => Column(
                        children: <Widget>[
                          Container(
                            height: 20,
                          ),
                          Container(
                            height: 40,
                            width: constraints.maxWidth,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white54,
//                        borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Text(
                              "Screen",
                              style: Theme.of(context)
                                  .textTheme
                                  .subhead
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                          Container(
                            height: 40,
                          ),
                          buildSeatLayout(context),
                        ],
                      )),
            ),
          ],
        ));
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
          int index = item["index"];
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
        }).toList(),
      ),
    );
  }

  void seatSelect(index) {
    setState(() {
      int i = seatSelected.indexOf(index);
      if (i != -1)
        seatSelected.remove(index);
      else
        seatSelected.add(index);

      print("select ${i} ${index} ${seatSelected.toString()}");
    });
  }
}
