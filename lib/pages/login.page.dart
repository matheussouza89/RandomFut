import 'package:flutter/material.dart';
import 'package:randomfut/pages/modo.page.dart';
import 'package:randomfut/pages/timer.page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF41BC3F),
        padding: EdgeInsets.only(
          top: 10,
          left: 40,
          right: 40,
        ),
        child: ListView(
          children: [
            SizedBox(
              width: 217,
              height: 217,
              child: Image.asset('./assets/images/logo-Recuperado.png'),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: 55,
              width: 310,
              child: RaisedButton(
                onPressed: () => {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ModoPage(),
                    ),
                  )
                },
                elevation: 8,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Text(
                  "Entrar sem Login",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                color: Color(0xFF008000),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "OU \n Para acesso a mais recursos",
                style: TextStyle(color: Colors.white, fontSize: 20, height: 2),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 55,
              width: 310,
              child: Container(
                height: 55,
                width: 310,
                child: RaisedButton(
                  onPressed: () => {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CountDownTimer(),
                      ),
                    )
                  },
                  elevation: 8,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  child: Row(
                    children: [
                      Container(
                        width: 10,
                      ),
                      Container(
                        height: 35,
                        width: 35,
                        child: Image.asset(
                          "./assets/images/facebookIcon.png",
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      Container(
                        width: 20,
                      ),
                      Text(
                        "Entrar com Facebook",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    ],
                  ),
                  color: Color(0xFF3D5A98),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 55,
              width: 310,
              child: RaisedButton(
                onPressed: () => {},
                elevation: 8,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Row(
                  children: [
                    Container(
                      width: 10,
                    ),
                    Container(
                      height: 35,
                      width: 35,
                      child: Image.asset(
                        "./assets/images/googleIcon.png",
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    Container(
                      width: 20,
                    ),
                    Text(
                      "Entrar com Google",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
                color: Color(0xFF1877F2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
