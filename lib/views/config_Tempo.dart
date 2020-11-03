import 'package:flutter/material.dart';

var tempoJogo;

class ConfigTempo extends StatelessWidget {
  final _formTempo = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuração de Tempo'),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _formTempo.currentState.save();
                Navigator.of(context).pop();
              })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formTempo,
          child: Column(
            children: [
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Tempo de Jogo (em minutos):'),
                onSaved: (value) => tempoJogo = value,
              ),
              TextFormField(
                initialValue: "Não",
                decoration:
                    InputDecoration(labelText: 'Término de Jogo por Gols:'),
                onSaved: (value) => () {
                  tempoJogo = value;
                },
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
