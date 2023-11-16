import 'package:counter/counter/bloc.dart';
import 'package:counter/data/counter_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      create: (BuildContext context) => CounterBloc(
        counterRepository: context.read<CounterRepository>(),
      ),
      child: const _CounterView(),
    );
  }
}

class _CounterView extends StatelessWidget {
  const _CounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<CounterBloc, CounterState>(
            listenWhen: (previous, current) =>
                current.status != previous.status,
            listener: (context, state) {
              if (state.status == CounterStatus.error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Error en la api"),
                  ),
                );
              }
            },
          ),
          BlocListener<CounterBloc, CounterState>(
            listenWhen: (previous, current) => current.count != previous.count,
            listener: (context, state) {
              if (state.count % 10 == 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("${state.count} es múltiplo de 10"),
                  ),
                );
              }
            },
          ),
        ],
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GetRandomButton(),
              CounterDisplay(),
              CounterIncrement(),
              CounterDecrement(),
            ],
          ),
        ),
      ),
    );
  }
}

class CounterDisplay extends StatelessWidget {
  const CounterDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, CounterState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(state.count.toString()),
        );
      },
    );
  }
}

class CounterIncrement extends StatelessWidget {
  const CounterIncrement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () {
            context.read<CounterBloc>().add(CounterEventIncrement());
          },
          child: const Text("Incrementar")),
    );
  }
}

class CounterDecrement extends StatelessWidget {
  const CounterDecrement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () {
            context.read<CounterBloc>().add(CounterEventDecrement());
          },
          child: const Text("Decrementar")),
    );
  }
}

class GetRandomButton extends StatelessWidget {
  const GetRandomButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () {
          context.read<CounterBloc>().add(CounterEventGetRandomNumber());
        },
        child: const Text("Get random number"));
  }
}
