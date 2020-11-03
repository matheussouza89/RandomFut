import 'package:flutter/material.dart';

var nJogadores = "10";

class ConfigTime extends StatelessWidget {
  final _formTime = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuração de Times'),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _formTime.currentState.save();
                Navigator.of(context).pop();
              })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formTime,
          child: Column(
            children: [
              TextFormField(
                initialValue: nJogadores,
                decoration: InputDecoration(labelText: 'Numero de Jogadores'),
                onSaved: (value) => nJogadores = value,
              ),
              TextFormField(
                initialValue: "Não",
                decoration: InputDecoration(labelText: 'Times Balanceados'),
                onSaved: (value) => () {},
              ),
              TextFormField(
                initialValue: "Não",
                decoration:
                    InputDecoration(labelText: 'Sorteio com Base na Posição'),
                onSaved: (value) => () {},
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
