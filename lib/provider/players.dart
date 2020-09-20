import 'dart:math';

import 'package:flutter/material.dart';
import 'package:randomfut/data/dummy_players.dart';
import 'package:randomfut/models/player.dart';

class Players with ChangeNotifier {
  final Map<String, Player> _items = {...DUMMY_PLAYERS};

  List<Player> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  Player byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(Player player) {
    if (player == null) {
      return;
    }

    if (player.id != null &&
        player.id.trim().isNotEmpty &&
        _items.containsKey(player.id)) {
      _items.update(
        player.id,
        (_) => Player(
          id: player.id,
          name: player.name,
          position: player.position,
          avatar: player.avatar,
          rate: player.rate,
        ),
      );
    } else {
      final id = Random().nextDouble().toString();
      _items.putIfAbsent(
        id,
        () => Player(
          id: id,
          name: player.name,
          position: player.position,
          avatar: player.avatar,
          rate: player.rate,
        ),
      );
    }

    notifyListeners();
  }

  void remove(Player player) {
    if (player != null && player.id != null) {
      _items.remove(player.id);
      notifyListeners();
    }
  }
}
