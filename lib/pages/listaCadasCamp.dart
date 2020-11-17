import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:randomfut/components/team_tile.dart';
import 'package:randomfut/provider/teams.dart';
import 'package:provider/provider.dart';

class ListaCadasCamp extends StatefulWidget {
  @override
  _ListaCadasCampState createState() => _ListaCadasCampState();
}

class _ListaCadasCampState extends State<ListaCadasCamp> {
  @override
  Widget build(BuildContext context) {
    final Teams teams = Provider.of(context);

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
        title: Text(titleCont),
        leading: Image.asset('./assets/images/iconeJogadores.png'),
        backgroundColor: Color(0xFF008000),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: teams.count,
        itemBuilder: (ctx, i) => TeamTile(teams.all.elementAt(i)),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
              child: Icon(Icons.people),
              onTap: () {},
              backgroundColor: Color(0xFF008000),
              label: 'Config. Time'),
          SpeedDialChild(
              child: Icon(Icons.access_time),
              onTap: () {},
              backgroundColor: Color(0xFF008000),
              label: 'Config. Tempo'),
          SpeedDialChild(
              child: Icon(Icons.sync),
              onTap: () {},
              backgroundColor: Color(0xFF008000),
              label: 'Sortear as chaves')
        ],
      ),
    );
  }
}
