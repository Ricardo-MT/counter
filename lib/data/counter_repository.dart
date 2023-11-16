import 'package:counter/data/counter_service.dart';

class CounterRepository {
  CounterRepository({required this.counterService});

  final CounterService counterService;

  /// Simula una llamada a una API que devuelve una fecha,
  /// luego transforma esa fecha en un número entre 0 y 99.
  Future<int> getRandomNumber() async {
    final date = await counterService.getDate();
    final number = date.millisecondsSinceEpoch % 100;
    if (number % 5 == 0) {
      throw Exception("Simulando un error");
    }
    return number;
  }
}
