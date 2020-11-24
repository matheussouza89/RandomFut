import 'package:flutter/material.dart';
import 'package:randomfut/algorithms/sorteio.dart';
import 'package:randomfut/pages/timer.page.dart';
import 'package:randomfut/views/config_Time.dart';

class SorteadosCas extends StatefulWidget {
  @override
  _SorteadosCasState createState() => _SorteadosCasState();
}

var tamanhoList = (int.parse(nJogadores) / int.parse(nTimes)) * 30;

class _SorteadosCasState extends State<SorteadosCas> {
  @override
  Widget build(BuildContext context) {
    print(tamanhoList);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6ac860),
      ),
      backgroundColor: Color(0xFFe3f5df),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CountDownTimer(),
            ),
          );
        },
        label: Text("Ir para a Partida"),
        icon: Icon(Icons.sports_soccer),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Text("Time 1",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
              SizedBox(
                height: tamanhoList,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: time1.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 30,
                      child: Center(
                          child: Text('${time1[index]}',
                              style: TextStyle(
                                fontSize: 25,
                              ))),
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Column(
            children: [
              Text("Time 2",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
              SizedBox(
                height: tamanhoList,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: time2.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 30,
                      child: Center(
                          child: Text('${time2[index]}',
                              style: TextStyle(
                                fontSize: 25,
                              ))),
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Visibility(
              visible: visibilidadeTime3,
              child: Column(
                children: [
                  Text("Time 3",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
                  SizedBox(
                    height: tamanhoList,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: time3.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 30,
                          child: Center(
                              child: Text('${time3[index]}',
                                  style: TextStyle(
                                    fontSize: 25,
                                  ))),
                        );
                      },
                    ),
                  ),
                ],
              )),
          SizedBox(
            height: 30,
          ),
          Visibility(
              visible: visibilidadeTime4,
              child: Column(
                children: [
                  Text("Time 4",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
                  SizedBox(
                    height: tamanhoList,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: time3.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 30,
                          child: Center(
                              child: Text('${time3[index]}',
                                  style: TextStyle(
                                    fontSize: 25,
                                  ))),
                        );
                      },
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
