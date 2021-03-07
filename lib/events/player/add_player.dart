import 'package:randomfut/models/player.dart';

import 'player_event.dart';

class AddPlayer extends PlayerEvent {
  Player newPlayer;

  AddPlayer(Player player) {
    newPlayer = player;
  }
}