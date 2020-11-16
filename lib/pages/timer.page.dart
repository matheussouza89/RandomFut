import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:randomfut/views/config_Tempo.dart';
import 'package:intl/intl.dart';

class CountDownTimer extends StatefulWidget {
  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  NumberFormat formatter = NumberFormat("00.##");
  int placarA = 0;
  int placarB = 0;
  int sec = 0;
  bool isRunning = false;
  bool start = true;
  double percent = 0;
  static int timeInMinut = int.parse(
      tempoJogo); //Adicionar aqui a variável de tempo que o usuário digitar
  int min = timeInMinut;
  int timeInSec = timeInMinut * 60;
  Timer timer;
  void _startTimer() {
    if (isRunning == false) {
      isRunning = true;
      start = false;
      min = timeInMinut;
      int time = timeInSec;
      double secPercent = ((100 / timeInSec) / 100);
      print(secPercent);
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (time > 0) {
            time--;
            timeInSec--;
            if (timeInSec % 60 == 0) {
              sec = 00;
            } else {
              if (sec == 00) {
                min--;
                sec = 60;
              }
              sec--;
            }
            if (percent < 1) {
              if ((percent + secPercent) < 1) {
                percent += secPercent;
              }
            } else {
              percent = 1;
            }
            formatter.format(min);
            formatter.format(sec);
            print(formatter.format(min));
          } else {
            percent = 0;
            timeInSec = 60;
            min = 00;
            sec = 00;
            timer.cancel();
          }
        });
      });
    } else {
      percent = 0;
      timeInSec = 60;
      min = 00;
      sec = 00;
      timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: FlatButton(onPressed: () {}, child: Icon(Icons.menu)),
          backgroundColor: Color(0xFF349632),
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF41BC3F), Color(0xFF349632)],
                  begin: FractionalOffset(0.5, 1))),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: CircularPercentIndicator(
                  percent: percent,
                  animation: true,
                  lineWidth: 20.0,
                  circularStrokeCap: CircularStrokeCap.round,
                  reverse: false,
                  animateFromLastPercent: true,
                  radius: 200.0,
                  progressColor: Colors.white,
                  center: Text(
                    "${formatter.format(min)}:${formatter.format(sec)}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 60.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Expanded(
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 30.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "variavel_timeA",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        "$placarA",
                                        style: TextStyle(fontSize: 50.0),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            child: FlatButton(
                                              onPressed: () {
                                                setState(() {
                                                  placarA++;
                                                });
                                              },
                                              child: Image.asset(
                                                'assets/images/bolaFut.png',
                                                height: 45,
                                              ),
                                              padding: EdgeInsets.all(0),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            height: 50,
                                            width: 50,
                                            child: FlatButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (placarA != 0) {
                                                    placarA--;
                                                  }
                                                });
                                              },
                                              child: Image.asset(
                                                'assets/images/anuladoFut.png',
                                                height: 45,
                                              ),
                                              padding: EdgeInsets.all(0),
                                            ),
                                          ),
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  child: Text(
                                    "VS",
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "variavel_timeB",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        "$placarB",
                                        style: TextStyle(fontSize: 50.0),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            child: FlatButton(
                                              onPressed: () {
                                                setState(() {
                                                  placarB++;
                                                });
                                              },
                                              child: Image.asset(
                                                'assets/images/bolaFut.png',
                                                height: 45,
                                              ),
                                              padding: EdgeInsets.all(0),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            height: 50,
                                            width: 50,
                                            child: FlatButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (placarB != 0) {
                                                    placarB--;
                                                  }
                                                });
                                              },
                                              child: Image.asset(
                                                'assets/images/anuladoFut.png',
                                                height: 45,
                                              ),
                                              padding: EdgeInsets.all(0),
                                            ),
                                          ),
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: isRunning,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 28.0),
                              child: RaisedButton(
                                color: Color(0xFF008000),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text(
                                    "Finalizar partida",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22.0),
                                  ),
                                ),
                                onPressed: () {
                                  _startTimer();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ),
                          Visibility(
                            visible: start,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 28.0),
                              child: RaisedButton(
                                color: Color(0xFF008000),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text(
                                    "Iniciar Partida",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22.0),
                                  ),
                                ),
                                onPressed: _startTimer,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
