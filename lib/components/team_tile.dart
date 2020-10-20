import 'package:flutter/material.dart';
import 'package:randomfut/models/team.dart';
import 'package:randomfut/pages/listaPlayerTeam.dart';
import 'package:randomfut/provider/teams.dart';
import 'package:randomfut/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class TeamTile extends StatefulWidget {
  final Team team;

  const TeamTile(this.team);

  @override
  _TeamTileState createState() => _TeamTileState();
}

class _TeamTileState extends State<TeamTile> {
  var isSelected = false;
  var seletion = 0xFF41BC3F;
  var aux = 0;
  var tittleCont = "Jogares selecionados: /10";
  @override
  Widget build(BuildContext context) {
    final avatar = widget.team.avatar == null || widget.team.avatar.isEmpty
        ? CircleAvatar(child: Image.asset('./assets/images/emptyPlayer.png'))
        : CircleAvatar(
            child: Image.asset(widget.team.avatar),
          ); //Mudar Aqui para colocar a imagem do Usuario
    return Container(
      color: Color(seletion),
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
            subtitle: Container(
              child: Column(
                children: [
                  Align(
                    child: SmoothStarRating(
                        allowHalfRating: false,
                        starCount: 5,
                        size: 20.0,
                        isReadOnly: true,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,
                        rating: widget.team.rate,
                        color: Colors.yellow,
                        borderColor: Colors.yellow,
                        spacing: 0.0),
                    alignment: Alignment.centerLeft,
                  ),
                ],
              ),
              alignment: Alignment.centerLeft,
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ListaPlayerTeam(),
                ),
              );
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
    setState(() {
      if (isSelected) {
        isSelected = false;
        seletion = 0xFF41BC3F;
      } else {
        isSelected = true;
        seletion = 0xFF6ECE6C;
      }
    });
  }
}
