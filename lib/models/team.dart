import 'package:flutter/cupertino.dart';

class Team {
  final String id;
  final String name;
  final String avatar;
  final double rate;

  const Team({
    this.id,
    @required this.name,
    @required this.avatar,
    this.rate,
  });
}
