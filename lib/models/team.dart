import 'package:randomfut/db/database_provider.dart';

class Team {
  int id;
  String name;
  String avatar;
  bool checked;

  Team({
    this.id,
    this.name,
    this.avatar,
    this.checked,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.colName: name,
      DatabaseProvider.colAvatar: avatar,
      DatabaseProvider.colChecked: checked ? 1 : 0,
    };

    if (id != null) {
      map[DatabaseProvider.colId] = id;
    }

    return map;
  }

  Team.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.colId];
    name = map[DatabaseProvider.colName];
    avatar = map[DatabaseProvider.colAvatar];
    checked = map[DatabaseProvider.colChecked] == 1;
  }
}
