import 'dart:developer';

import 'package:bloc/bloc.dart';

class AppBlocObserver implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    log('onChange -- ${bloc.runtimeType}, Change: $change');
  }

  @override
  void onClose(BlocBase bloc) {
    log('onClose -- ${bloc.runtimeType}');
  }

  @override
  void onCreate(BlocBase bloc) {
    log('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError -- ${bloc.runtimeType}, Error: $error');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    log('onEvent -- ${bloc.runtimeType}, Event: $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log('onTransition -- ${bloc.runtimeType}, Transition: $transition');
  }
}
