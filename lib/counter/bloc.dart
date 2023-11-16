import 'dart:async';

import 'package:bloc/bloc.dart';

part "event.dart";
part "state.dart";

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc()
      : super(
          const CounterState(
            count: 42,
          ),
        ) {
    on<CounterEventIncrement>(_incrementCounter);
  }

  FutureOr<void> _incrementCounter(
      CounterEventIncrement event, Emitter<CounterState> emit) {
    emit(
      CounterState(
        count: state.count + 1,
      ),
    );
  }
}
