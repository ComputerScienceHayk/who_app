abstract class ConnectionCheckerState {
  const ConnectionCheckerState();
  List<Object> get props => [];
}

class Connected extends ConnectionCheckerState {
  final bool connected;

  const Connected(
    this.connected,
  );

  @override
  List<Object> get props => [connected];
}

class Disconnected extends ConnectionCheckerState {
  final bool connected;

  const Disconnected(
    this.connected,
  );

  @override
  List<Object> get props => [connected];
}
