import 'package:flutter/material.dart';
import 'package:payment_flow_challenge/entities/booking_detail.dart';
import 'package:payment_flow_challenge/pages/payment.dart';

class SeatSelection extends StatefulWidget {
  SeatSelection({
    this.movie,
    this.bookingDetail,
    Key key,
  }) : super(key: key);
  final movie;
  final BookingDetail bookingDetail;

  @override
  _SeatSelectionState createState() {
    return _SeatSelectionState();
  }
}

class _SeatSelectionState extends State<SeatSelection> {
  double seatSize = 26;

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

  ScrollController scrollController = ScrollController();

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
          "label": "${String.fromCharCode(i + 65)}${j.toString()}",
        });

        if (s > 0) {
          hasChair = true;
          j++;
        }
      });
      if (hasChair) i++;
    });
  }

  String addS(value) {
    return value > 1 ? "s" : "";
  }

  double scale = 1;
  double previousScale = 1;
  double startScale = 1;
  double currentSizeSize;

  @override
  Widget build(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width / seats[0].length < seatSize
                ? seatSize * seats[0].length
                : MediaQuery.of(context).size.width) *
            scale;

    currentSizeSize = width / seats[0].length;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.bookingDetail.cinema),
        ),
        body: Stack(
          children: <Widget>[
            GestureDetector(
              onScaleStart: (s) {
                setState(() {
                  startScale = scale;
                });
              },
              onScaleUpdate: (scaleDetails) {
                double newScale = startScale * scaleDetails.scale;
                if (newScale >= 1)
                  setState(() {
                    scale = newScale;
                  });
              },
              onScaleEnd: (s) {},
              child: LayoutBuilder(
                builder: (context, constraint) => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: scrollController,
                      child: Container(
                        padding: EdgeInsets.only(bottom: 120),
                        height: constraint.maxHeight - 0,
                        child: SizedBox(
                          width: width,
                          child: SingleChildScrollView(
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
                                                  bottom: BorderSide(
                                                      color: Colors.white,
                                                      width: 2))),
                                          child: Text(
                                            "Screen",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subhead
                                                .copyWith(
                                                    fontSize: Theme.of(context)
                                                            .textTheme
                                                            .subhead
                                                            .fontSize *
                                                        scale,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700),
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                        ),
                                        buildSeatLayout(context, constraints),
                                      ],
                                    )),
                          ),
                        ),
                      ),
                    ),
              ),
            ),
            Positioned(bottom: 0, child: buildInfoLayout(context))
          ],
        ));
  }

  buildSeatLayout(BuildContext context, BoxConstraints constraints) {
    return Container(
      constraints:
          BoxConstraints(maxHeight: currentSizeSize * seats.length + 20),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: seats[0].length,
        children: list.map((item) {
          int type = item["type"];
          String label = item["label"];
          bool isSelected = seatSelected.contains(item);
          return GestureDetector(
            onTap: () {
              seatSelect(item);
            },
            child: Container(
              width: seatSize,
              height: seatSize,
              alignment: Alignment.center,
              margin: EdgeInsets.all(2),
              decoration: type != 0
                  ? BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).accentColor
                          : Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      border: Border.all(color: Colors.white12))
                  : null,
              child: type == 2
                  ? Icon(
                      Icons.favorite,
                      color: Colors.pinkAccent,
                      size: 12 * scale,
                    )
                  : type == 1
                      ? Text(
                          label,
                          style: Theme.of(context).textTheme.caption.copyWith(
                              fontSize: 9 * scale,
                              color: isSelected ? Colors.black : Colors.white),
                        )
                      : null,
            ),
          );
        }).toList(),
      ),
    );
  }

  void seatSelect(seat) {
    setState(() {
      int i = seatSelected.indexOf(seat);
      if (i != -1)
        seatSelected.remove(seat);
      else if (widget.bookingDetail.totalTicket() > seatSelected.length)
        seatSelected.add(seat);
    });
  }

  buildInfoLayout(BuildContext context) {
    return Hero(
      tag: "payment",
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
                        "Requested seat${addS(widget.bookingDetail.totalTicket())} : ${widget.bookingDetail.totalTicket()}",
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
                backgroundColor:
                    seatSelected.length == widget.bookingDetail.totalTicket()
                        ? Theme.of(context).accentColor
                        : Theme.of(context).disabledColor,
                onPressed:
                    seatSelected.length == widget.bookingDetail.totalTicket()
                        ? () {
                            widget.bookingDetail.seats = seatSelected;
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => PaymentPage(
                                        bookingDetail: widget.bookingDetail,
                                        movie: widget.movie),
                                    fullscreenDialog: true), (route) {
                              return route.isFirst;
                            });
                          }
                        : null,
              ),
            )
          ],
        ),
      ),
    );
  }
}
