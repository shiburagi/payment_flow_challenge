import 'package:flutter/material.dart';
import 'package:payment_flow_challenge/dummy/hall.dart';
import 'package:payment_flow_challenge/entities/booking_detail.dart';
import 'package:payment_flow_challenge/pages/payment.dart';
import 'package:payment_flow_challenge/utils/palette.dart';

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

  List<Map> seatSelected = [];
  List<Map> list = [];

  ScrollController scrollController;

  int numOfRows = 0;
  int numOfColumns = 0;

  @override
  void initState() {
    super.initState();
    int i = 0;
    var seats = halls["hall 6"];
    numOfRows = seats.length;
    numOfColumns = seats[0].length;
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
  double currentSize;

  @override
  Widget build(BuildContext context) {
    double width =
        ((MediaQuery.of(context).size.width - 64) / numOfColumns < seatSize
                ? seatSize * numOfColumns + 64
                : MediaQuery.of(context).size.width) *
            scale;

    double seatLayoutWidth = width - 32;

    currentSize = (seatLayoutWidth) / numOfColumns;
    if (scrollController == null)
      scrollController = new ScrollController(
          initialScrollOffset: (width - MediaQuery.of(context).size.width) / 2);
    return Scaffold(
//      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(widget.bookingDetail.cinema),
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0))),
              elevation: 4,
              color: Theme.of(context).primaryColor,
              margin: EdgeInsets.all(0),
              child: Container(
                height: 60,
              ),
            ),
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
                builder: (context, constraint) => Card(
                      clipBehavior: Clip.hardEdge,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Color.fromRGBO(74, 84, 89, 1)
                          : Colors.white,
                      //                                    color:Colors.grey.shade800,
                      elevation: 2,
                      margin: EdgeInsets.only(
                          left: 16, right: 16, top: 16, bottom: 116),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        controller: scrollController,
                        child: Container(
//                          padding: EdgeInsets.only(bottom: 120),
                          child: SizedBox(
                            width: seatLayoutWidth,
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
                                                      color: Palette
                                                              .getContrastColor(
                                                                  context)
                                                          .withOpacity(0.3),
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
                                                    color: Palette
                                                        .getContrastColor(
                                                            context),
                                                    fontWeight:
                                                        FontWeight.w700),
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 16, right: 16),
                                          child: buildSeatLayout(
                                              context, constraints),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
              ),
            ),
            Positioned(bottom: 0, child: buildInfoLayout(context))
          ],
        ),
      ),
    );
  }

  buildSeatLayout(BuildContext context, BoxConstraints constraints) {
    return Container(
      height: currentSize * numOfRows + 24,
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: numOfColumns,
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
                      border: Border.all(
                        color:
                            Palette.getContrastColor(context).withOpacity(0.5),
                      ),
                    )
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
                                color: !isSelected
                                    ? Palette.getContrastColor(context)
                                    : Colors.black,
                              ),
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
      child: Card(
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.all(0),
        elevation: 6,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0))),
        child: Container(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
          height: 120,
          padding: EdgeInsets.only(bottom: 24, top: 24, left: 24, right: 24),
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
      ),
    );
  }
}
