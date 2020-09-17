import 'package:flutter/material.dart';
import 'package:randomfut/models/player.dart';
import 'package:randomfut/provider/players.dart';
import 'package:provider/provider.dart';

class PlayerForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final Map<String, Object> _formData = {};

  void _loadFormData(Player player) {
    if (player != null) {
      _formData['id'] = player.id;
      _formData['name'] = player.name;
      _formData['position'] = player.position;
      _formData['avatar'] = player.avatar;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Player player = ModalRoute.of(context).settings.arguments;

    _loadFormData(player);

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
                Provider.of<Players>(context, listen: false).put(
                  Player(
                    id: _formData['id'],
                    name: _formData['name'],
                    position: _formData['position'],
                    avatar: null,
                  ),
                );

                Navigator.of(context).pop();
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
              FloatingActionButton(
                child: Icon(Icons.file_upload),
                onPressed: () => {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
