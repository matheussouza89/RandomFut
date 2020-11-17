import 'package:flutter/material.dart';
import 'package:randomfut/models/team.dart';
import 'package:randomfut/pages/listaPlayerTeam.dart';
import 'package:randomfut/provider/teams.dart';
import 'package:provider/provider.dart';

var tCamp = Titulo();
var time;
var vetTime = [];
var titleCont = "";

class TeamTile extends StatefulWidget {
  final Team team;

  const TeamTile(this.team);

  @override
  _TeamTileState createState() => _TeamTileState();
}

class _TeamTileState extends State<TeamTile> {
  final Map<String, Object> _formData = {};

  void _loadFormData(Team team) {
    if (team != null) {
      _formData['id'] = team.id;
      _formData['name'] = team.name;
      _formData['avatar'] = team.avatar;
      _formData['checked'] = team.checked;
      _formData['cor'] = team.cor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final avatar = widget.team.avatar == null || widget.team.avatar.isEmpty
        ? CircleAvatar(child: Icon(Icons.people),backgroundColor: Colors.grey[300], foregroundColor: Colors.grey[600],)
        : CircleAvatar(
            child: Image.asset(widget.team.avatar),
          ); //Mudar Aqui para colocar a imagem do Usuario
    return Container(
      color: Color(widget.team.cor),
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
            title: Text(widget.team.name),
            subtitle: Text("3/5"),
            onLongPress: () {
              if(tCamp._timeS == 0){
              toggleSelection();
              Provider.of<Teams>(context, listen: false).put(
                Team(
                  id: _formData['id'],
                  name: _formData['name'],
                  avatar: _formData['avatar'],
                  checked: _formData['checked'],
                  cor: _formData['cor'],
                ),
              );
              }
            },
            onTap: () {
              if(tCamp._timeS >= 1){
              toggleSelection();
              Provider.of<Teams>(context, listen: false).put(
                Team(
                  id: _formData['id'],
                  name: _formData['name'],
                  avatar: _formData['avatar'],
                  checked: _formData['checked'],
                  cor: _formData['cor'],
                ),
              );
              }
            },
            trailing: Container(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('Excluir Time'),
                          content:
                              Text('Tem certeza que quer excluir este time?'),
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
                                Provider.of<Teams>(context, listen: false)
                                    .remove(widget.team);
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
    _loadFormData(widget.team);
    setState(() {
      if (widget.team.checked == false) {
        _formData['checked'] = true;
        _formData['cor'] = 0xFF6ECE6C;
        tCamp.contCres();
        time = tCamp._timeS;
        titleCont = "Selecionados: $time/10";
        vetTime.add(widget.team.name);
        print(vetTime);
      } else {
        _formData['checked'] = false;
        _formData['cor'] = 0xFF41BC3F;
        tCamp.contDecres();
        time = tCamp._timeS;
        titleCont = "Selecionados: $time/10";
        for (var i = 0; i < vetTime.length; i++) {
          if (vetTime[i] == widget.team.name) {
            vetTime.removeAt(i);
            i = vetTime.length;
          }
        }
        print(vetTime);
      }
      if (tCamp._timeS == 0) {
        titleCont = "";
      }
    });
  }
}

class Titulo {
  int _timeS = 0;

  void contCres() {
    this._timeS = _timeS + 1;
  }

  void contDecres() {
    this._timeS = _timeS - 1;
  }
}
