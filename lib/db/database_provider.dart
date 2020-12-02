import 'package:path/path.dart';
import 'package:randomfut/models/player.dart';
import 'package:sqflite/sqflite.dart';

class Listagem {
  int qtde;
  int id;
  String name;
  String position;
  String avatar;
  double rate;
  bool checked;

  Listagem({
    this.qtde,
    this.id,
    this.name,
    this.position,
    this.avatar,
    this.rate,
    this.checked,
  });
}

class DatabaseProvider {
  static const String playerTable = 'player';
  static const String colId = 'id';
  static const String colName = 'name';
  static const String colPosition = 'position';
  static const String colAvatar = 'avatar';
  static const String colRate = 'rate';
  static const String colChecked = 'checked';

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    print("database getter called");

    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'playerDB.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        print("Creating player table");

        await database.execute(
          "CREATE TABLE $playerTable ("
          "$colId INTEGER PRIMARY KEY,"
          "$colName TEXT,"
          "$colAvatar TEXT,"
          "$colPosition TEXT,"
          "$colRate REAL,"
          "$colChecked INTEGER"
          ")",
        );
      },
    );
  }

  Future<List<Player>> getPlayers() async {
    final db = await database;

    var players = await db.query(playerTable, columns: [
      colId,
      colName,
      colAvatar,
      colPosition,
      colRate,
      colChecked,
    ]);

    List<Player> playerList = List<Player>();

    players.forEach((currentPlayer) {
      Player player = Player.fromMap(currentPlayer);
      playerList.add(player);
    });
    return playerList;
  }

  Future<List<dynamic>> getCount() async {
    final db = await database;

    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $playerTable');
    List<Map<String, dynamic>> a =
        await db.rawQuery('SELECT $colId from $playerTable');
    List<Map<String, dynamic>> b =
        await db.rawQuery('SELECT $colName from $playerTable');
    List<Map<String, dynamic>> c =
        await db.rawQuery('SELECT $colAvatar from $playerTable');
    List<Map<String, dynamic>> d =
        await db.rawQuery('SELECT $colPosition from $playerTable');
    List<Map<String, dynamic>> e =
        await db.rawQuery('SELECT $colRate from $playerTable');
    List<Map<String, dynamic>> f =
        await db.rawQuery('SELECT $colChecked from $playerTable');
    var listLenght = Sqflite.firstIntValue(x);
    var resultado = [];
    var zezultado = [];
    for (int i = 0; i < listLenght; i++) {
      zezultado.add(listLenght);
      zezultado.add(a);
      zezultado.add(b);
      zezultado.add(c);
      zezultado.add(d);
      zezultado.add(e);
      zezultado.add(f);
      resultado.add(zezultado);
    }

    return resultado;
  }

  Future<Player> insert(Player player) async {
    final db = await database;
    player.id = await db.insert(playerTable, player.toMap());
    return player;
  }

  Future<int> delete(int id) async {
    final db = await database;

    return await db.delete(
      playerTable,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> update(Player player) async {
    final db = await database;

    return await db.update(
      playerTable,
      player.toMap(),
      where: "id = ?",
      whereArgs: [player.id],
    );
  }
}
