import 'package:path/path.dart';
import 'package:poraki/app/data/models/sql/sqlEndereco.dart';
import 'package:sqflite/sqflite.dart';

class sqlPorakiAddressService {
  Future<List<sqlEndereco>> buscaEnderecos(bool atual) async {
    String path = join(await getDatabasesPath(), 'poraki');
    Database db = await openDatabase(
      path,
      version: 1,
    );

    await verificaTabela();
    late List<sqlEndereco> enderecos = [];

    if (atual) {
      List<Map<String, dynamic>> list = await db.query('enderecos');
      print('query qtd: ' + list.length.toString());
      list.forEach((item) {
        enderecos.add(new sqlEndereco(
            '',
            '',
            '',
            item['enderecoCEP'],
            item['enderecoLogra'],
            item['enderecoNumero'],
            item['enderecoCompl'],
            item['enderecoTipo'],
            item['enderecoAtual'],
            item['enderecoUltData'],
            item['enderecoLat'],
            item['enderecoLong']));
      });
    } else {
      List<Map<String, dynamic>> list = await db
          .query('enderecos', where: "enderecoAtual = ?", whereArgs: [1]);
      print('query qtd: ' + list.length.toString());
      list.forEach((item) {
        enderecos.add(new sqlEndereco(
            '',
            '',
            '',
            item['enderecoCEP'],
            item['enderecoLogra'],
            item['enderecoNumero'],
            item['enderecoCompl'],
            item['enderecoTipo'],
            item['enderecoAtual'],
            item['enderecoUltData'],
            item['enderecoLat'],
            item['enderecoLong']));
      });
    }
    return enderecos;
  }

  Future<List<sqlEndereco>> buscaEnderecoSingle(String enderecoGuid) async {
    String path = join(await getDatabasesPath(), 'poraki');
    Database db = await openDatabase(
      path,
      version: 1,
    );

    await verificaTabela();

    return await db.query('enderecos',
        where: "enderecoGuid = ?",
        whereArgs: [enderecoGuid]) as List<sqlEndereco>;
  }

  Future<void> deleteEndereco(String enderecoGuid) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);
    await db.delete('enderecos',
        where: "enderecoGuid = ?", whereArgs: [enderecoGuid]);

    await db.close();
  }

  Future<void> insertEndereco(sqlEndereco endereco) async {
    print('insertEndereco');
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);
    await verificaTabela();

    var ret = await db.insert('enderecos', endereco.toMap());
    print('ret: ' + ret.toString());
    await db.close();
  }

  Future<void> updateEndereco(sqlEndereco endereco) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    await db.update('enderecos', endereco.toMap(),
        where: "enderecoGuid = ?", whereArgs: [endereco.enderecoGuid]);

    await db.close();
  }

  Future<void> updateEnderecoAtual(String enderecoGuid) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    await db.rawUpdate("UPDATE enderecos SET enderecoAtual=0");
    await db.rawUpdate(
        "UPDATE enderecos SET enderecoAtual=1 WHERE enderecoGuid = '" +
            enderecoGuid +
            "'");

    await db.close();
  }

  Future<void> verificaTabela() async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    var existe = await db.rawQuery(_verificaTabelaEnderecos);
    if (existe.isEmpty) {
      await db.execute(_createTableEnderecos);
      print('tabela endereços construída');
    }
  }

  Future<void> redefineTabela() async {
    String path = join(await getDatabasesPath(), 'poraki');
    Database db = await openDatabase(
    path,
    version: 1,
    );

    await db.execute("DROP TABLE IF EXISTS enderecos");
    print('tabela enderecos destruída');
    await verificaTabela();
  }

  // pra ver se a tabela de enderecos existe
  final String _verificaTabelaEnderecos = '''
  SELECT * FROM sqlite_master WHERE name ='enderecos' and type='table'; 
  ''';

  // Tipos de Endereços: Home / Work / School / Others
  final String _createTableEnderecos = '''
    CREATE TABLE IF NOT EXISTS enderecos (
    enderecoGuid TEXT,
    usuEmail TEXT,
    usuGuid TEXT,
    enderecoCEP TEXT,
    enderecoLogra TEXT,
    enderecoNumero TEXT,
    enderecoCompl TEXT,
    enderecoTipo TEXT,
    enderecoAtual INT,
    enderecoUltData TEXT
    enderecoDesde TEXT,
    enderecoLatitude TEXT,
    enderecoLongitude TEXT
    );
  ''';
}
