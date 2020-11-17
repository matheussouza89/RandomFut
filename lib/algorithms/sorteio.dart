import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:randomfut/components/player_tile.dart';

var a = vetJogador;
Random r = Random();
var time1 = [];
var time2 = [];
var time3 = [];
var time4 = [];
var time5 = [];
int numeroTimes = 2;

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
    time1 = [];
    time2 = [];
    for (int i = 0; i < sorteados.length / 2; i++) {
      time1.add('');
      time2.add('');
    }
    for (int i = 0; i < sorteados.length / 2; i++) {
      time1[i] = sorteados[i];
      time2[i] = sorteados[((sorteados.length - 1) - i)];
    }
  }
  if (sorteados.length == 15 ||
      sorteados.length == 12 ||
      sorteados.length == 9) {
    // Esta condição é para o caso de 3 Times
    time1 = [];
    time2 = [];
    time3 = [];
    for (int i = 0; i < sorteados.length / 3; i++) {
      time1.add('');
      time2.add('');
      time3.add('');
    }
    for (int i = 0; i < sorteados.length / 3; i++) {
      time1[i] = sorteados[i];
      time2[i] =
          sorteados[((sorteados.length - 1) - (sorteados.length ~/ 3)) - i];
      time3[i] = sorteados[((sorteados.length - 1) - i)];
    }
  }
  print(sorteados);
  print(time1);
  print(time2);
  print(time3);
}
