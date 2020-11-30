import 'package:randomfut/events/add_player.dart';
import 'package:randomfut/events/delete_player.dart';
import 'package:randomfut/events/player_event.dart';
import 'package:randomfut/events/set_players.dart';
import 'package:randomfut/events/update_player.dart';
import 'package:randomfut/models/player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerBloc extends Bloc<PlayerEvent, List<Player>> {
  @override
  List<Player> get initialState => List<Player>();

  @override
  Stream<List<Player>> mapEventToState(PlayerEvent event) async* {
     if (event is SetPlayers) {
      yield event.playerList;
    } else if (event is AddPlayer) {
      List<Player> newState = List.from(state);
      if (event.newPlayer != null) {
        newState.add(event.newPlayer);
      }
      yield newState;
    } else if (event is DeletePlayer) {
      List<Player> newState = List.from(state);
      newState.removeAt(event.playerIndex);
      yield newState;
    } else if (event is UpdatePlayer) {
      List<Player> newState = List.from(state);
      newState[event.playerIndex] = event.newPlayer;
      yield newState;
    }
  }
}
