import 'package:randomfut/models/team.dart';

import 'team_event.dart';

class UpdateTeam extends TeamEvent {
  Team newTeam;
  int teamIndex;

  UpdateTeam(int index, Team team) {
    newTeam = team;
    teamIndex = index;
  }
}
