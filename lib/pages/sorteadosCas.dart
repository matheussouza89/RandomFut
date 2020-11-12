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
        backgroundColor: Color(0xFF6ac860),
      ),
      backgroundColor: Color(0xFFe3f5df),
      body: Container(
        child: Column(
          children: [
            Container(
              child: ListView.builder(
                itemCount: timeA.length,
                itemBuilder: (ctx, i) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      timeA[i],
                      style: TextStyle(fontSize: 25,),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
              height: 300,
            ),
            Container(
              child: ListView.builder(
                itemCount: timeB.length,
                itemBuilder: (ctx, i) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      timeB[i],
                      style: TextStyle(fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
              height: 300,
            ),
            Container(
              height: 50,
              child: RaisedButton(
                child: Text("Ir para Partida",style: TextStyle(fontSize: 20),),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CountDownTimer(),
                    ),
                  );
                },
                color: Color(0xFF399a36),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
