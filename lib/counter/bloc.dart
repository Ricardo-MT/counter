import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:counter/data/counter_repository.dart';

part "event.dart";
part "state.dart";

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc({required CounterRepository counterRepository})
      : _counterRepository = counterRepository,
        super(
          const CounterState(
            count: 42,
          ),
        ) {
    on<CounterEventIncrement>(_incrementCounter);
    on<CounterEventDecrement>(_decrementCounter);
    on<CounterEventGetRandomNumber>(_getRandomNumber);
  }

  final CounterRepository _counterRepository;

  FutureOr<void> _incrementCounter(
      CounterEventIncrement event, Emitter<CounterState> emit) {
    final nextCounter = state.count + 1;
    emit(
      CounterState(
        count: nextCounter,
      ),
    );
  }

  FutureOr<void> _decrementCounter(
      CounterEventDecrement event, Emitter<CounterState> emit) {
    final nextCounter = state.count - 1;
    emit(
      CounterState(
        count: nextCounter,
      ),
    );
  }

  FutureOr<void> _getRandomNumber(
      CounterEventGetRandomNumber event, Emitter<CounterState> emit) async {
    emit(
      CounterState(
        count: state.count,
        status: CounterStatus.loading,
      ),
    );
    try {
      final randomNumber = await _counterRepository.getRandomNumber();
      emit(
        CounterState(
          count: randomNumber,
          status: CounterStatus.success,
        ),
      );
    } catch (e) {
      emit(
        CounterState(
          count: state.count,
          status: CounterStatus.error,
        ),
      );
    }
  }
}
