import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:randomfut/bloc/player_bloc.dart';
import 'package:randomfut/db/database_provider.dart';
import 'package:randomfut/events/player/add_player.dart';
import 'package:randomfut/events/player/update_player.dart';
import 'package:randomfut/models/player.dart';
import 'package:randomfut/views/listaCadasCas.page.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

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
  int _id;
  String _name;
  String _position;
  String _avatar;
  double _rate;
  bool _checked;
  bool iconeSave1;
  bool iconeSave2;
  dynamic imagem;
  String avatarPicker;
  var _itemSelecionado1;
  var _decisaoPosicao = ['Multifuncional','Linha', 'Goleiro'];

  final picker = ImagePicker();

  final _form = GlobalKey<FormState>();

  void _selecaoPosicao(String novoItem) {
    setState(() {
      _itemSelecionado1 = novoItem;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.player != null) {
      _id = widget.player.id;
      _name = widget.player.name;
      _position = widget.player.position;
      _avatar = widget.player.avatar;
      _rate = widget.player.rate;
      _checked = widget.player.checked;
      iconeSave1 = false;
      iconeSave2 = true;
      _itemSelecionado1 = _position == null ? 'Selecione a opção' : _position;
      print(_avatar);
    } else {
      _itemSelecionado1 ='Selecione a opção';
      _rate = 0.0;
      iconeSave1 = true;
      iconeSave2 = false;
    }
  }

  Future getImageGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.green,
            toolbarTitle: "Recorte de Imagem",
            statusBarColor: Colors.grey[600],
            backgroundColor: Colors.white,
          ));
      setState(() {
        if (pickedFile != null) {
          avatarPicker = cropped.path.toString();
          _avatar = avatarPicker;
          print(_avatar);
        } else {
          print('No image selected.');
        }
      });
    }
  }

  Future getImageCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.green,
            toolbarTitle: "Recorte de Imagem",
            statusBarColor: Colors.grey[600],
            backgroundColor: Colors.white,
          ));
      setState(() {
        if (pickedFile != null) {
          avatarPicker = cropped.path.toString();
          _avatar = avatarPicker;
          print(_avatar);
        } else {
          print('No image selected.');
        }
      });
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
                  print(_avatar);
                  Player player = Player(
                    name: _name,
                    position: _position,
                    rate: _rate,
                    avatar: _avatar,
                    checked: false,
                  );
                  DatabaseProvider.db.insertPlayer(player).then(
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
                    print(widget.player);
                    Player player = Player(
                      id: _id,
                      name: _name,
                      position: _position,
                      rate: _rate,
                      avatar: _avatar,
                      checked: _checked,
                    );
                    DatabaseProvider.db.updatePlayer(player).then((storedPlayer) {
                      BlocProvider.of<PlayerBloc>(context).add(
                        UpdatePlayer(widget.playerIndex, player),
                      );
                    });
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
              Container(
                width: 200,
                height: 200,
                color: Colors.grey[300],
                child: imagem = _avatar == null
                    ? Icon(
                        Icons.person,
                        size: 150,
                      )
                    : Image(
                        image: FileImage(File('$_avatar')),
                        fit: BoxFit.fill,
                      ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                child: TextFormField(
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
                  onSaved: (value) {
                    _name = value;
                    _position = _itemSelecionado1;
                    print(_position);
                  },
                ),
              ),
              Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft, child: Text("Posição")),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: DropdownButton(
                      items: _decisaoPosicao.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (String novoItemSelecionado) {
                        _selecaoPosicao(novoItemSelecionado);
                      },
                      hint: Text(_itemSelecionado1),
                    ),
                  ),
                ],
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
                onPressed: showBottomSheet,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showBottomSheet() {
    showModalBottomSheet(
      isDismissible: true,
      context: context,
      builder: (context) {
        return Container(
          child: _buildBottomNavigationMenu(),
          height: 180,
        );
      },
    );
  }

  Column _buildBottomNavigationMenu() {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.camera_alt),
          title: Text("Camera"),
          onTap: () {
            getImageCamera();
            Navigator.of(context).pop();
          },
        ),
        ListTile(
          leading: Icon(Icons.image),
          title: Text("Galeria"),
          onTap: () {
            getImageGallery();
            Navigator.of(context).pop();
          },
        ),
        ListTile(
          leading: Icon(Icons.highlight_remove),
          title: Text("Remover Imagem"),
          onTap: () {
            setState(() {
              _avatar = null;
            });
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
