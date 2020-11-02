import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:randomfut/components/player_tile.dart';
import 'package:randomfut/provider/players.dart';
import 'package:provider/provider.dart';
import 'package:randomfut/routes/app_routes.dart';

class ListaCadasCas extends StatefulWidget {
  @override
  _ListaCadasCasState createState() => _ListaCadasCasState();
}

class _ListaCadasCasState extends State<ListaCadasCas> {
  @override
  Widget build(BuildContext context) {
    final Players players = Provider.of(context);

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
        title: Text("$tittleCont"),
        leading: Image.asset('./assets/images/iconeJogador.png'),
        backgroundColor: Color(0xFF008000),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: players.count,
        itemBuilder: (ctx, i) => PlayerTile(players.byIndex(i)),
      ),
      floatingActionButton: Visibility(
        visible: isShowing,
        child: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
              child: Icon(Icons.people),
              onTap: () {},
              backgroundColor: Color(0xFF008000),
              label: 'Config. Time'
            ),
            SpeedDialChild(
              child: Icon(Icons.access_time),
              onTap: () {},
              backgroundColor: Color(0xFF008000),
              label: 'Config. Tempo'
            ),
            SpeedDialChild(
              child: Icon(Icons.sync),
              onTap: () {},
              backgroundColor: Color(0xFF008000),
              label: 'Sortear',
            ),
          ],
        ),
      ),
    );
  }
}
