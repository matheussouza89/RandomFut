import 'dart:math';
import 'package:randomfut/pages/listaCadasCas.page.dart';
import 'package:randomfut/views/config_Time.dart';

Random r = Random();
var time1 = [];
var time2 = [];
var time3 = [];
var time4 = [];
sorteio() {
  balanceamento = 'Sim';
  double rateTotal = 0;
  var sorteados = [];
  for (int i = 0; i < vetJogador.length; i++) {
    sorteados.add('');
    rateTotal += vetJogador[i].rate;
  }
  print(rateTotal);
  if (balanceamento == 'Não' && pBalanceamento == 'Não') {
    print(balanceamento);
    for (int i = 0; i < vetJogador.length; i++) {
      var aux = r.nextInt(vetJogador.length);
      sorteados[aux] == '' ? sorteados[aux] = vetJogador[i] : i--;
    }
    if (nTimes == "2") {
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
      print(time1);
      print(time2);
    } else if (nTimes == "3") {
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
      print(time1);
      print(time2);
      print(time3);
    } else {
      // Esta condição é para o caso de 4 Times
      time1 = [];
      time2 = [];
      time3 = [];
      time4 = [];
      for (int i = 0; i < sorteados.length / 4; i++) {
        time1.add('');
        time2.add('');
        time3.add('');
        time4.add('');
      }
      for (int i = 0; i < sorteados.length / 4; i++) {
        time1[i] = sorteados[i];
        time2[i] = sorteados[((sorteados.length ~/ 2) - 1) - i];
        time3[i] = sorteados[((sorteados.length ~/ 2)) + i];
        time4[i] = sorteados[(sorteados.length - 1) - i];
      }
      print(time1);
      print(time2);
      print(time3);
      print(time4);
    }
  } else if (balanceamento == 'Sim' && pBalanceamento == 'Não') {
    time1 = [];
    time2 = [];
    for (int i = 0; i < sorteados.length / 2; i++) {
      time1.add('');
      time2.add('');
    }
    double maior = -1;
    for (int i = 0; i < vetJogador.length; i++) {
      for (int j = 0; j < vetJogador.length; j++) {
        if (maior <= vetJogador[i].rate) {
          maior = vetJogador[i].rate;
          if (i % 2 == 0) {
            sorteados.add(vetJogador[i]);
          } else {
            sorteados[(sorteados.length - 1) - i] = vetJogador[i];
          }
        } else {
          j--;
        }
      }
    }
    print(time1);
    print(time2);
    print("Oi");
    for (int i = 0; i < sorteados.length / 2; i++) {
      time1[i] = sorteados[i];
      time2[i] = sorteados[((sorteados.length - 1) - i)];
    }
  } else if (balanceamento == 'Sim' && pBalanceamento == 'Não') {
  } else if (balanceamento == 'Sim' && pBalanceamento == 'Sim') {}
}
