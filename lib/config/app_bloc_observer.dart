import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

class AppBlocObserver implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint('onChange -- ${bloc.runtimeType}, Change: $change');
  }

  @override
  void onClose(BlocBase bloc) {
    debugPrint('onClose -- ${bloc.runtimeType}');
  }

  @override
  void onCreate(BlocBase bloc) {
    debugPrint('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('onError -- ${bloc.runtimeType}, Error: $error');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    debugPrint('onEvent -- ${bloc.runtimeType}, Event: $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    debugPrint('onTransition -- ${bloc.runtimeType}, Transition: $transition');
  }
}
