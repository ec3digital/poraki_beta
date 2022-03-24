import 'package:path/path.dart';
import 'package:poraki/app/data/models/sql/sqlCore.dart';
import 'package:sqflite/sqflite.dart';

class sqlPorakiCoreService {

  Future<sqlCore> buscaValor(String chave) async {
    String path = join(await getDatabasesPath(), 'poraki');
    Database db = await openDatabase(
      path,
      version: 1,
    );

    await verificaTabela();

    try {
      var list = await db.query('core', where: "chave = ?", whereArgs: [chave]) as List<sqlCore>;

      return list.first;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<sqlCore> buscaValorCep(String chave, String cep) async {
    String path = join(await getDatabasesPath(), 'poraki');
    Database db = await openDatabase(
      path,
      version: 1,
    );

    await verificaTabela();

    try {
      var list = await db.query('core', where: "chave = ? and cep = ?", whereArgs: [chave, cep]) as List<sqlCore>;

      return list.first;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<sqlCore>> buscaTodosValores() async {
    String path = join(await getDatabasesPath(), 'poraki');
    Database db = await openDatabase(
      path,
      version: 1,
    );

    await verificaTabela();
    List<sqlCore> valores = [];

    List<Map<String, dynamic>> list = await db.query('core');
    print('query qtd: ' + list.length.toString());
    list.forEach((item) {
    valores.add(new sqlCore(
    item['chave'],
    item['valores'],
    item['cep']));
    });

    return valores;
  }

    Future<void> verificaTabela() async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    var existe = await db.rawQuery(_verificaTabela);
    if (existe.isEmpty) {
      await db.execute(_createTable);
      print('tabela core construída');
      await valoresIniciais();
      print('valor iniciais criados');
    }
  }

  Future<void> valoresIniciais() async {
    String path = join(await getDatabasesPath(), 'poraki');
    Database db = await openDatabase(
      path,
      version: 1,
    );

    await verificaTabela();
    Batch batch = db.batch();
    batch.insert('core', {'chave': 'apibase', 'valor': 'https://poraki.hasura.app/api/rest/', 'cep': '*'});
    batch.insert('core', {'chave': 'apiPessoa', 'valor': 'pessoardz'});
    batch.insert('core', {'chave': 'apiCategorias', 'valor': 'categorias'});
    batch.insert('core', {'chave': 'apiOfertas', 'valor': 'ofertasdodia'});
    batch.insert('core', {'chave': 'apiEnderecos', 'valor': 'enderecosPorEmail'});
    batch.insert('core', {'chave': 'apiEnderecoAdd', 'valor': 'enderecoadd'});
    batch.insert('core', {'chave': 'apiMoffer', 'valor': 'moffer'});
    batch.insert('core', {'chave': 'apiMofferAdd', 'valor': 'mofferadd'});
    batch.insert('core', {'chave': 'apiMoffers', 'valor': 'moffers'});
    batch.insert('core', {'chave': 'apiPedidoAdd', 'valor': 'pedidoadd'});
    batch.insert('core', {'chave': 'apiPedidoItens', 'valor': 'pedidoitens'});
    batch.insert('core', {'chave': 'apiPedidoItensAdd', 'valor': 'pedidoitensadd'});
    batch.insert('core', {'chave': 'apiPedidosClienteOpen', 'valor': 'pedidoporclienteopen'});
    batch.insert('core', {'chave': 'apiPedidosCliente', 'valor': 'pedidosporcliente'});
    batch.insert('core', {'chave': 'apiPedidosVendedor', 'valor': 'pedidosporvendedor'});
    batch.insert('core', {'chave': 'apiPedidosVendedorOpen', 'valor': 'pedidosporvendedoropen'});
    batch.insert('core', {'chave': 'header-user', 'valor': 'x-hasura-admin-secret', 'cep': ''});
    batch.insert('core', {'chave': 'header-secret', 'valor': 'iy67sW4CLrijAZ3dSDeKpzo565EqoWWnk81DQX8hu1bEE7Q7nCntduiiS2IdKJNR', 'cep': ''});
    batch.insert('core', {'chave': 'uuidservice', 'valor': 'https://www.uuidgenerator.net/api/version4'});
    batch.insert('core', {'chave': 'cepservice', 'valor': 'https://brasilapi.com.br/api/cep/v2/'});
    batch.insert('core', {'chave': 'primaryColor', 'valor': '0xff0000FF'});
    batch.insert('core', {'chave': 'secondaryColor', 'valor': '0xff00F000'});
    batch.insert('core', {'chave': 'primaryColorButton', 'valor': '0xffb3c9f2'});
    batch.insert('core', {'chave': 'secondaryColorButton', 'valor': '0xffb3c9f2'});
    batch.insert('core', {'chave': 'containerLightColor', 'valor': '0xffEEEEEE'});
    batch.insert('core', {'chave': 'borderColor', 'valor': '0xff9E9E9E'});
    batch.insert('core', {'chave': 'darkText', 'valor': '0x8a000000'});
    batch.insert('core', {'chave': 'primaryDark', 'valor': '0xff161616'});
    batch.insert('core', {'chave': 'primaryLight', 'valor': '0xffF7F7F7'});
    batch.insert('core', {'chave': 'primaryBackground', 'valor': '0xfdfdfd'});
    batch.insert('core', {'chave': 'secondaryBackground', 'valor': '0xfFFfEB3B'});
    batch.insert('core', {'chave': 'cepatual', 'valor': ''});
  }

  // pra ver se a tabela de enderecos existe
  final String _verificaTabela = '''
  SELECT * FROM sqlite_master WHERE name ='core' and type='table'; 
  ''';

  // Tipos de Endereços: Home / Work / School / Others
  final String _createTable = '''
    CREATE TABLE IF NOT EXISTS core (
    chave TEXT,
    valor TEXT
    );
  ''';

  final String _createStartValues = '''
    INSERT INTO core (chave, valor) VALUES ()
  ''';
}