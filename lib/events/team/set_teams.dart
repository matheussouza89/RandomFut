import 'package:randomfut/models/team.dart';

import 'team_event.dart';

class SetTeams extends TeamEvent {
  List<Team> teamList;

  SetTeams(List<Team> teams) {
    teamList = teams;
  }
}
