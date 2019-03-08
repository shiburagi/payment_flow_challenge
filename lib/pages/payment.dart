import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class PaymentPage extends StatefulWidget {
  PaymentPage({
    this.adult,
    this.children,
    this.movie,
    Key key,
  }) : super(key: key);
  final int adult;
  final int children;
  final Map movie;

  @override
  _PaymentPageState createState() {
    return _PaymentPageState();
  }
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.movie["Name"]),
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return Stack(
          children: <Widget>[
            Hero(
                tag: "payment",
                child: Container(
                  constraints: constraint,
                  color: Colors.black,
                )),
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: Container(
                  width: constraint.maxWidth,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: <Widget>[
//                          Text("Movie Name : ${widget.movie["Name"]}")
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                      Container(
                        child: Text("Credit Card"),
                        padding: EdgeInsets.all(12),
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
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ),
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
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Column(
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
                        style: Theme.of(context).textTheme.headline,
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
                      Text(
                        "04/22",
                        style: Theme.of(context).textTheme.headline,
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            )
          ],
        ),
      ),
    );
  }
}
