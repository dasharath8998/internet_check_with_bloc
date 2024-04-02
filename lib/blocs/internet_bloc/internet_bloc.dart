import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_bloc/blocs/internet_bloc/internet_event.dart';
import 'package:internet_bloc/blocs/internet_bloc/internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? streamSubscription;

  InternetBloc() : super(InternetInitialState()) {
    on<InternetConnectEvent>((event, emit) => emit(InternetConnectState()));
    on<InternetLostEvent>((event, emit) => emit(InternetLostState()));

    streamSubscription = _connectivity.onConnectivityChanged.listen(
      (result) {
        if (result == ConnectivityResult.wifi ||
            result == ConnectivityResult.mobile) {
          add(InternetConnectEvent());
        } else {
          add(InternetLostEvent());
        }
      },
    );
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
}
