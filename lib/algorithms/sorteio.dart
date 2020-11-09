import 'dart:math';
import 'package:randomfut/components/player_tile.dart';

var a = vetJogador;
Random r = Random();
var timeA = [];
var timeB = [];
var timeC = [];
var timeD = [];
var timeE = [];

sorteio() {
  var sorteados = [];
  for (int i = 0; i < a.length; i++) {
    sorteados.add('');
  }
  for (int i = 0; i < a.length; i++) {
    var aux = r.nextInt(a.length);
    sorteados[aux] == '' ? sorteados[aux] = a[i] : i--;
  }
  if (sorteados.length == 10 ||
      sorteados.length == 8 ||
      sorteados.length == 6) {
    // Esta condição é para o caso de 2 Times
    timeA = [];
    timeB = [];
    for (int i = 0; i < sorteados.length / 2; i++) {
      timeA.add('');
      timeB.add('');
    }
    for (int i = 0; i < sorteados.length / 2; i++) {
      timeA[i] = sorteados[i];
      timeB[i] = sorteados[((sorteados.length - 1) - i)];
    }
  }
  if (sorteados.length == 15 ||
      sorteados.length == 12 ||
      sorteados.length == 9) {
    // Esta condição é para o caso de 3 Times
    timeA = [];
    timeB = [];
    timeC = [];
    for (int i = 0; i < sorteados.length / 3; i++) {
      timeA.add('');
      timeB.add('');
      timeC.add('');
    }
    for (int i = 0; i < sorteados.length / 3; i++) {
      timeA[i] = sorteados[i];
      timeB[i] =
          sorteados[((sorteados.length - 1) - (sorteados.length ~/ 3)) - i];
      timeC[i] = sorteados[((sorteados.length - 1) - i)];
    }
  }
  print(sorteados);
  print(timeA);
  print(timeB);
  print(timeC);
}
