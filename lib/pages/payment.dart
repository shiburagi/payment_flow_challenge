import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:payment_flow_challenge/entities/booking_detail.dart';
import 'package:payment_flow_challenge/entities/movie.dart';
import 'package:payment_flow_challenge/entities/ticket.dart';
import 'package:payment_flow_challenge/pages/pin.dart';
import 'package:payment_flow_challenge/utils/palette.dart';
import 'package:payment_flow_challenge/view/countdown.dart';

class PaymentPage extends StatefulWidget {
  PaymentPage({
    this.bookingDetail,
    this.movie,
    Key key,
  }) : super(key: key);
  final Movie movie;
  final BookingDetail bookingDetail;

  @override
  _PaymentPageState createState() {
    return _PaymentPageState();
  }
}

class _PaymentPageState extends State<PaymentPage> {
  buildTableRow(BuildContext context, BoxConstraints constraint, List cells,
      {Map align = const {}, FontWeight fontWeight}) {
    int i = 0;
    return TableRow(
      children: cells.map((cell) {
        return TableCell(
          child: Container(
            padding: EdgeInsets.fromLTRB(16, 6, 16, 6),
            child: Text(
              cell,
              style: Theme.of(context)
                  .textTheme
                  .subtitle
                  .copyWith(fontWeight: fontWeight),
            ),
            alignment: align[i++],
          ),
        );
      }).toList(),
    );
  }

  Widget buildSummaryLayout(BuildContext context, BoxConstraints constraint) {
    Map align = {
      1: Alignment.center,
      2: Alignment.centerRight,
    };

    List<TableRow> children = [
      buildTableRow(
        context,
        constraint,
        [
          "Item",
          "",
          "total",
        ],
        align: align,
      ),
    ];
    if (widget.bookingDetail.adultCount > 0)
      children.add(buildTableRow(
        context,
        constraint,
        [
          "Adult",
          widget.bookingDetail.adultCount.toString(),
          widget.bookingDetail.priceForAdultsInString(),
        ],
        align: align,
      ));
    if (widget.bookingDetail.childrenCount > 0)
      children.add(
        buildTableRow(
          context,
          constraint,
          [
            "Children",
            widget.bookingDetail.childrenCount.toString(),
            widget.bookingDetail.priceForChildrenInString(),
          ],
          align: align,
        ),
      );
    children.addAll([
      buildTableRow(
        context,
        constraint,
        [
          "Booking Fee",
          "",
          widget.bookingDetail.totalBookingFeeInString(),
        ],
        align: align,
      ),
      buildTableRow(
        context,
        constraint,
        [
          "Total",
          "",
          widget.bookingDetail.totalPriceInString(),
        ],
        align: align,
        fontWeight: FontWeight.w700,
      ),
    ]);
    return Container(
      child: Column(
        children: <Widget>[
          Text("Summary"),
          Container(
            height: 16,
          ),
          Table(
            children: [
              buildTableRow(context, constraint, [widget.movie.name, ""],
                  fontWeight: FontWeight.w700),
              buildTableRow(context, constraint, [
                widget.bookingDetail.cinema,
                "",
              ]),
              buildTableRow(context, constraint, [
                widget.bookingDetail.hall,
                widget.bookingDetail.hallType,
              ]),
              buildTableRow(context, constraint, [
                widget.bookingDetail.date,
                widget.bookingDetail.time,
              ]),
            ],
          ),
          Container(
            height: 16,
          ),
          Table(
            border: TableBorder(
              horizontalInside:
                  BorderSide(width: 1, color: Palette.getDividerColor(context)),
//                verticalInside: BorderSide(width: 1, color: Colors.white54),
            ),
            children: children,
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      padding: EdgeInsets.all(16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Palette.getBackgroundColor(context),
        title: CountDownView(
          minutes: 10,
        ),
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return Stack(
          children: <Widget>[
            Hero(
                tag: "payment",
                child: Container(
                  constraints: constraint,
                  color: Palette.getBackgroundColor(context),
                )),
            Positioned(
              top: 0,
              bottom: 100,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: constraint.maxHeight - 200),
                  child: Container(
                    width: constraint.maxWidth,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: <Widget>[
//                          Text("Movie Name : ${widget.movie["Name"]}")
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Text("Credit Card"),
                              OutlineButton(
                                onPressed: () {},
                                child: Text("Add Card"),
                                textColor: Theme.of(context).accentColor,
                                padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40))),
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          padding: EdgeInsets.fromLTRB(16, 12, 16, 24),
                        ),
                        Container(
                          height: 200,
                          child: new Swiper(
                            itemBuilder: (BuildContext context, int index) {
                              return CreditCardView();
                            },
                            itemCount: 3,
                            viewportFraction: 0.8,
                            scale: 0.8,
                          ),
                        ),
                        Divider(
                          height: 48,
                          color: Palette.getDividerColor(context),
                        ),
                        buildSummaryLayout(context, constraint)
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 32,
              left: 48,
              right: 48,
              child: Column(children: [
                Hero(
                  tag: "next",
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => PinPage(
                                ticket:
                                    Ticket(widget.movie, widget.bookingDetail),
                              )));
                    },
                    icon: Icon(Icons.done),
                    label: Text("Confirm"),
                  ),
                ),
              ]),
            )
          ],
        );
      }),
    );
  }
}

class CreditCardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade900,
      elevation: 4,
      margin: EdgeInsets.only(bottom: 12),
      child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Text("Card Number",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(color: Colors.white70)),
                    Text(
                      "XXXX XXXXXX XXXXX",
                      style: Theme.of(context)
                          .textTheme
                          .headline
                          .copyWith(color: Colors.white),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text("Expire Date",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(color: Colors.white70)),
                    Row(
                      children: <Widget>[
                        Text(
                          "04/22",
                          style: Theme.of(context)
                              .textTheme
                              .headline
                              .copyWith(color: Colors.white),
                        ),
                        Image(
                          image: AssetImage("assets/images/visa.png"),
                          width: 64,
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          )),
    );
  }
}
