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
      var list = await db.query('appcore', where: "coreChave = ?", whereArgs: [chave]) as List<sqlCore>;

      return list.first;
    } catch (e) {
      return Future.error(e);
    }
  }


  Future<sqlCore> buscaValorCep(String chave) async {
    String path = join(await getDatabasesPath(), 'poraki');
    Database db = await openDatabase(
      path,
      version: 1,
    );

    await verificaTabelaCep();

    try {
      var list = await db.query('appcorecep', where: "coreChave = ?", whereArgs: [chave]) as List<sqlCore>;

      return list.first;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Future<sqlCore> buscaValorCep(String chave, String cep) async {
  //   String path = join(await getDatabasesPath(), 'poraki');
  //   Database db = await openDatabase(
  //     path,
  //     version: 1,
  //   );
  //
  //   await verificaTabela();
  //
  //   try {
  //     var list = await db.query('appcore', where: "coreChave = ? and cep = ?", whereArgs: [chave, cep]) as List<sqlCore>;
  //
  //     return list.first;
  //   } catch (e) {
  //     return Future.error(e);
  //   }
  // }

  Future<List<sqlCore>> buscaTodosValores() async {
    String path = join(await getDatabasesPath(), 'poraki');
    Database db = await openDatabase(
      path,
      version: 1,
    );

    await verificaTabela();
    List<sqlCore> valores = [];

    List<Map<String, dynamic>> list = await db.query('appcore');

    if(list.length == 0) {
      print('buscaTodosValores / valoresIniciais');
      await valoresIniciais();
    }

    print('query qtd: ' + list.length.toString());
    list.forEach((item) {
    valores.add(new sqlCore(
    item['coreChave'],
    item['coreValor'],
    // item['cep']
    ));
    });

    print('core local qtd: ' + list.length.toString());
    return valores;
  }

  Future<List<sqlCore>> buscaTodosValoresCep() async {
    String path = join(await getDatabasesPath(), 'poraki');
    Database db = await openDatabase(
      path,
      version: 1,
    );

    await verificaTabelaCep();
    List<sqlCore> valoresCep = [];

    List<Map<String, dynamic>> listCep = await db.query('appcorecep');

    if(listCep.length == 0) {
      await valoresIniciais();
    }

    print('query qtd: ' + listCep.length.toString());
    listCep.forEach((item) {
      valoresCep.add(new sqlCore(
        item['coreChave'],
        item['coreValor'],
        // item['cep']
      ));
    });

    print('core local qtd: ' + listCep.length.toString());
    return valoresCep;
  }

  Future<void> resetaTabela() async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    await db.execute('DELETE FROM appcore');
    print('tabela appcore limpa');
  }

  Future<void> resetaTabelaCep() async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    await db.execute('DELETE FROM appcorecep');
    print('tabela appcorecep limpa');
  }

  Future<void> atualizaCore(sqlCore coreUpdate) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    var sqlCmd = "UPDATE appcore SET coreValor = '${coreUpdate.coreValor.toString()}' WHERE coreChave = '${coreUpdate.coreChave.toString()}'";
    print(sqlCmd);
    await db.rawUpdate(sqlCmd);
  }

  Future<void> atualizaCoreCep(sqlCore coreUpdate) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    var sqlCmd = "UPDATE appcorecep SET coreValor = '${coreUpdate.coreValor.toString()}' WHERE coreChave = '${coreUpdate.coreChave.toString()}'";
    print(sqlCmd);
    await db.rawUpdate(sqlCmd);
  }

    Future<void> verificaTabela() async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    var existe = await db.rawQuery(_verificaTabela);
    if (existe.isEmpty) {
      await db.execute(_createTable);
      print('verificaTabela - tabela core construída');
      await valoresIniciais();
      print('verificaTabela - valor iniciais criados');
    }
  }

  Future<void> verificaTabelaCep() async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    var existe = await db.rawQuery(_verificaTabelaCep);
    if (existe.isEmpty) {
      await db.execute(_createTableCep);
      print('tabela appcorecep construída');
      await valoresIniciaisCep();
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
    batch.insert('appcore', {'coreChave': 'apiCategorias', 'coreValor': 'categorias'});
    batch.insert('appcore', {'coreChave': 'apiCategoriasBarra', 'coreValor': 'categoriasbarra'});
    batch.insert('appcore', {'coreChave': 'apiEndereco', 'coreValor': 'endereco'});
    batch.insert('appcore', {'coreChave': 'apiEnderecoAtual', 'coreValor': 'enderecoatual'});
    batch.insert('appcore', {'coreChave': 'apiEnderecos', 'coreValor': 'enderecos'});
    batch.insert('appcore', {'coreChave': 'apiLojasPorVendedor', 'coreValor': 'lojasporvendedor'});
    batch.insert('appcore', {'coreChave': 'apiLoja', 'coreValor': 'loja'});
    batch.insert('appcore', {'coreChave': 'apiMelhoresOfertas', 'coreValor': 'melhoresofertas'});
    batch.insert('appcore', {'coreChave': 'apiMoffer', 'coreValor': 'moffer'});
    batch.insert('appcore', {'coreChave': 'apiMoffers', 'coreValor': 'moffers'});
    batch.insert('appcore', {'coreChave': 'apiMoffersStore', 'coreValor': 'moffersstore'});
    batch.insert('appcore', {'coreChave': 'apiOferta', 'coreValor': 'oferta'});
    batch.insert('appcore', {'coreChave': 'apiOfertas', 'coreValor': 'ofertasdodia'});
    batch.insert('appcore', {'coreChave': 'apiOfertasCategoria', 'coreValor': 'ofertasporcepcategoria'});
    batch.insert('appcore', {'coreChave': 'apiOfertasCategoriaTitulo', 'coreValor': 'ofertasporcepcategoriatitulo'});
    batch.insert('appcore', {'coreChave': 'apiOfertasMaisFrescas', 'coreValor': 'ofertasmaisfrescas'});
    batch.insert('appcore', {'coreChave': 'apiOfertasMaisVendidas', 'coreValor': 'ofertasmaisvendidas'});
    batch.insert('appcore', {'coreChave': 'apiOfertasTitulo', 'coreValor': 'ofertasporceptitulo'});
    batch.insert('appcore', {'coreChave': 'apiPedido', 'coreValor': 'pedido'});
    batch.insert('appcore', {'coreChave': 'apiPedidoItens', 'coreValor': 'pedidoitens'});
    batch.insert('appcore', {'coreChave': 'apiPedidosPorCliente', 'coreValor': 'pedidosporcliente'});
    batch.insert('appcore', {'coreChave': 'apiPedidosPorClienteOpen', 'coreValor': 'pedidosporclienteopen'});
    batch.insert('appcore', {'coreChave': 'apiPedidosPorVendedor', 'coreValor': 'pedidosporvendedor'});
    batch.insert('appcore', {'coreChave': 'apiPedidosPorVendedorOpen', 'coreValor': 'pedidosporvendedoropen'});
    batch.insert('appcore', {'coreChave': 'apiUsuarioSus', 'coreValor': 'ususus'});
    batch.insert('appcore', {'coreChave': 'uuidservice', 'coreValor': 'https://www.uuidgenerator.net/api/version4'});
    batch.insert('appcore', {'coreChave': 'cepservice', 'coreValor': 'https://brasilapi.com.br/api/cep/v2/'});

    batch.insert('appcore', {'coreChave': 'apiPedidoAvalia', 'coreValor': 'pedidoavalia'});
    batch.insert('appcore', {'coreChave': 'apiPedidoCancela', 'coreValor': 'pedidocancela'});
    batch.insert('appcore', {'coreChave': 'apiPedidoEntrega', 'coreValor': 'pedidoentrega'});
    batch.insert('appcore', {'coreChave': 'apiPedidoPagto', 'coreValor': 'pedidopagto'});
    batch.insert('appcore', {'coreChave': 'apiLojaInativar', 'coreValor': 'inativloja'});
    batch.insert('appcore', {'coreChave': 'apiOfertaInativar', 'coreValor': 'inativoferta'});
    batch.insert('appcore', {'coreChave': 'apiOfertaAvalia', 'coreValor': 'avaliaoferta'});
    batch.insert('appcore', {'coreChave': 'apiEnderecoAtual', 'coreValor': 'enderecoatual'});
    batch.insert('appcore', {'coreChave': 'apiEnderecoNAtual', 'coreValor': 'endereconatual'});

    batch.insert('appcore', {'coreChave': 'backDark', 'coreValor': '0xFF21B6A8'});
    batch.insert('appcore', {'coreChave': 'backLight', 'coreValor': '0xFFA3EBB1'});
    batch.insert('appcore', {'coreChave': 'iconColor', 'coreValor': '0xDDFF8885'});
    batch.insert('appcore', {'coreChave': 'textDark', 'coreValor': '0xFF116530'});
    batch.insert('appcore', {'coreChave': 'textLight', 'coreValor': '0xffFFFFFF'});
    batch.insert('appcore', {'coreChave': 'textSearch', 'coreValor': 'buscar poraki...'});
    batch.insert('appcore', {'coreChave': 'textCard1', 'coreValor': 'Ofertas do dia'});
    batch.insert('appcore', {'coreChave': 'textCard2', 'coreValor': 'Melhores ofertas'});
    batch.insert('appcore', {'coreChave': 'textCard3', 'coreValor': 'Mais vendidos'});
    batch.insert('appcore', {'coreChave': 'textCard4', 'coreValor': 'Mais fresquinhos'});
    batch.insert('appcore', {'coreChave': 'textCard5', 'coreValor': 'Outras ofertas 1'});
    batch.insert('appcore', {'coreChave': 'textCard6', 'coreValor': 'Outras ofertas 2'});
    batch.insert('appcore', {'coreChave': 'imgpath', 'coreValor': 'https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/ofertas%2F'});
    batch.insert('appcore', {'coreChave': 'imgpathsuffix', 'coreValor': '.jpg?alt=media'});
    batch.insert('appcore', {'coreChave': 'lastreload', 'coreValor': '20220401'});
    batch.insert('appcore', {'coreChave': 'apiBase', 'coreValor': 'https://poraki.hasura.app/api/rest/'});
    batch.insert('appcore', {'coreChave': 'header-user', 'coreValor': 'x-hasura-admin-secret'}); //, 'cep': ''
    batch.insert('appcore', {'coreChave': 'header-secret', 'coreValor': 'iy67sW4CLrijAZ3dSDeKpzo565EqoWWnk81DQX8hu1bEE7Q7nCntduiiS2IdKJNR'});

    print('valor iniciais criados');
    await batch.commit(noResult: true);
  }

  Future<void> valoresIniciaisCep() async {
    String path = join(await getDatabasesPath(), 'poraki');
    Database db = await openDatabase(
      path,
      version: 1,
    );

    await verificaTabelaCep();
    Batch batch = db.batch();
    batch.insert('appcorecep', {'coreChave': 'apiBase', 'coreValor': 'https://poraki.hasura.app/api/rest/'});
    batch.insert('appcorecep', {'coreChave': 'header-user', 'coreValor': 'x-hasura-admin-secret'}); //, 'cep': ''
    batch.insert('appcorecep', {'coreChave': 'header-secret', 'coreValor': 'iy67sW4CLrijAZ3dSDeKpzo565EqoWWnk81DQX8hu1bEE7Q7nCntduiiS2IdKJNR'});
    batch.insert('appcorecep', {'coreChave': 'lastreload', 'coreValor': '20220401'});

    print('valor iniciais cep criados');
    await batch.commit(noResult: true);
  }

  // pra ver se a tabela de enderecos existe
  final String _verificaTabela = '''
  SELECT * FROM sqlite_master WHERE name ='appcore' and type='table'; 
  ''';

  // Tipos de Endereços: Home / Work / School / Others
  final String _createTable = '''
    CREATE TABLE IF NOT EXISTS appcore (
    coreChave TEXT,
    coreValor TEXT
    );
  ''';

  // pra ver se a tabela de enderecos existe
  final String _verificaTabelaCep = '''
  SELECT * FROM sqlite_master WHERE name ='appcorecep' and type='table'; 
  ''';

  // Tipos de Endereços: Home / Work / School / Others
  final String _createTableCep = '''
    CREATE TABLE IF NOT EXISTS appcorecep (
    coreChave TEXT,
    coreValor TEXT
    );
  ''';

  // final String _createStartValues = '''
  //   INSERT INTO appcore (chave, valor) VALUES ()
  // ''';
}