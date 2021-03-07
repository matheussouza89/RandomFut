import 'team_event.dart';

class DeleteTeam extends TeamEvent {
  int teamIndex;

  DeleteTeam(int index) {
    teamIndex = index;
  }
}
