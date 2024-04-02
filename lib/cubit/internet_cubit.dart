import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity/connectivity.dart';

enum InternetState { initial, connected, disconnected }

class InternetCubit extends Cubit<InternetState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? streamSubscription;

  InternetCubit() : super(InternetState.initial) {
    _connectivity.onConnectivityChanged.listen(
      (result) {
        if (result == ConnectivityResult.wifi ||
            result == ConnectivityResult.mobile) {
          emit(InternetState.connected);
        } else {
          emit(InternetState.disconnected);
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
