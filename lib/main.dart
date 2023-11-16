import 'package:counter/counter/view.dart';
import 'package:counter/data/counter_repository.dart';
import 'package:counter/data/counter_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    RepositoryProvider(
      create: (BuildContext context) => CounterRepository(
        counterService: CounterService(),
      ),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: const CounterPage(),
    );
  }
}

final theme = ThemeData(
  scaffoldBackgroundColor: Colors.blue,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 30),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 50),
    ),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white, fontSize: 50),
  ),
  useMaterial3: true,
);
