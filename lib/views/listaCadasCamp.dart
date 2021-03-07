import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:randomfut/controller/sorteio.dart';
import 'package:randomfut/bloc/team_bloc.dart';
import 'package:randomfut/db/database_provider.dart';
import 'package:randomfut/events/team/delete_team.dart';
import 'package:randomfut/events/team/set_teams.dart';
import 'package:randomfut/events/team/update_team.dart';
import 'package:randomfut/models/objJogador.dart';
import 'package:randomfut/models/team.dart';
import 'package:randomfut/views/campoSuperior.dart';
import 'package:randomfut/routes/app_routes.dart';
import 'package:randomfut/views/config_Tempo.dart';
import 'package:randomfut/views/config_Time.dart';
import 'package:randomfut/views/team_form.dart';

var notSelected = true;
var isShowing = false;
var selection = 0xFF41BC3F;
var titleCont = '';
var time = 0;
var vetTime = [];
int botaoSorteio = 0xFF008000;
var imagem;

class ListaCadasCamp extends StatefulWidget {
  @override
  _ListaCadasCampState createState() => _ListaCadasCampState();
}

class _ListaCadasCampState extends State<ListaCadasCamp> {
  @override
  initState() {
    super.initState();
    DatabaseProvider.db.upadateCheckTeams();
    DatabaseProvider.db.getTeams().then((teamList) {
      print(teamList);
      BlocProvider.of<TeamBloc>(context).add(
        SetTeams(teamList),
      );
    });
    //Inicializa as variaveis para o valor de origem
    notSelected = true;
    isShowing = false;
    titleCont = '';
    time = 0;
    vetTime = [];
    botaoSorteio = 0xFF008000;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF41BC3F),
      appBar: AppBar(
        actions: [
          Container(
            padding: EdgeInsets.only(right: 40),
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.TEAMFORM,
                );
              },
            ),
          ),
        ],
        centerTitle: true,
        title: AutoSizeText(
          "$titleCont",
          maxFontSize: 30,
          maxLines: 1,
        ),
        leading: Image.asset('./assets/images/iconeJogadores.png'),
        backgroundColor: Color(0xFF008000),
        elevation: 0,
      ),
      body: Container(
        child: BlocConsumer<TeamBloc, List<Team>>(
          builder: (context, teamList) {
            return Container(
              color: Color(0xFF41BC3F),
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  print("teamList: $teamList");
                  Team team = teamList[index];
                  final avatar = team.avatar == null
                      ? CircleAvatar(
                          child: Icon(
                            Icons.person,
                            size: 45,
                          ),
                          backgroundColor: Colors.grey[300],
                          foregroundColor: Colors.grey[600],
                        )
                      : CircleAvatar(
                          radius: 90,
                          backgroundImage: FileImage(new File(team.avatar)),
                          backgroundColor: Colors.transparent,
                        );
                  return Container(
                    color: Color(selection =
                        team.checked == false ? 0xFF41BC3F : 0xFF6ECE6C),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 13, 0, 13),
                          child: ListTile(
                            leading: GestureDetector(
                              child: Container(
                                height: 75,
                                width: 75,
                                child: avatar,
                              ),
                              onTap: () {
                                _showPerfil(team.name, team.avatar);
                              },
                            ),
                            title: Text(team.name),
                            onLongPress: () {
                              if (time == 0) {
                                toggleSelection(index, team.id, team.name,
                                    team.avatar, team.checked);
                              }
                            },
                            onTap: () {
                              if (time >= 1) {
                                toggleSelection(index, team.id, team.name,
                                    team.avatar, team.checked);
                              }
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
                                          print(index);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TeamForm(
                                                        team: team,
                                                        teamIndex: index,
                                                      )));
                                        }),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            title: Text("Excluir Jogador"),
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
                                                  DatabaseProvider.db
                                                      .deleteTeams(team.id)
                                                      .then((_) {
                                                    BlocProvider.of<TeamBloc>(
                                                            context)
                                                        .add(
                                                      DeleteTeam(index),
                                                    );
                                                    Navigator.of(context).pop();
                                                  });
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
                        ),
                        Divider(
                          height: 0,
                          indent: 40,
                          endIndent: 10,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                  );
                },
                itemCount: teamList.length,
              ),
            );
          },
          listener: (BuildContext context, teamList) {},
        ),
      ),
      floatingActionButton: Visibility(
        visible: isShowing,
        child: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
                child: Icon(Icons.people),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfigTime(),
                    ),
                  );
                },
                backgroundColor: Color(0xFF008000),
                label: 'Config. Time'),
            SpeedDialChild(
                child: Icon(Icons.access_time),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfigTempo(),
                    ),
                  );
                },
                backgroundColor: Color(0xFF008000),
                label: 'Config. Tempo'),
            SpeedDialChild(
              child: Icon(Icons.sync),
              onTap: () {
                if (time == int.parse(nJogadores)) {
                  sorteio();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CampoSuperior(),
                    ),
                  );
                }
              },
              backgroundColor: Color(botaoSorteio),
              label: 'Sortear',
            ),
          ],
        ),
      ),
    );
  }

  toggleSelection(teamIndex, id, name, avatar, checked) {
    setState(() {
      if (time < int.parse(nJogadores)) {
        if (checked == false) {
          Team team = Team(
            id: id,
            name: name,
            avatar: avatar,
            checked: true,
          );
          DatabaseProvider.db.updateTeams(team).then(
                (storedTeam) => BlocProvider.of<TeamBloc>(context).add(
                  UpdateTeam(teamIndex, team),
                ),
              );
          time++;
          titleCont = "Selecionados: $time/$nJogadores";
          var objJogador = ObjJogador();
          objJogador.name = name;
          vetTime.add(objJogador);

          print(vetTime[0].name);
        } else {
          Team team = Team(
            id: id,
            name: name,
            avatar: avatar,
            checked: false,
          );
          DatabaseProvider.db.updateTeams(team).then(
                (storedTeam) => BlocProvider.of<TeamBloc>(context).add(
                  UpdateTeam(teamIndex, team),
                ),
              );
          time--;
          titleCont = "Selecionados: $time/$nJogadores";
          for (var i = 0; i < vetTime.length; i++) {
            if ((vetTime[i].name == name)) {
              vetTime.removeAt(i);
              i = vetTime.length;
            }
          }
          print(vetTime);
        }
        if (time == 0) {
          titleCont = "";
        }
      } else {}
      if ((checked == true) && (time == int.parse(nJogadores))) {
        Team team = Team(
          id: id,
          name: name,
          avatar: avatar,
          checked: false,
        );
        DatabaseProvider.db.updateTeams(team).then(
              (storedTeam) => BlocProvider.of<TeamBloc>(context).add(
                UpdateTeam(teamIndex, team),
              ),
            );
        time--;
        titleCont = "Selecionados: $time/$nJogadores";
      }
      if (time <= 0) {
        notSelected = true;
        isShowing = false;
      } else {
        notSelected = false;
        isShowing = true;
      }
      if (time == int.parse(nJogadores)) {
        botaoSorteio = 0xFF008000;
      } else {
        botaoSorteio = 0xFF919191;
      }
    });
  }

  _showPerfil(name, avatar) {
    showDialog(
      context: context,
      builder: (context) {
        return Material(
          type: MaterialType.transparency,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.6,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Stack(
                    children: [
                      imagem = avatar == null
                          ? Container(
                              height: MediaQuery.of(context).size.width * 0.6,
                              width: MediaQuery.of(context).size.width * 0.6,
                              color: Colors.grey[300],
                              child: Icon(
                                Icons.person,
                                size: 250,
                                color: Colors.grey[600],
                              ),
                            )
                          : Container(
                              height: MediaQuery.of(context).size.width * 0.6,
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Image(
                                image: FileImage(File(avatar)),
                                fit: BoxFit.fill,
                              ),
                            ),
                      Container(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.15,
                            width: MediaQuery.of(context).size.width * 0.6,
                            color: Color(0x66FFFFFF),
                            child: Column(
                              verticalDirection: VerticalDirection.up,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Nome: $name",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
