import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:randomfut/algorithms/sorteio.dart';
import 'package:randomfut/bloc/player_bloc.dart';
import 'package:randomfut/db/database_provider.dart';
import 'package:randomfut/events/delete_player.dart';
import 'package:randomfut/events/set_players.dart';
import 'package:randomfut/events/update_player.dart';
import 'package:randomfut/models/player.dart';
import 'package:randomfut/pages/campoSuperior.dart';
import 'package:randomfut/routes/app_routes.dart';
import 'package:randomfut/views/config_Tempo.dart';
import 'package:randomfut/views/config_Time.dart';
import 'package:randomfut/views/player_form.dart';

var notSelected = true;
var isShowing = false;
var selection = 0xFF41BC3F;
var titleCont = '';
var jgdr = 0;
var vetJogador = [];
int botaoSorteio = 0xFF008000;
var imagem;

class ListaCadasCas extends StatefulWidget {
  @override
  _ListaCadasCasState createState() => _ListaCadasCasState();
}

class _ListaCadasCasState extends State<ListaCadasCas> {
  @override
  initState() {
    super.initState();
    DatabaseProvider.db.upadateCheck();
    DatabaseProvider.db.getPlayers().then((playerList) {
      print(playerList);
      BlocProvider.of<PlayerBloc>(context).add(
        SetPlayers(playerList),
      );
    });
    //Inicializa as variaveis para o valor de origem
    notSelected = true;
    isShowing = false;
    titleCont = '';
    jgdr = 0;
    vetJogador = [];
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
                  AppRoutes.PLAYERFORM,
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
        leading: Image.asset('./assets/images/iconeJogador.png'),
        backgroundColor: Color(0xFF008000),
        elevation: 0,
      ),
      body: Container(
        child: BlocConsumer<PlayerBloc, List<Player>>(
          builder: (context, playerList) {
            return Container(
              color: Color(0xFF41BC3F),
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  print("playerList: $playerList");
                  Player player = playerList[index];
                  final avatar = player.avatar == null
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
                        backgroundImage: FileImage(new File(player.avatar)),
                        backgroundColor: Colors.transparent,
                        );
                  return Container(
                    color: Color(selection =
                        player.checked == false ? 0xFF41BC3F : 0xFF6ECE6C),
                    child: Column(
                      children: [
                        ListTile(
                          leading: GestureDetector(
                            child: Container(
                              height: 75,
                              width: 75,
                              child: avatar,
                            ),
                            onTap: () {
                              _showPerfil(player.name, player.position,
                                  player.rate, player.avatar);
                            },
                          ),
                          title: Text(player.name),
                          subtitle: Column(
                            children: [
                              Align(
                                child: Text(player.position),
                                alignment: Alignment.centerLeft,
                              ),
                              Align(
                                child: RatingBarIndicator(
                                  rating: player.rate,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 20.0,
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                            ],
                          ),
                          isThreeLine: true,
                          onLongPress: () {
                            if (jgdr == 0) {
                              toggleSelection(
                                  index,
                                  player.id,
                                  player.name,
                                  player.avatar,
                                  player.position,
                                  player.rate,
                                  player.checked);
                            }
                          },
                          onTap: () {
                            if (jgdr >= 1) {
                              toggleSelection(
                                  index,
                                  player.id,
                                  player.name,
                                  player.avatar,
                                  player.position,
                                  player.rate,
                                  player.checked);
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
                                                    PlayerForm(
                                                      player: player,
                                                      playerIndex: index,
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
                                                    .delete(player.id)
                                                    .then((_) {
                                                  BlocProvider.of<PlayerBloc>(
                                                          context)
                                                      .add(
                                                    DeletePlayer(index),
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
                itemCount: playerList.length,
              ),
            );
          },
          listener: (BuildContext context, playerList) {},
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
                if (jgdr == int.parse(nJogadores)) {
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

  toggleSelection(playerIndex, id, name, avatar, position, rate, checked) {
    setState(() {
      if (jgdr < int.parse(nJogadores)) {
        if (checked == false) {
          Player player = Player(
            id: id,
            name: name,
            avatar: avatar,
            position: position,
            rate: rate,
            checked: true,
          );
          DatabaseProvider.db.update(player).then(
                (storedPlayer) => BlocProvider.of<PlayerBloc>(context).add(
                  UpdatePlayer(playerIndex, player),
                ),
              );
          jgdr++;
          titleCont = "Selecionados: $jgdr/$nJogadores";
          vetJogador.add(name);
          print(vetJogador);
        } else {
          Player player = Player(
            id: id,
            name: name,
            avatar: avatar,
            position: position,
            rate: rate,
            checked: false,
          );
          DatabaseProvider.db.update(player).then(
                (storedPlayer) => BlocProvider.of<PlayerBloc>(context).add(
                  UpdatePlayer(playerIndex, player),
                ),
              );
          jgdr--;
          titleCont = "Selecionados: $jgdr/$nJogadores";
          for (var i = 0; i < vetJogador.length; i++) {
            if (vetJogador[i] == name) {
              vetJogador.removeAt(i);
              i = vetJogador.length;
            }
          }
          print(vetJogador);
        }
        if (jgdr == 0) {
          titleCont = "";
        }
      } else {}
      if ((checked == true) && (jgdr == int.parse(nJogadores))) {
        Player player = Player(
          id: id,
          name: name,
          avatar: avatar,
          position: position,
          rate: rate,
          checked: false,
        );
        DatabaseProvider.db.update(player).then(
              (storedPlayer) => BlocProvider.of<PlayerBloc>(context).add(
                UpdatePlayer(playerIndex, player),
              ),
            );
        jgdr--;
        titleCont = "Selecionados: $jgdr/$nJogadores";
      }
      if (jgdr <= 0) {
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

  _showPerfil(name, position, rate, avatar) {
    showDialog(
      context: context,
      builder: (context) {
        return Material(
          type: MaterialType.transparency,
          child: Center(
            child: Container(
              height: 200,
              width: 200,
              child: Stack(
                children: [
                  imagem = avatar == null ? Container(
        height: 200,
        width: 200,
        color: Colors.grey[300],
        child: Icon(
          Icons.person,
          size: 150,
        ),
      ):Image.file(new File(avatar)),
                  Container(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 60,
                        width: 200,
                        color: Color(0x99FFFFFF),
                        child: Column(
                          verticalDirection: VerticalDirection.up,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RatingBarIndicator(
                                rating: rate,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 20.0,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Posição: $position",
                              ),
                            ),
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
        );
      },
    );
  }
}
