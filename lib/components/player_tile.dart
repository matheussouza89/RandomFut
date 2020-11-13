import 'package:flutter/material.dart';
import 'package:randomfut/models/player.dart';
import 'package:randomfut/provider/players.dart';
import 'package:randomfut/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:randomfut/views/config_Time.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

var notSelected = true;
var isShowing = false;
var selection = 0xFF41BC3F;
var tCas = Titulo();
var titleCont = "";
var jgdr;
var vetJogador = [];
int botaoSorteio = 0xFF008000;

class PlayerTile extends StatefulWidget {
  final Player player;

  const PlayerTile(this.player);

  @override
  _PlayerTileState createState() => _PlayerTileState();
}

class _PlayerTileState extends State<PlayerTile> {
  final Map<String, Object> _formData = {};

  void _loadFormData(Player player) {
    if (player != null) {
      _formData['id'] = player.id;
      _formData['name'] = player.name;
      _formData['position'] = player.position;
      _formData['avatar'] = player.avatar;
      _formData['rate'] = player.rate;
      _formData['checked'] = player.checked;
      _formData['cor'] = player.cor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final avatar = widget.player.avatar == null || widget.player.avatar.isEmpty
        ? CircleAvatar(child: Image.asset('./assets/images/emptyPlayer.png'))
        : CircleAvatar(
            child: Image.asset(widget.player.avatar),
          ); //Mudar Aqui para colocar a imagem do Usuario
    return Container(
      color: Color(widget.player.cor),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              child: Container(
                height: 50,
                width: 50,
                child: avatar,
              ),
            ),
            title: Text(widget.player.name),
            subtitle: Container(
              child: Column(
                children: [
                  Align(
                    child: Text(widget.player.position),
                    alignment: Alignment.centerLeft,
                  ),
                  Align(
                    child: SmoothStarRating(
                        allowHalfRating: false,
                        starCount: 5,
                        size: 20.0,
                        isReadOnly: true,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,
                        rating: widget.player.rate,
                        color: Colors.yellow,
                        borderColor: Colors.yellow,
                        spacing: 0.0),
                    alignment: Alignment.centerLeft,
                  ),
                ],
              ),
              alignment: Alignment.centerLeft,
            ),
            isThreeLine: true,
            onLongPress: () {
              toggleSelection();
              Provider.of<Players>(context, listen: false).put(
                Player(
                  id: _formData['id'],
                  name: _formData['name'],
                  position: _formData['position'],
                  avatar: _formData['avatar'],
                  rate: _formData['rate'],
                  checked: _formData['checked'],
                  cor: _formData['cor'],
                ),
              );
            },
            trailing: Visibility(
              visible: notSelected,
              child: Container(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          AppRoutes.PLAYERFORM,
                          arguments: widget.player,
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text('Excluir Jogador'),
                            content: Text(
                                'Tem certeza que quer excluir este jogador?'),
                            actions: [
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Não'),
                              ),
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Provider.of<Players>(context, listen: false)
                                      .remove(widget.player);
                                },
                                child: Text('Sim'),
                              ),
                            ],
                          ),
                        );
                      },
                      color: Colors.red,
                    )
                  ],
                ),
              ),
            ),
          ),
          Divider(
            height: 0,
            indent: 40,
            endIndent: 10,
            color: Colors.black26,
          )
        ],
      ),
    );
  }

  void toggleSelection() {
    _loadFormData(widget.player);
    setState(() {
      print(widget.player.checked);
      if (tCas._jogadorS < int.parse(nJogadores)) {
        if (widget.player.checked == false) {
          _formData['checked'] = true;
          _formData['cor'] = 0xFF6ECE6C;
          tCas.contCres();
          jgdr = tCas._jogadorS;
          titleCont = "Selecionados: $jgdr/$nJogadores";
          vetJogador.add(widget.player.name);
          print(vetJogador);
        } else {
          _formData['checked'] = false;
          _formData['cor'] = 0xFF41BC3F;
          tCas.contDecres();
          jgdr = tCas._jogadorS;
          titleCont = "Selecionados: $jgdr/$nJogadores";
          for (var i = 0; i < vetJogador.length; i++) {
            if (vetJogador[i] == widget.player.name) {
              vetJogador.removeAt(i);
              i = vetJogador.length;
            }
          }
          print(vetJogador);
        }
        if (tCas._jogadorS == 0) {
          titleCont = "";
        }
      }
      if ((widget.player.checked == true) &&
          (tCas._jogadorS == int.parse(nJogadores))) {
        _formData['checked'] = false;
        _formData['cor'] = 0xFF41BC3F;
        tCas.contDecres();
        jgdr = tCas._jogadorS;
        titleCont = "Selecionados: $jgdr/$nJogadores";
      }
      if (tCas._jogadorS <= 0) {
        notSelected = true;
        isShowing = false;
      } else {
        notSelected = false;
        isShowing = true;
      }
      if (jgdr == int.parse(nJogadores)) {
        botaoSorteio = 0xFF008000;
      } else {
        botaoSorteio = 0xFF919191;
      }
    });
  }
}

class Titulo {
  int _jogadorS = 0;

  void contCres() {
    this._jogadorS = _jogadorS + 1;
  }

  void contDecres() {
    this._jogadorS = _jogadorS - 1;
  }
}
