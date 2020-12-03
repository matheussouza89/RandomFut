import 'package:randomfut/db/database_provider.dart';

class Player {
  int id;
  String name;
  String position;
  String avatar;
  double rate;
  bool checked;

  Player({
    this.id,
    this.name,
    this.position,
    this.avatar,
    this.rate,
    this.checked,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.colName: name,
      DatabaseProvider.colPosition: position,
      DatabaseProvider.colAvatar: avatar,
      DatabaseProvider.colRate: rate,
      DatabaseProvider.colChecked: checked ? 1 : 0,
    };

    if (id != null) {
      map[DatabaseProvider.colId] = id;
    }

    return map;
  }

  Player.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.colId];
    name = map[DatabaseProvider.colName];
    position = map[DatabaseProvider.colPosition];
    avatar = map[DatabaseProvider.colAvatar];
    rate = map[DatabaseProvider.colRate];
    checked = map[DatabaseProvider.colChecked] == 1;
  }
    @override
  String toString() {
    return "PLayer => (id:$id ,name:$name ,position:$position ,avatar:$avatar ,rate:$rate ,checked:$checked)";
  }
}