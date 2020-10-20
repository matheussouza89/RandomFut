import 'package:flutter/cupertino.dart';

class PlayerTeam {
  final String id;
  final String name;
  final String position;
  final String avatar;
  final double rate;

  const PlayerTeam({
    this.id,
    @required this.name,
    this.position,
    @required this.avatar,
    this.rate,
  });
}
