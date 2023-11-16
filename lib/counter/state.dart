part of "bloc.dart";

enum CounterStatus {
  initial,
  loading,
  success,
  error,
}

class CounterState {
  const CounterState({
    this.count = 0,
    this.status = CounterStatus.initial,
  });
  final int count;
  final CounterStatus status;
}
