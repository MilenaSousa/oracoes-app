import 'dart:async';

import 'package:path/path.dart';
import 'package:pontodeluz/models/texto.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class FavoritosDb {
  static final FavoritosDb _instance = new FavoritosDb.getInstance();

  factory FavoritosDb() => _instance;

  FavoritosDb.getInstance();

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'favoritos.db');
    print("db $path");

    // para deletar o banco
    //await deleteDatabase(path);

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE favoritos(id INTEGER PRIMARY KEY, cor INTEGER, titulo TEXT'
        ', fonte TEXT, categNome TEXT, categImg TEXT, texto TEXT)');
  }

  Future<int> saveFav(Texto fav) async {
    var dbClient = await db;
    final sql =
        'insert or replace into favoritos (id,cor,titulo,fonte,categNome,categImg,texto) VALUES '
        '(?,?,?,?,?,?,?)';
    var id = await dbClient.rawInsert(sql, [
      fav.id,
      fav.cor,
      fav.titulo,
      fav.fonte,
      fav.categNome,
      fav.categImg,
      fav.texto
    ]);
    print('id: $id');
    return id;
  }

  // Future<List<Texto>> getFavoritos(streamController) async {
  getFavoritos(streamController) async {

    final dbClient = await db;

    final mapFavoritos = await dbClient.rawQuery('select * from favoritos');

    final favoritos = mapFavoritos.map<Texto>((json) => Texto.fromJson(json)).toList();
    streamController.sink.add(favoritos);
    // return favoritos;
  }

  Future<int> getCount() async {
    final dbClient = await db;
    final result = await dbClient.rawQuery('select count(*) from favoritos');
    return Sqflite.firstIntValue(result);
  }

  Future<Texto> getFavorito(int id) async {
    var dbClient = await db;
    final result = await dbClient.rawQuery('select * from favoritos where id = ?',[id]);

    if (result.length > 0) {
      return new Texto.fromJson(result.first);
    }
    return null;
  }

  Future<bool> exists(Texto oracao) async {
    Texto c = await getFavorito(oracao.id);
    var exists = c != null;
    return exists;
  }

  Future<int> deleteFavorito(int id) async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from favoritos where id = ?',[id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }

}