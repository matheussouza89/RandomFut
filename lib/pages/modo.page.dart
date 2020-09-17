import 'package:flutter/material.dart';
import 'casual.page.dart';
import 'campeonato.page.dart';

class ModoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        color: Color(0xFF41BC3F),
        padding: EdgeInsets.only(
          top: 40,
          left: 40,
          right: 40,
        ),
        child: ListView(
          children: [
            SizedBox(
              child: Image.asset(
                './assets/images/iconeCasual.png',
                width: 110,
                height: 110,
                fit: BoxFit.contain,
              ),
            ),
            Container(
              height: 55,
              width: 310,
              child: RaisedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CasualPage(),
                    ),
                  )
                },
                elevation: 8,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Text(
                  "MODO CASUAL",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                color: Color(0xFF008000),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              child: Image.asset(
                './assets/images/iconeCampeonato.png',
                width: 110,
                height: 110,
                fit: BoxFit.contain,
              ),
            ),
            Container(
              height: 55,
              width: 310,
              child: RaisedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CampeonatoPage(),
                    ),
                  )
                },
                elevation: 8,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Text(
                  "MODO CAMPEONATO",
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
