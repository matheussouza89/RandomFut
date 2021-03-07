import 'package:randomfut/events/team/add_team.dart';
import 'package:randomfut/events/team/delete_team.dart';
import 'package:randomfut/events/team/set_teams.dart';
import 'package:randomfut/events/team/team_event.dart';
import 'package:randomfut/events/team/update_team.dart';
import 'package:randomfut/models/team.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeamBloc extends Bloc<TeamEvent, List<Team>> {
  @override
  List<Team> get initialState => List<Team>();

  @override
  Stream<List<Team>> mapEventToState(TeamEvent event) async* {
     if (event is SetTeams) {
      yield event.teamList;
    } else if (event is AddTeam) {
      List<Team> newState = List.from(state);
      if (event.newTeam != null) {
        newState.add(event.newTeam);
      }
      yield newState;
    } else if (event is DeleteTeam) {
      List<Team> newState = List.from(state);
      newState.removeAt(event.teamIndex);
      yield newState;
    } else if (event is UpdateTeam) {
      List<Team> newState = List.from(state);
      newState[event.teamIndex] = event.newTeam;
      yield newState;
    }
  }
}
