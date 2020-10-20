import 'dart:math';
import 'package:flutter/material.dart';
import 'package:randomfut/data/dummy_playersteam.dart';
import 'package:randomfut/models/playerTeam.dart';

class PlayersTeam with ChangeNotifier {
  final Map<String, PlayerTeam> _items = {...DUMMY_PLAYERSTEAM};

  List<PlayerTeam> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  PlayerTeam byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(PlayerTeam playerTeam) {
    if (playerTeam == null) {
      return;
    }

    if (playerTeam.id != null &&
        playerTeam.id.trim().isNotEmpty &&
        _items.containsKey(playerTeam.id)) {
      _items.update(
        playerTeam.id,
        (_) => PlayerTeam(
          id: playerTeam.id,
          name: playerTeam.name,
          position: playerTeam.position,
          avatar: playerTeam.avatar,
          rate: playerTeam.rate,
        ),
      );
    } else {
      final id = Random().nextDouble().toString();
      _items.putIfAbsent(
        id,
        () => PlayerTeam(
          id: id,
          name: playerTeam.name,
          position: playerTeam.position,
          avatar: playerTeam.avatar,
          rate: playerTeam.rate,
        ),
      );
    }

    notifyListeners();
  }

  void remove(PlayerTeam playerTeam) {
    if (playerTeam != null && playerTeam.id != null) {
      _items.remove(playerTeam.id);
      notifyListeners();
    }
  }
}
