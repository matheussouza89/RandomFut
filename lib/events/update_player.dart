import 'package:randomfut/models/player.dart';

import 'player_event.dart';

class UpdatePlayer extends PlayerEvent {
  Player newPlayer;
  int playerIndex;

  UpdatePlayer(int index, Player player) {
    newPlayer = player;
    playerIndex = index;
  }
}
