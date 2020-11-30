import 'package:path/path.dart';
import 'package:randomfut/models/player.dart';
import 'package:sqflite/sqflite.dart';

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

  Future<int>  getCount() async {
    final db = await database;

    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $playerTable');
    int resultado = Sqflite.firstIntValue(x);
    return resultado;
  }

  Future<Player> insert(Player player) async {
    final db = await database;
    player.id = await db.insert(playerTable, player.toMap());
    return player;
  }

  Future<int> delete(int id) async {
    final db = await database;

    return await db.delete(playerTable, where: "id = ?", whereArgs: [id]);
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
