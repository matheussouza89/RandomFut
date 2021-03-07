import 'package:path/path.dart';
import 'package:randomfut/models/player.dart';
import 'package:randomfut/models/team.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const String playerTable = 'player';
  static const String teamTable = 'team';
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
      join(dbPath, 'randomfutDB.db'),
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
        print("Creating player table");
        await database.execute(
          "CREATE TABLE $teamTable ("
          "$colId INTEGER PRIMARY KEY,"
          "$colName TEXT,"
          "$colAvatar TEXT,"
          "$colChecked INTEGER"
          ")",
        );
      },
    );
  }

  //TABELA MODO CASUAL

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

  Future<List<dynamic>> getCountPlayers() async {
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
    for (int i = 0; i < listLenght; i++) {
      resultado.add(listLenght);
      resultado.add(a);
      resultado.add(b);
      resultado.add(c);
      resultado.add(d);
      resultado.add(e);
      resultado.add(f);
    }

    return resultado;
  }

  Future<Player> insertPlayer(Player player) async {
    final db = await database;
    player.id = await db.insert(playerTable, player.toMap());
    return player;
  }

  Future<int> deletePlayer(int id) async {
    final db = await database;

    return await db.delete(
      playerTable,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> updatePlayer(Player player) async {
    final db = await database;

    return await db.update(
      playerTable,
      player.toMap(),
      where: "id = ?",
      whereArgs: [player.id],
    );
  }

  Future<void> upadateCheckPlayer() async {
    final db = await database;
    return await db.rawUpdate('UPDATE $playerTable SET $colChecked = 0');
  }

  //TABELA MODO CAMPEONATO

  Future<List<Team>> getTeams() async {
    final db = await database;

    var teams = await db.query(teamTable, columns: [
      colId,
      colName,
      colAvatar,
      colChecked,
    ]);

    List<Team> teamList = List<Team>();

    teams.forEach((currentTeam) {
      Team team = Team.fromMap(currentTeam);
      teamList.add(team);
    });
    return teamList;
  }

  Future<List<dynamic>> getCountTeams() async {
    final db = await database;

    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $teamTable');
    List<Map<String, dynamic>> a =
        await db.rawQuery('SELECT $colId from $teamTable');
    List<Map<String, dynamic>> b =
        await db.rawQuery('SELECT $colName from $teamTable');
    List<Map<String, dynamic>> c =
        await db.rawQuery('SELECT $colAvatar from $teamTable');
    List<Map<String, dynamic>> d =
        await db.rawQuery('SELECT $colChecked from $teamTable');
    var listLenght = Sqflite.firstIntValue(x);
    var resultado = [];
    for (int i = 0; i < listLenght; i++) {
      resultado.add(listLenght);
      resultado.add(a);
      resultado.add(b);
      resultado.add(c);
      resultado.add(d);
    }

    return resultado;
  }

  Future<Team> insertTeams(Team team) async {
    final db = await database;
    team.id = await db.insert(teamTable, team.toMap());
    return team;
  }

  Future<int> deleteTeams(int id) async {
    final db = await database;

    return await db.delete(
      teamTable,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> updateTeams(Team team) async {
    final db = await database;

    return await db.update(
      teamTable,
      team.toMap(),
      where: "id = ?",
      whereArgs: [team.id],
    );
  }

  Future<void> upadateCheckTeams() async {
    final db = await database;
    return await db.rawUpdate('UPDATE $teamTable SET $colChecked = 0');
  }
}
