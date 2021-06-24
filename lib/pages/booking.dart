import 'package:flutter/material.dart';
import 'package:payment_flow_challenge/components/backdrop_image.dart';
import 'package:payment_flow_challenge/components/dropdown.dart';
import 'package:payment_flow_challenge/components/number_textfield.dart';
import 'package:payment_flow_challenge/entities/booking_detail.dart';
import 'package:payment_flow_challenge/pages/seat_selection.dart';

class BookingPage extends StatefulWidget {
  BookingPage({Key? key, this.title, this.movie}) : super(key: key);
  final String? title;
  final movie;

  @override
  _BookingPageState createState() {
    return _BookingPageState();
  }
}

class _BookingPageState extends State<BookingPage> {
  double itemHeight = 100.0;
  double radius = 24.0;
  int totalField = 2;

  int diffPerTone = 12;

  DropDownController cinemaController = DropDownController();
  DropDownController hallTypeController = DropDownController();
  DropDownController dateController = DropDownController();
  DropDownController timeController = DropDownController();

  TextEditingController adultController = TextEditingController();
  TextEditingController childrenController = TextEditingController();

  BookingDetail? detail;

  Color getColor(index) {
    int color;
    if (Theme.of(context).brightness == Brightness.dark)
      color =
          diffPerTone * totalField + 20 - (diffPerTone * (index + 1) as int);
    else
      color = 255 -
          diffPerTone * totalField +
          20 -
          (diffPerTone * (index + 1) as int);

    return Color.fromRGBO(color, color, color, 1);
  }

  Widget itemContainer(context,
      {child, required int index, colorIndex, int span = 1}) {
    double top = (itemHeight - radius) * index + 0;
    return Container(
      margin: EdgeInsets.only(top: top),
      child: ClipRRect(
        child: Container(
          padding: EdgeInsets.only(top: 16, left: 8, right: 8),
          height: (itemHeight - radius) * span + radius,
          color: getColor(colorIndex),
          child: child,
        ),
        borderRadius: BorderRadius.only(topRight: Radius.circular(24)),
      ),
    );
  }

  buildPreview(BuildContext context) {
    Image image = Image.network(
      widget.movie.detail.urlforGraphic,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.fitHeight,
    );
    return BackdropImage(
      image: NetworkImage(widget.movie.detail.urlforGraphic),
      child: Container(
        height: 280,
        padding: EdgeInsets.only(bottom: radius),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
        ),
        child: Hero(
          tag: "${widget.movie.id}-image",
          child: image,
        ),
      ),
    );
  }

  updateBookingDetail() {
    detail = BookingDetail(
        cinemaController.value,
        hallTypeController.value,
        dateController.value,
        timeController.value,
        int.tryParse(adultController.text) ?? 0,
        int.tryParse(childrenController.text) ?? 0);
  }

  @override
  void initState() {
    super.initState();
    updateBookingDetail();
    var updateState = () => setState(() {
          updateBookingDetail();
        });

    cinemaController.onChanged((v) {
      updateState();
    });

    hallTypeController.onChanged((v) {
      updateState();
    });

    dateController.onChanged((v) {
      updateState();
    });

    timeController.onChanged((v) {
      updateState();
    });

    adultController.addListener(() {
      updateState();
    });

    childrenController.addListener(() {
      updateState();
    });
  }

  @override
  void dispose() {
    super.dispose();
    adultController.dispose();
    childrenController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.movie.name),
          iconTheme: IconThemeData(color: Theme.of(context).hintColor),
          textTheme: Theme.of(context).textTheme,
          backgroundColor: Theme.of(context).cardColor,
          elevation: 0,
        ),
        backgroundColor: getColor(totalField - 1),
        body: Container(
          color: getColor(totalField - 1),
          child: Stack(
            children: <Widget>[
              Container(
                child: SingleChildScrollView(
                  child: Container(
                    child: Stack(
                      children: <Widget>[
                        buildPreview(context),
                        Container(
                          margin: EdgeInsets.only(top: 280 - radius),
                          child: Stack(
                            children: <Widget>[
                              itemContainer(
                                context,
                                index: 0,
                                colorIndex: 0,
                                span: 4,
                                child: Column(
                                  children: <Widget>[
                                    DropDown(
                                      controller: cinemaController,
                                      hint: "Cinema",
                                      items: [
                                        "IOI Mall",
                                        "Mid Valley",
                                        "Nu Sentral",
                                        "Paradigm Mall",
                                      ],
                                    ),
                                    DropDown(
                                      controller: hallTypeController,
                                      hint: "Hall Type",
                                      items: [
                                        "ATMOS",
                                        "3D",
                                        "Normal",
                                      ],
                                    ),
                                    DropDown(
                                      controller: dateController,
                                      hint: "Date",
                                      items: [
                                        "Tue - Mar 05, 2019",
                                        "Wed - Mar 06, 2019",
                                        "Thu - Mar 07, 2019",
                                        "Fri - Mar 08, 2019",
                                      ],
                                    ),
                                    DropDown(
                                      controller: timeController,
                                      hint: "Time",
                                      items: [
                                        "12:00 PM",
                                        "3:30 PM",
                                        "7:00 PM",
                                      ],
                                    ),
                                    Container(
                                      height: radius,
                                    )
                                  ],
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                ),
                              ),
                              itemContainer(
                                context,
                                index: 4,
                                span: 2,
                                colorIndex: 1,
                                child: Column(
                                  children: <Widget>[
                                    NumberTextInput(
                                      hintText: "Adult",
                                      controller: adultController,
                                    ),
//
                                    NumberTextInput(
                                      hintText: "Children",
                                      controller: childrenController,
                                    ),
                                    Container(
                                      height: radius,
                                    )
                                  ],
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                ),
                              ),
                              Container()
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
                  left: 0,
                  right: 0,
                  child: Center(
                    child: FloatingActionButton(
                      child: Icon(Icons.event_seat),
                      heroTag: "next",
                      backgroundColor: detail!.validate()
                          ? Theme.of(context).accentColor
                          : Theme.of(context).disabledColor,
                      onPressed: detail!.validate()
                          ? () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) => SeatSelection(
                                      movie: widget.movie,
                                      bookingDetail: detail)));
                            }
                          : null,
                    ),
                  )),
            ],
          ),
        ));
  }
}
