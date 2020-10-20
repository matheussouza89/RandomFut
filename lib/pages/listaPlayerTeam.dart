import 'package:flutter/material.dart';
import 'package:randomfut/components/playerTeam_tile.dart';
import 'package:randomfut/provider/playersTeam.dart';
import 'package:provider/provider.dart';

class ListaPlayerTeam extends StatefulWidget {
  @override
  _ListaPlayerTeamState createState() => _ListaPlayerTeamState();
}

class _ListaPlayerTeamState extends State<ListaPlayerTeam> {
  @override
  Widget build(BuildContext context) {
    final PlayersTeam playersTeam = Provider.of(context);
    return Scaffold(
      backgroundColor: Color(0xFF41BC3F),
      appBar: AppBar(
        actions: [
          Container(
            padding: EdgeInsets.only(right: 40),
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {},
            ),
          ),
        ],
        centerTitle: true,
        title: Text("TIME A"),
        leading: Image.asset('./assets/images/iconeJogadores.png'),
        backgroundColor: Color(0xFF008000),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: playersTeam.count,
        itemBuilder: (ctx, i) => PlayerTeamTile(playersTeam.byIndex(i)),
      ),
    );
  }
}