import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

var tempoJogo = _itemSelecionado1 == 'Selecione a opção (opção padrão: 5)'
    ? '5'
    : _itemSelecionado1;
var nroGols = _itemSelecionado2 == 'Selecione a opção (opção padrão: Não)'
    ? null
    : _itemSelecionado3;
var _decisao = ['Sim', 'Não'];
var _decisaoTempo = ['3', '4', '5', '6', '7', '8', '9', '10'];
var _decisaoGols = ['2', '3', '4', '5', '6', '7', '8', '9', '10'];
var _itemSelecionado1 = 'Selecione a opção (opção padrão: 5)';
var _itemSelecionado2 = 'Selecione a opção (opção padrão: Não)';
var _itemSelecionado3 = 'Selecione a opção (opção padrão: )';
var visibilidade = false;

class ConfigTempo extends StatefulWidget {
  @override
  _ConfigTempoState createState() => _ConfigTempoState();
}

class _ConfigTempoState extends State<ConfigTempo> {
  final _formTempo = GlobalKey<FormState>();

  void _selecaoTempo(String novoItem) {
    setState(() {
      _itemSelecionado1 = novoItem;
      if (_itemSelecionado2 == 'Não' ||
          _itemSelecionado2 == 'Selecione a opção (opção padrão: Não)') {
        nroGols = null;
      }
    });
  }

  void _selecaoTermino(String novoItem) {
    setState(() {
      _itemSelecionado2 = novoItem;
      if (novoItem == 'Sim') {
        visibilidade = true;
      } else {
        visibilidade = false;
      }
    });
  }

  void _selecaoNroGols(String novoItem) {
    setState(() {
      _itemSelecionado3 = novoItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText('Configuração de Tempo',maxFontSize: 30,maxLines: 1,),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _formTempo.currentState.save();
                Navigator.of(context).pop();
              })
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formTempo,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  AutoSizeText(
                    "Tempo de partida:",
                    style: TextStyle(fontSize: 20),
                  ),
                  DropdownButton(
                    items: _decisaoTempo.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (String novoItemSelecionado) {
                      _selecaoTempo(novoItemSelecionado);
                    },
                    hint: Text(_itemSelecionado1),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  AutoSizeText(
                    "Término de partida por número de gols:",
                    style: TextStyle(fontSize: 20),
                    minFontSize: 15,
                    maxLines: 2,
                  ),
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
                    hint: Text(_itemSelecionado2),
                  ),
                  Visibility(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        AutoSizeText(
                          "Quantidade de gols para término:",
                          style: TextStyle(fontSize: 20),
                          minFontSize: 15,
                          maxLines: 2,
                        ),
                        DropdownButton(
                          items: _decisaoGols.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem),
                            );
                          }).toList(),
                          onChanged: (String novoItemSelecionado) {
                            _selecaoNroGols(novoItemSelecionado);
                          },
                          hint: Text(_itemSelecionado3),
                        ),
                      ],
                    ),
                    visible: visibilidade,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
