import 'package:flutter/material.dart';
import 'campeonatoTipo.page.dart';

class CampeonatoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF41BC3F),
      appBar: AppBar(
        actions: [
          Container(
            padding: EdgeInsets.only(right: 40),
            child: Image.asset(
              './assets/images/icone-informacao.png',
              height: 25,
              width: 25,
              fit: BoxFit.contain,
            ),
          )
        ],
        backgroundColor: Color(0xFF41BC3F),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: 0,
          left: 40,
          right: 40,
        ),
        child: ListView(
          children: [
            SizedBox(
              child: Image.asset(
                './assets/images/iconeJogadores.png',
                height: 160,
                width: 113,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Container(
              height: 55,
              width: 310,
              child: RaisedButton(
                onPressed: () => {},
                elevation: 8,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Text(
                  "CADASTRO RÁPIDO",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                color: Color(0xFF008000),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Container(
              height: 55,
              width: 310,
              child: RaisedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CampeonatoTipoPage(),
                    ),
                  )
                },
                elevation: 8,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Text(
                  "TIMES CADASTRADOS",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                color: Color(0xFF008000),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
