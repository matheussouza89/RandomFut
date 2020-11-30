import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:randomfut/bloc/player_bloc.dart';
import 'package:randomfut/db/database_provider.dart';
import 'package:randomfut/events/add_player.dart';
import 'package:randomfut/events/update_player.dart';
import 'package:randomfut/models/player.dart';
import 'package:randomfut/pages/listaCadasCas.page.dart';

class PlayerForm extends StatefulWidget {
  final Player player;
  final int playerIndex;

  PlayerForm({this.player, this.playerIndex});

  @override
  _PlayerFormState createState() {
    return _PlayerFormState();
  }
}

class _PlayerFormState extends State<PlayerForm> {
  String _name;
  String _position;
  String _avatar;
  double _rate;
  bool _checked;
  String _cor;
  bool iconeSave1;
  bool iconeSave2;

  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.player != null) {
      print(widget.playerIndex);
      _name = widget.player.name;
      _position = widget.player.position;
      _avatar = widget.player.avatar;
      _rate = widget.player.rate;
      _checked = widget.player.checked;
      iconeSave1 = false;
      iconeSave2 = true;
    } else {
      _rate = 0.0;
      iconeSave1 = true;
      iconeSave2 = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Jogador'),
        actions: [
          Visibility(
            visible: iconeSave1,
            child: IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final isValid = _form.currentState.validate();
                if (isValid) {
                  _form.currentState.save();
                  Player player = Player(
                      name: _name,
                      position: _position,
                      avatar: _avatar,
                      rate: _rate,
                      checked: false,
                      );

                  DatabaseProvider.db.insert(player).then(
                        (storedPlayer) =>
                            BlocProvider.of<PlayerBloc>(context).add(
                          AddPlayer(storedPlayer),
                        ),
                      );
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListaCadasCas(),
                    ),
                  );
                }
              },
            ),
          ),
          Visibility(
            visible: iconeSave2,
            child: IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  final isValid = _form.currentState.validate();
                  if (isValid) {
                    _form.currentState.save();
                    Player player = Player(
                        name: _name,
                        position: _position,
                        avatar: _avatar,
                        rate: _rate,
                       );

                    DatabaseProvider.db.update(widget.player).then(
                          (storedPlayer) =>
                              BlocProvider.of<PlayerBloc>(context).add(
                            UpdatePlayer(widget.playerIndex, player),
                          ),
                        );
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListaCadasCas(),
                      ),
                    );
                  }
                }),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value.isEmpty || value == null) {
                    return 'Nome inválido';
                  }
                  if (value.trim().length < 3) {
                    return 'Nome muito pequeno. No mínimo 3 caracteres.';
                  }

                  return null;
                },
                onSaved: (value) => _name = value,
              ),
              TextFormField(
                initialValue: _position,
                decoration: InputDecoration(labelText: 'Posição'),
                onSaved: (value) => _position = value,
              ),
              SizedBox(
                height: 40,
              ),
              RatingBar(
                glow: false,
                initialRating: _rate,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                ratingWidget: RatingWidget(
                  full: Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  half: Icon(
                    Icons.star_half,
                    color: Colors.amber,
                  ),
                  empty: Icon(
                    Icons.star_border,
                    color: Colors.amber,
                  ),
                ),
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                onRatingUpdate: (rating) {
                  _rate = rating;
                },
              ),
              SizedBox(
                height: 40,
              ),
              FloatingActionButton(
                child: Icon(Icons.file_upload),
                onPressed: () => {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
