import 'package:path/path.dart';
import 'package:poraki/app/data/models/sql/sqlEndereco.dart';
import 'package:sqflite/sqflite.dart';

class sqlPorakiAddressService {

  late Database db;

  Future<List<sqlEndereco>> buscaEnderecos(bool atual) async {
    List<sqlEndereco> enderecos = [];

    if (!atual) {
      print('buscaEnderecos todos');
      await initDB();
      List<Map<String, dynamic>> list = await db.query('enderecos');
      list.forEach((item) {
        enderecos.add(new sqlEndereco(
            item['enderecoGuid'].toString(),
            item['usuEmail'].toString(),
            item['usuGuid'].toString(),
            item['enderecoCEP'].toString(),
            item['enderecoLogra'].toString(),
            item['enderecoNumero'].toString(),
            item['enderecoCompl'].toString(),
            item['enderecoTipo'].toString(),
            item['enderecoAtual'].toLowerCase() == 'true',
            '',
            item['enderecoLatitude'].toString(),
            item['enderecoLongitude'].toString()));
      });
    } else {
      print('buscaEnderecos só atual');
      await initDB();
      List<Map<String, dynamic>> list = await db
          .query('enderecos', where: "enderecoAtual = ?", whereArgs: [1]);
      list.forEach((item) {
        enderecos.add(new sqlEndereco(
            item['enderecoGuid'].toString(),
            item['usuEmail'].toString(),
            item['usuGuid'].toString(),
            item['enderecoCEP'].toString(),
            item['enderecoLogra'].toString(),
            item['enderecoNumero'].toString(),
            item['enderecoCompl'].toString(),
            item['enderecoTipo'].toString(),
            true,
            '',
            item['enderecoLatitude'].toString(),
            item['enderecoLongitude'].toString()));
      });
    }
    return enderecos;
  }

  Future<List<sqlEndereco>> buscaEnderecoSingle(String enderecoGuid) async {
    await initDB();
    return await db.query('enderecos',
        where: "enderecoGuid = ?",
        whereArgs: [enderecoGuid]) as List<sqlEndereco>;
  }

  Future<void> deleteEndereco(String enderecoGuid) async {
    await initDB();
    await db.delete('enderecos',
        where: "enderecoGuid = ?", whereArgs: [enderecoGuid]);
  }

  Future<void> deleteEnderecos() async {
    await initDB();
    await db.delete('enderecos');
  }

  Future<void> insertEndereco(sqlEndereco endereco) async {
    await initDB();
    var ret = await db.insert('enderecos', endereco.toMap());
    print('ret: ' + ret.toString());
  }

  Future<void> updateEndereco(sqlEndereco endereco) async {
    await initDB();
    await db.update('enderecos', endereco.toMap(),
        where: "enderecoGuid = ?", whereArgs: [endereco.enderecoGuid]);
  }

  Future<void> updateEnderecoAtual(String enderecoGuid) async {
    print('updateEnderecoAtualLOCAL');
    await initDB();
    await db.rawUpdate("UPDATE enderecos SET enderecoAtual='false'");
    // db = await openDatabase(dbPath, version: 1);
    //await initDB();
    await db.rawUpdate(
        "UPDATE enderecos SET enderecoAtual='true' WHERE enderecoGuid = '" +
            enderecoGuid +
            "'");
  }

  Future<void> verificaTabela() async {
    await initDB();
    var existe = await db.rawQuery(_verificaTabelaEnderecos);
    if (existe.isEmpty) {
      print('tabela endereços nao existente');
      await initDB();
      await db.execute(_createTableEnderecos);
      print('tabela endereços construída');
    } else { print('tabela endereços existente'); }
  }

  Future<void> redefineTabela() async {
    await initDB();
    await db.execute("DROP TABLE IF EXISTS enderecos");
    print('tabela enderecos destruída');
    await verificaTabela();
  }

  Future<void> initDB() async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    //if (!db.isOpen)
      db = await openDatabase(dbPath, version: 1);

    print('initDB');
  }

  Future<void> closeDB() async {
    if (db.isOpen)
      db.close();
    print('closeDB');
  }

  // pra ver se a tabela de enderecos existe
  final String _verificaTabelaEnderecos = '''
  SELECT name FROM sqlite_master WHERE name ='enderecos' and type='table'; 
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
    enderecoAtual TEXT,
    enderecoUltData TEXT
    enderecoDesde TEXT,
    enderecoLatitude TEXT,
    enderecoLongitude TEXT
    );
  ''';

}
