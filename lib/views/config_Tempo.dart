import 'package:flutter/material.dart';

var tempoJogo = "3";
var nroGols;
var _decisao = ['Sim', 'Não'];
var _itemSelecionado1 = 'Selecione a opção (opção padrão: Não)';
var visibilidade = false;

class ConfigTempo extends StatefulWidget {
  @override
  _ConfigTempoState createState() => _ConfigTempoState();
}

class _ConfigTempoState extends State<ConfigTempo> {
  final _formTempo = GlobalKey<FormState>();

  void _selecaoTermino(String novoItem) {
    setState(() {
      _itemSelecionado1 = novoItem;
      if (novoItem == 'Sim') {
        visibilidade = true;
      } else {
        visibilidade = false;
      }
    });
  }

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
                initialValue: "10",
                decoration:
                    InputDecoration(labelText: 'Tempo de Jogo (em minutos):'),
                onSaved: (value) => tempoJogo = value,
              ),
              Text("Término de partida por número de gols"),
              DropdownButton(
                items: _decisao.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                onChanged: (String novoItemSelecionado) {
                  _selecaoTermino(novoItemSelecionado);
                },
                hint: Text(_itemSelecionado1),
              ),
              Visibility(
                child: TextFormField(
                  initialValue: "2",
                  decoration: InputDecoration(
                      labelText: 'Gols para terminar a partida:'),
                  onSaved: (value) => nroGols = value,
                ),
                visible: visibilidade,
              )
            ],
          ),
        ),
      ),
    );
  }
}
