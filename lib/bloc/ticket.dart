import 'package:bloc/bloc.dart';
import 'package:payment_flow_challenge/entities/ticket.dart';

class TicketBloc extends Cubit<TicketState> {
  TicketBloc() : super(TicketState());

  addTicket(Ticket ticket) {
    emit(state.copyWith(tickets: [...state.tickets ?? [], ticket]));
  }
}

class TicketState {
  final List<Ticket>? tickets;

  TicketState({this.tickets});

  TicketState copyWith({List<Ticket>? tickets}) =>
      TicketState(tickets: tickets ?? this.tickets);
}
