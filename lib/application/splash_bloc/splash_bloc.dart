import 'dart:async';

import 'package:bloc_project/application/splash_bloc/splash_event.dart';
import 'package:bloc_project/application/splash_bloc/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitialState()) {
    Timer(const Duration(seconds: 4), () {
      add(SplashLoadedEvent());
    });
    on<SplashLoadedEvent>((event, emit) => emit(SplashLoadedLoginState()));
  }
}
