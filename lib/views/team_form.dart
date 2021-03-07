import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomfut/bloc/team_bloc.dart';
import 'package:randomfut/db/database_provider.dart';
import 'package:randomfut/events/team/add_team.dart';
import 'package:randomfut/events/team/update_team.dart';
import 'package:randomfut/models/team.dart';
import 'package:randomfut/views/listaCadasCamp.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class TeamForm extends StatefulWidget {
  final Team team;
  final int teamIndex;

  TeamForm({this.team, this.teamIndex});

  @override
  _TeamFormState createState() {
    return _TeamFormState();
  }
}

class _TeamFormState extends State<TeamForm> {
  int _id;
  String _name;
  String _avatar;
  bool _checked;
  bool iconeSave1;
  bool iconeSave2;
  dynamic imagem;
  String avatarPicker;
  var _itemSelecionado1;

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
    if (widget.team != null) {
      _id = widget.team.id;
      _name = widget.team.name;
      _avatar = widget.team.avatar;
      _checked = widget.team.checked;
      iconeSave1 = false;
      iconeSave2 = true;
      print(_avatar);
    } else {
      _itemSelecionado1 ='Selecione a opção';
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
        title: Text('Cadastro de Time'),
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
                  Team team = Team(
                    name: _name,
                    avatar: _avatar,
                    checked: false,
                  );
                  DatabaseProvider.db.insertTeams(team).then(
                        (storedTeam) =>
                            BlocProvider.of<TeamBloc>(context).add(
                          AddTeam(storedTeam),
                        ),
                      );
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListaCadasCamp(),
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
                    print(widget.team);
                    Team team = Team(
                      id: _id,
                      name: _name,
                      avatar: _avatar,
                      checked: _checked,
                    );
                    DatabaseProvider.db.updateTeams(team).then((storedTeam) {
                      BlocProvider.of<TeamBloc>(context).add(
                        UpdateTeam(widget.teamIndex, team),
                      );
                    });
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListaCadasCamp(),
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
                  },
                ),
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

class UpdateTime {
}
