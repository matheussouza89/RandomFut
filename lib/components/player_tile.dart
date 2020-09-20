import 'package:flutter/material.dart';
import 'package:randomfut/models/player.dart';
import 'package:randomfut/provider/players.dart';
import 'package:randomfut/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class PlayerTile extends StatefulWidget {
  final Player player;

  const PlayerTile(this.player);

  @override
  _PlayerTileState createState() => _PlayerTileState();
}

class _PlayerTileState extends State<PlayerTile> {
  @override
  Widget build(BuildContext context) {
    final avatar = widget.player.avatar == null || widget.player.avatar.isEmpty
        ? CircleAvatar(child: Image.asset('./assets/images/emptyPlayer.png'))
        : CircleAvatar(
            child: Image.asset(widget.player.avatar),
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
