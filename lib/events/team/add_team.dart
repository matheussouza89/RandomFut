import 'package:randomfut/models/team.dart';

import 'team_event.dart';

class AddTeam extends TeamEvent {
  Team newTeam;

  AddTeam(Team team) {
    newTeam = team;
  }
}