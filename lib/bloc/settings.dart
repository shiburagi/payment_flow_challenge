import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:payment_flow_challenge/resources/session_manager.dart';

class SettingBloc extends Cubit<SettingState> {
  SettingBloc() : super(SettingState()) {
    final theme = SessionManager.instance.theme;
    if (theme != null)
      emit(state.copyWith(mode: theme == 0 ? ThemeMode.light : ThemeMode.dark));
  }

  changeTheme(int theme) {
    print("change : $theme");
    SessionManager.instance.theme = theme;
    emit(state.copyWith(mode: theme == 0 ? ThemeMode.light : ThemeMode.dark));
  }
}

class SettingState {
  final ThemeMode mode;

  SettingState({this.mode = ThemeMode.system});

  SettingState copyWith({ThemeMode? mode}) =>
      SettingState(mode: mode ?? this.mode);
}
