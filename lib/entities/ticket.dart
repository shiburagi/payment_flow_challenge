import 'package:payment_flow_challenge/entities/booking_detail.dart';
import 'package:payment_flow_challenge/entities/movie.dart';

class Ticket {
  Ticket(this.movie, this.bookingDetail);

  final Movie? movie;
  final BookingDetail? bookingDetail;
}
