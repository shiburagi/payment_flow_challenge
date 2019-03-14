import 'package:flutter/material.dart';
import 'package:payment_flow_challenge/components/backdrop_image.dart';
import 'package:payment_flow_challenge/entities/ticket.dart';
import 'package:payment_flow_challenge/utils/clip_shadow_path.dart';
import 'package:payment_flow_challenge/utils/custom_clipper.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HistoryView extends StatelessWidget {
  HistoryView({this.tickets = const [], Key key}) : super(key: key);
  final List<Ticket> tickets;

  dashLine(context, dashCount, double width, double height, color) {
    return Container(
      child: Column(
        children: List.generate(dashCount, (_) {
          return SizedBox(
            width: width,
            height: height,
            child: DecoratedBox(
              decoration: BoxDecoration(color: color),
            ),
          );
        }),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
      ),
    );
  }

  double itemHeight = 180;

  @override
  Widget build(BuildContext context) {
    List<Ticket> tickets = this.tickets.reversed.toList();
    return Container(
      color: Theme.of(context).primaryColor,
      child: LayoutBuilder(builder: (context, constraint) {
        return ListView.builder(
          itemBuilder: (context, index) {
            Ticket ticket = tickets[index];

            return buildTicket(context, constraint, ticket, index);
          },
          itemCount: tickets.length,
        );
      }),
    );
  }

  Widget buildTicket(BuildContext context, BoxConstraints constraint,
      Ticket ticket, int index) {
    String seatText =
        ticket.bookingDetail.seats.map((seat) => seat["label"]).join(", ");

    BorderSide border = BorderSide(color: Colors.black12, width: 1);
    return Dismissible(
      key: Key("$index"),
      onDismissed: (direction) {},
      child: Container(
        margin: EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Stack(
                children: <Widget>[
                  BackdropImage(
                    image: NetworkImage(ticket.movie.detail.urlforGraphic),
                    child: Container(
                      height: itemHeight,
                      width: 1000,
                      color: Colors.black38,
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: <Widget>[
                          Text(
                            ticket.movie.name,
                            style: Theme.of(context).textTheme.subhead.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "${ticket.bookingDetail.date}",
                            style: Theme.of(context)
                                .textTheme
                                .subhead
                                .copyWith(color: Colors.white),
                          ),
                          Text(ticket.bookingDetail.cinema,
                              style: Theme.of(context)
                                  .textTheme
                                  .subhead
                                  .copyWith(color: Colors.white)),
                          Text(seatText,
                              style: Theme.of(context)
                                  .textTheme
                                  .subhead
                                  .copyWith(color: Colors.white)),
                          Divider(
                            height: 32,
                            color: Colors.white,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "${ticket.bookingDetail.hall}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline
                                    .copyWith(color: Colors.white),
                              ),
                              Container(
                                width: 1,
                                height: 32,
                                color: Colors.white.withOpacity(0.7),
                              ),
                              Text(
                                "${ticket.bookingDetail.time}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          )
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 96,
              child: Stack(
                children: <Widget>[
                  ClipShadowPath(
                    clipper: TopBottomCurveClipper(),
                    shadow: Shadow(color: Colors.grey.shade600),
                    child: Container(
                      color: Colors.white,
                      height: itemHeight,
                      width: 24,
                      child: dashLine(context, 10, 1, 10, Colors.black54),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border(top: border, bottom: border, right: border),
                      ),
                      height: itemHeight,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(right: 8),
                      child: Column(
                        children: <Widget>[
                          QrImage(
                            data: "tic_$index",
                            errorCorrectionLevel: 3,
                            size: 64.0,
                            padding: EdgeInsets.all(0),
                            foregroundColor: Colors.grey.shade800,
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
        ),
      ),
    );
  }
}
