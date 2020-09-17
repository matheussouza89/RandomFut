import 'package:flutter/material.dart';
import 'package:randomfut/models/player.dart';
import 'package:randomfut/provider/players.dart';
import 'package:randomfut/routes/app_routes.dart';
import 'package:provider/provider.dart';

class PlayerTile extends StatelessWidget {
  final Player player;

  const PlayerTile(this.player);

  @override
  Widget build(BuildContext context) {
    final avatar = player.avatar == null || player.avatar.isEmpty
        ? CircleAvatar(child: Image.asset('./assets/images/emptyPlayer.png'))
        : CircleAvatar(
            child: Image.asset(player.avatar),
          ); //Mudar Aqui para colocar a imagem do Usuario
    return Container(
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
            title: Text(player.name),
            subtitle: Text(player.position),
            onLongPress: () {},
            trailing: Container(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.PLAYERFORM,
                        arguments: player,
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
                                    .remove(player);
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
}
