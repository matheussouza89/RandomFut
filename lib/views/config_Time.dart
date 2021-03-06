import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:randomfut/views/listaCadasCas.page.dart';

var nTimes = _itemSelecionado1 == 'Selecione a opção (opção padrão: 2)'
    ? "2"
    : _itemSelecionado1;
var nJogadores = _itemSelecionado1 == 'Selecione a opção (opção padrão: 2)'
    ? "10"
    : _itemSelecionado2;
bool balanceamento = _itemSelecionado3 == true ? true : false;
bool pBalanceamento = _itemSelecionado4 == true ? true : false;
var _decisaoTime = ['2', '3', '4'];
var _decisaoJog = [''];
var _itemSelecionado1 = 'Selecione a opção (opção padrão: 2)';
var _itemSelecionado2 = 'Selecione o numero total de Jogadores';
bool _itemSelecionado3 = false;
bool _itemSelecionado4 = false;
bool visibilidade = false;
bool visibilidadeTime3 = false;
bool visibilidadeTime4 = false;

class ConfigTime extends StatefulWidget {
  @override
  _ConfigTimeState createState() => _ConfigTimeState();
}

class _ConfigTimeState extends State<ConfigTime> {
  final _formTime = GlobalKey<FormState>();

  initState() {
    super.initState();
    print(balanceamento);
  }

  numeroJogadoresF() {
    setState(() {
      if (_itemSelecionado1 == '2') {
        _decisaoJog = ['6', '8', '10', '12'];
      } else if (_itemSelecionado1 == '3') {
        _decisaoJog = ['9', '12', '15', '18'];
      } else if (_itemSelecionado1 == '4') {
        _decisaoJog = ['12', '16', '20', '24'];
      }
    });
  }

  void _selecaoNTime(String novoItem) {
    setState(() {
      _itemSelecionado1 = novoItem;
      _itemSelecionado2 = 'Selecione o numero total de Jogadores';
      if (_itemSelecionado1 == '2' &&
          _itemSelecionado2 == 'Selecione o numero total de Jogadores') {
        nJogadores = '10';
        visibilidadeTime3 = false;
        visibilidadeTime4 = false;
      } else if (_itemSelecionado1 == '3' &&
          _itemSelecionado2 == 'Selecione o numero total de Jogadores') {
        nJogadores = '15';
        visibilidadeTime3 = true;
        visibilidadeTime4 = false;
      } else if (_itemSelecionado1 == '4' &&
          _itemSelecionado2 == 'Selecione o numero total de Jogadores') {
        nJogadores = '20';
        visibilidadeTime3 = true;
        visibilidadeTime4 = true;
      }
      visibilidade = true;
      numeroJogadoresF();
    });
  }

  void _selecaoNJog(String novoItem) {
    setState(() {
      _itemSelecionado2 = novoItem;
      nJogadores = _itemSelecionado2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          'Configuração de Times',
          maxFontSize: 30,
          maxLines: 1,
        ),
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
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formTime,
            child: Column(
              children: [
                AutoSizeText(
                  "Numero de Times",
                  style: TextStyle(fontSize: 20),
                  minFontSize: 15,
                  maxFontSize: 30,
                  maxLines: 1,
                ),
                DropdownButton(
                  items: _decisaoTime.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),
                  onChanged: (String novoItemSelecionado) {
                    _selecaoNTime(novoItemSelecionado);
                  },
                  hint: Text(_itemSelecionado1),
                ),
                Visibility(
                  visible: visibilidade,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Text(
                        "Numero de Jogadores",
                        style: TextStyle(fontSize: 20),
                      ),
                      DropdownButton(
                        items: _decisaoJog.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                        onChanged: (String novoItemSelecionado) {
                          _selecaoNJog(novoItemSelecionado);
                        },
                        hint: Text(_itemSelecionado2),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Text(
                  "Times Balanceados",
                  style: TextStyle(fontSize: 20),
                ),
                Switch(
                    value: _itemSelecionado3,
                    onChanged: (value) {
                      print(_itemSelecionado3);
                    }),
                SizedBox(
                  height: 60,
                ),
                Text(
                  "Sorteio com Base na Posição",
                  style: TextStyle(fontSize: 20),
                ),
                Switch(
                    value: _itemSelecionado4,
                    onChanged: (value) {
                      setState(() {
                        if (_itemSelecionado4 == true) {
                          _itemSelecionado4 = false;
                        } else {
                          _itemSelecionado3 = false;
                          _itemSelecionado4 = true;
                        }
                      });
                      print(_itemSelecionado4);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
