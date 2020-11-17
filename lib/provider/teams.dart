import 'dart:math';
import 'package:flutter/material.dart';
import 'package:randomfut/data/dummy_teams.dart';
import 'package:randomfut/models/team.dart';

class Teams with ChangeNotifier {
  final Map<String, Team> _items = {...DUMMY_TEAMS};

  List<Team> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  Team byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(Team team) {
    if (team == null) {
      return;
    }

    if (team.id != null &&
        team.id.trim().isNotEmpty &&
        _items.containsKey(team.id)) {
      _items.update(
        team.id,
        (_) => Team(
          id: team.id,
          name: team.name,
          avatar: team.avatar,
          checked: team.checked,
          cor: team.cor,
        ),
      );
    } else {
      final id = Random().nextDouble().toString();
      final checked = false;
      final cor = 0xFF41BC3F;
      _items.putIfAbsent(
        id,
        () => Team(
          id: id,
          name: team.name,
          avatar: team.avatar,
          checked: checked,
          cor: cor,
        ),
      );
    }

    notifyListeners();
  }

  void remove(Team team) {
    if (team != null && team.id != null) {
      _items.remove(team.id);
      notifyListeners();
    }
  }
}
