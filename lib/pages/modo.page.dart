import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:randomfut/pages/listaCadasCamp.dart';
import 'package:randomfut/pages/listaCadasCas.page.dart';

class ModoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            padding: EdgeInsets.only(right: 40),
            child: IconButton(
              icon: Icon(Icons.info_outline_rounded),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => _infoDialog(context));
              },
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
                      builder: (context) => ListaCadasCas(),
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
                  
                },
                elevation: 8,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: AutoSizeText(
                  "MODO CAMPEONATO",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  minFontSize: 15,
                  maxFontSize: 40,
                  maxLines: 1,
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

Widget _infoDialog(BuildContext context) {
  return new AlertDialog(
    scrollable: true,
    title: const Text('Info. Modos de jogo'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Modo Casual",
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 10,),
        Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam eget rhoncus ante. Integer malesuada elit eget dui hendrerit, id scelerisque sem pulvinar. Ut a neque sed odio tempus rutrum luctus sed sapien. Suspendisse sodales, sapien ac feugiat luctus, risus dolor facilisis justo, quis sollicitudin ex nunc ut nisi. Aliquam efficitur velit eget felis mattis, fermentum consectetur leo eleifend. In hac habitasse platea dictumst. Quisque ac sem sit amet massa consectetur imperdiet.",
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 15,),
        Text(
          "Modo Campeonato",
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 10,),
        Text(
          "Pellentesque efficitur malesuada mauris, vitae porta elit sagittis a. Vestibulum molestie, nisi vitae tempus imperdiet, massa nisi pellentesque dolor, id tempus dui tellus a metus. Praesent vel porta nulla. Nam lobortis volutpat ex in condimentum. Nam orci purus, hendrerit iaculis erat ac, fermentum placerat justo.",
          textAlign: TextAlign.justify,
        )
      ],
    ),
    actions: [
      FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Entendido!"))
    ],
  );
}
