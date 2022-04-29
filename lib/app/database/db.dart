import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DB {
  DB._();
  static final DB instance = DB._();

  static Database? _database;

  get database async {
    if(_database != null) return _database;

    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(
        join(await getDatabasesPath(), 'poraki.db'), version: 1, onCreate: _onCreate,);
  }

  _onCreate(db, versao) async {
    //await db.execute(_categorias);
    // // await db.execute(_setup); - HIVE
    // await db.execute(_compras);
    // await db.execute(_vendas); - SÓ VENDAS FECHADAS
    // await db.execute(_entregas); - API
    // await db.execute(_carrinho);
    // await db.execute(_favs);
    // // await db.execute(_conta); - HIVE
    // await db.execute(_ofertasCache);
    // await db.execute(_produtos);
    // await db.execute(_enderecos);
    // await db.execute(_chats); - realtime database armazenado local quando finalizar

  }

  String get _categorias => '''
    CREATE TABLE IF NOT EXISTS categorias (
    categoriaChave TEXT PRIMARY KEY,
    categoriaNome TEXT,
    secao TEXT,
    mostraBarra BIT,
    iconCode INT
    );
  ''';

}