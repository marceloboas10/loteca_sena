import 'dart:math';

List geradorNunerosMega() {
  var random = Random();
  var numeros = <int>[];
  while (numeros.length < 6) {
    var nextInt = random.nextInt(60) + 1;
    if (!numeros.contains(nextInt)) {
      numeros.add(nextInt);
    }
  }
  return numeros;
}

List geradorNunerosParesMega() {
  var random = Random();
  var numeros = <int>[];

  while (numeros.length < 6) {
    var nextInt = random.nextInt(30) * 2 + 2;
    if (!numeros.contains(nextInt)) {
      numeros.add(nextInt);
    }
  }
  return numeros;
}

List geradorNunerosImparesMega() {
  var random = Random();
  var numeros = <int>[];

  while (numeros.length < 6) {
    var nextInt = random.nextInt(30) * 2 + 1;
    if (!numeros.contains(nextInt)) {
      numeros.add(nextInt);
    }
  }
  return numeros;
}
