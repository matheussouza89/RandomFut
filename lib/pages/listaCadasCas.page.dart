import 'package:flutter/material.dart';
import 'package:randomfut/components/player_tile.dart';
import 'package:randomfut/provider/players.dart';
import 'package:provider/provider.dart';
import 'package:randomfut/routes/app_routes.dart';

class ListaCadasCas extends StatelessWidget {
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
        backgroundColor: Color(0xFF008000),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: players.count,
        itemBuilder: (ctx, i) => PlayerTile(players.byIndex(i)),
      ),
    );
  }
}
