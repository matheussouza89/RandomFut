import 'dart:math';
import 'package:randomfut/components/player_tile.dart';

var a = vetJogador;
Random r = Random();

sorteio() {
  var sorteados = [];
  for (int i = 0; i < a.length; i++) {
    sorteados.add('');
  }
  for (int i = 0; i < a.length; i++) {
    var aux = r.nextInt(a.length);
    sorteados[aux] == '' ? sorteados[aux] = a[i] : i--;
  }
  print(sorteados);
}
