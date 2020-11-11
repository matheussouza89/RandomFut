import 'package:flutter/material.dart';
import 'package:randomfut/algorithms/sorteio.dart';
import 'package:randomfut/pages/timer.page.dart';

class SorteadosCas extends StatefulWidget {
  @override
  _SorteadosCasState createState() => _SorteadosCasState();
}

class _SorteadosCasState extends State<SorteadosCas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Container(
              child: ListView.builder(
                itemCount: timeA.length,
                itemBuilder: (ctx, i) {
                  return Text(
                    timeA[i],
                    style: TextStyle(fontSize: 20),
                  );
                },
              ),
              height: 300,
            ),
            Container(
              child: ListView.builder(
                itemCount: timeB.length,
                itemBuilder: (ctx, i) {
                  return Text(
                    timeB[i],
                    style: TextStyle(fontSize: 20),
                  );
                },
              ),
              height: 300,
            ),
            Container(
              child: RaisedButton(child: Text("Ir para Partida"),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CountDownTimer(),
                    ),
                  );
              },
              color: Color(0xFF008000),),
            ),
          ],
        ),
      ),
    );
  }
}
