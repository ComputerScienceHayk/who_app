import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sdh_task/feature/presentation/bloc/connection_checker_cubit/connection_checker_state.dart';

class ConnectionCheckerCubit extends Cubit<ConnectionCheckerState> {
  ConnectionCheckerCubit() : super(Connected());

  Future<void> execute(
    InternetConnectionChecker internetConnectionChecker,
  ) async {
    StreamSubscription<InternetConnectionStatus> listener =
        InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            emit(Connected());
            break;
          case InternetConnectionStatus.disconnected:
            emit(Disconnected());
            break;
        }
      },
    );
    await Future<void>.delayed(const Duration(seconds: 30));
    await listener.cancel();
  }
}
