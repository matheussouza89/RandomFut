import 'package:flutter/material.dart';
import 'package:randomfut/pages/listaCadasCas.page.dart';

var nJogadores = "10";
var _decisao = ['Sim', 'Não'];
var _itemSelecionado1 = 'Selecione a opção (opção padrão: Não)';
var _itemSelecionado2 = 'Selecione a opção (opção padrão: Não)';

class ConfigTime extends StatefulWidget {
  @override
  _ConfigTimeState createState() => _ConfigTimeState();
}

class _ConfigTimeState extends State<ConfigTime> {
  final _formTime = GlobalKey<FormState>();

  void _selecaoBalanceamento(String novoItem) {
    setState(() {
      _itemSelecionado1 = novoItem;
    });
  }

  void _selecaoBasePosicao(String novoItem) {
    setState(() {
      _itemSelecionado2 = novoItem;
    });
  }

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
                 Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListaCadasCas(),
                  ),
                );
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListaCadasCas(),
                  ),
                );
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
              Text("Times Balanceados"),
              DropdownButton(
                items: _decisao.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                onChanged: (String novoItemSelecionado) {
                  _selecaoBalanceamento(novoItemSelecionado);
                },
                hint: Text(_itemSelecionado1),
              ),
              Text("Sorteio com Base na Posição"),
              DropdownButton(
                items: _decisao.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                onChanged: (String novoItemSelecionado) {
                  _selecaoBasePosicao(novoItemSelecionado);
                },
                hint: Text(_itemSelecionado2),
              )
            ],
          ),
        ),
      ),
    );
  }
}
