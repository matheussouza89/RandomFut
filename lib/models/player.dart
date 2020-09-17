import 'package:flutter/cupertino.dart';

class Player {
  final String id;
  final String name;
  final String position;
  final String avatar;

  const Player({
    this.id,
    @required this.name,
    this.position,
    @required this.avatar,
  });
}
