class BookingDetail {
  BookingDetail(
    this.cinema,
    this.hallType,
    this.date,
    this.time,
    this.adultCount,
    this.childrenCount,
  );

  final String cinema;
  final String hallType;
  final String date;
  final String time;
  final int adultCount;
  final int childrenCount;
  final String hall = "Hall 6";

  List seats;
  static const bookingFee = 0.50;

  bool validate() {
    return cinema != null &&
        hallType != null &&
        date != null &&
        time != null &&
        totalTicket() > 0;
  }

  int totalTicket() {
    return adultCount + childrenCount;
  }

  double priceForAdults() {
    return adultCount * 16.00;
  }

  String priceForAdultsInString() {
    return priceForAdults().toStringAsFixed(2).toString();
  }

  double priceForChildren() {
    return childrenCount * 10.00;
  }

  String priceForChildrenInString() {
    return priceForChildren().toStringAsFixed(2);
  }

  double totalBookingFee() {
    return totalTicket() * bookingFee;
  }

  String totalBookingFeeInString() {
    return totalBookingFee().toStringAsFixed(2);
  }

  double totalPrice() {
    return priceForChildren() + priceForAdults() + totalBookingFee();
  }

  String totalPriceInString() {
    return totalPrice().toStringAsFixed(2);
  }
}
