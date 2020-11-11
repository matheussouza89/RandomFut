import 'package:flutter/material.dart';
import 'package:randomfut/models/player.dart';
import 'package:randomfut/pages/listaCadasCas.page.dart';
import 'package:randomfut/provider/players.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class PlayerForm extends StatefulWidget {
  @override
  _PlayerFormState createState() => _PlayerFormState();
}

class _PlayerFormState extends State<PlayerForm> {
  var rating;

  final _form = GlobalKey<FormState>();

  final Map<String, Object> _formData = {};

  void _loadFormData(Player player) {
    if (player != null) {
      _formData['id'] = player.id;
      _formData['name'] = player.name;
      _formData['position'] = player.position;
      _formData['avatar'] = player.avatar;
      _formData['rate'] = player.rate;
      _formData['cor'] = player.cor;
    }
  }

  void teste(Player player) {
    if (_formData['rate'] != null) {
      rating = player.rate;
    } else {
      rating = 0.0;
      print(_formData['rate'] == null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Player player = ModalRoute.of(context).settings.arguments;

    _loadFormData(player);
    teste(player);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Jogador'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState.validate();
              if (isValid) {
                _form.currentState.save();
                _formData['rate'] = rating;
                Provider.of<Players>(context, listen: false).put(
                  Player(
                    id: _formData['id'],
                    name: _formData['name'],
                    position: _formData['position'],
                    avatar: null,
                    rate: _formData['rate'],
                    checked: _formData['checked'],
                    cor: _formData['cor'],
                  ),
                );
                Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListaCadasCas(),
                  ),
                );
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListaCadasCas(),
                  ),
                );
              }
            },
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
                initialValue: _formData['name'],
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
                onSaved: (value) => _formData['name'] = value,
              ),
              TextFormField(
                initialValue: _formData['position'],
                decoration: InputDecoration(labelText: 'Posição'),
                onSaved: (value) => _formData['position'] = value,
              ),
              SizedBox(
                height: 40,
              ),
              SmoothStarRating(
                  allowHalfRating: false,
                  rating: rating,
                  onRated: (value) {
                    rating = value;
                    print('rating value -> $rating');
                  },
                  starCount: 5,
                  size: 40.0,
                  isReadOnly: false,
                  filledIconData: Icons.star,
                  halfFilledIconData: Icons.star_half,
                  defaultIconData: Icons.star_border,
                  color: Colors.green,
                  borderColor: Colors.green,
                  spacing: 0.0),
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
