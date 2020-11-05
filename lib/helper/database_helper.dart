/*import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  // usada para definir as colunas da tabela
  String playerTable = 'player';
  String colId = 'id';
  String colName = 'name';
  String colPosition = 'position';
  String colAvatar = 'avatar';
  String colRate = 'rate';
  String colChecked = 'checked';
  String colCor = 'cor';

  //Construto nomeado para criar a instância da classe
  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      // executado somente uma vez
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatase();
    }
    return _database;
  }

  Future<Database> initializeDatase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'player.db';
    var playerDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return playerDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $playerTable($colId TEXT PRIMARY KEY,$colName TEXT,$colPosition TEXT,$colAvatar TEXT,$colRate TEXT,$colChecked TEXT,$colCor TEXT)');
  }

  //Incluir um objeto player no DB
  Future<int> insertPlayer(Player player) async {
    Database db = await this.database;

    var resultado = await db.insert(playerTable, player.toMap());

    return resultado;
  }

  //Retorna um Player pelo id
  Future<Player> getPlayer(String id) async {
    Database db = await this.database;

    List<Map> maps = await db.query(playerTable,
        columns: [
          colId,
          colName,
          colPosition,
          colAvatar,
          colRate,
          colChecked,
          colCor
        ],
        where: "$colId = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return Player.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Player>> getPlayers() async {
    Database db = await this.database;

    var resultado = await db.query(playerTable);

    List<Player> listaPlayer = resultado.isNotEmpty
        ? resultado.map((p) => Player.fromMap(p)).toList()
        : [];
    return listaPlayer;
  }

  //Atualizar um objeto Player e salva no DB
  Future<int> updatePlayer(Player player) async {
    var db = await this.database;

    var resultado = await db.update(playerTable, player.toMap(),
        where: "$colId = ?", whereArgs: [player.id]);

    return resultado;
  }

  Future<int> deletePlayer(String id) async {
    var db = await this.database;

    int resultado =
        await db.delete(playerTable, where: "$colId = ?", whereArgs: [id]);

    return resultado;
  }

  Future close() async {
    Database db = await this.database;
    db.close();
  }
}*/
