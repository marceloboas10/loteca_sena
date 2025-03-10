import 'dart:math';

List geradorNumnerosMega() {
  var random = Random();
  var numeros = [];
  for (var i = 0; i < 6; i++) {
    var nextInt = random.nextInt(60) + 1;
    while (numeros.contains(nextInt)) {
      nextInt = random.nextInt(60) + 1;
    }
    numeros.add(nextInt);
  }

  

  return numeros;
}
