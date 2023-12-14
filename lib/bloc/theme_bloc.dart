
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  // initial bloc v6
  ThemeBloc() : super(ThemeState(ThemeData())){
    on<ChangeTheme>((event, emit) => ThemeState(event.themeData));
  }

  // @override
  // ThemeState get initialState => ThemeState(ThemeData());
}
