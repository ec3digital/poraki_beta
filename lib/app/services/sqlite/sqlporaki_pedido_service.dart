import 'package:path/path.dart';
import 'package:poraki/app/data/models/PedidoItem.dart';
import 'package:poraki/app/data/models/pedido.dart';
import 'package:poraki/app/data/models/sql/sqlPedidoItem.dart';
import 'package:sqflite/sqflite.dart';
import '../../data/models/sql/sqlPedido.dart';

// ignore: camel_case_types
class sqlPorakiPedidoService {
  late List<sqlPedido> pedidos = [];
  late List<sqlPedidoItem> pedidoItems = [];
  late Database db;

  Future<List<sqlPedido>> listOrders(String userGUID) async {
    String path = join(await getDatabasesPath(), 'poraki');
    Database db = await openDatabase(
      path,
      version: 1,
    );

    try {
      List<Map<String, dynamic>> list = await db.query('pedidos');
      print('qtd pedidos 1: ' + list.length.toString());

      list.forEach((item) {
        pedidos.add(new sqlPedido(
          item['pedidoGUID'].toString(),
          item['pedidoVendedorGUID'].toString(),
          item['pedidoVendedorEmail'].toString(),
          item['pedidoEm'].toString(),
          item['pedidoValorTotal'].toString(),
          item['pedidoFormaPagto'].toString(),
          0,
          item['pedidoPagtoEm'].toString(),
          item['pedidoPessoaNome'].toString(),
          item['pedidoPessoaEmail'].toString(),
          item['pedidoUsuGUID'].toString(),
          int.parse(item['pedidoAval'].toString()),
          item['pedidoAvalEm'].toString(),
          item['pedidoMoeda'].toString(),
          item['pedidoCEP'].toString(),
          item['pedidoEndereco'].toString(),
          item['pedidoNumero'].toString(),
          item['pedidoCompl'].toString(),
          item['pedidoAutoriza'].toString(),
          item['pedidoInstituicao'].toString(),
          item['pedidoEntregaPrevista'].toString(),
          item['pedidoEntregaRealizadaEm'].toString(),
          item['pedidoEntregaPorUsuEmail'].toString(),
          item['pedidoEntregaPorUsuNome'].toString(),
          item['pedidoDetalhe'].toString(),
          item['PedidoEntregaDetalhe'].toString(),
          // item['PedidoEntregaEm'].toString(),
          // item['PedidoEntregaPorEmail'].toString(),
          // item['PedidoEntregaPorNome'].toString(),
          item['RecebidoPor'].toString(),
          item['pedidoLojaId'].toString(),
          item['pedidoEntregaCodigo'].toString(),
        ));
      });

      return pedidos;
    } catch (e) {
      print('erro pedidos: ' + e.toString());
      return Future.error(e);
    }
  }

  Future<sqlPedido> getOrder(String pedidoGUID) async {
    String path = join(await getDatabasesPath(), 'poraki');
    Database db = await openDatabase(
      path,
      version: 1,
    );

    try {
      var list = await db.query('pedidos') as List<sqlPedido>;

      return list.first;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> deleteOrder(String orderGuid) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);
    db.delete('pedidos', where: "pedidoGUID = ?", whereArgs: [orderGuid]);

    await db.close();
  }

  Future<void> insertOrder(sqlPedido order) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    var ret = await db.insert('pedidos', order.toMap());

    print('ret: ' + ret.toString());
    await db.close();
  }

  Future<void> updateOrder(sqlPedido order) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    await db.update('pedidos', order.toMap(),
        where: "pedidoGUID = ?", whereArgs: [order.pedidoGUID]);
    //await db.rawUpdate('UPDATE carrinho set ofertaQtd = ? where ofertaId = ?', [qtd, id]);

    await db.close();
  }

  Future<List<sqlPedidoItem>> listOrderItems(String orderGuid) async {
    String path = join(await getDatabasesPath(), 'poraki');
    Database db = await openDatabase(
      path,
      version: 1,
    );

    var list = await db.query('pedidoItens');
    print('qtd pedidos items 1: ' + list.length.toString());

    list.forEach((item) {
      pedidoItems.add(new sqlPedidoItem(
        item['PedidoItemGUID'].toString(),
        item['PedidoGUID'].toString(),
        item['OfertaGuid'].toString(),
        item['OfertaTitulo'].toString(),
        item['OfertaCEP'].toString(),
        item['OfertaVendedorId'].toString(),
        double.parse(item['OfertaPreco'].toString()),
        double.parse(item['OfertaQtd'].toString()),
        double.parse(item['OfertaTotal'].toString()),
        item['OfertaImgPath'].toString(),
        item['CategoriaChave'].toString(),
        item['OfertaDetalhe'].toString(),
        item['OfertaPrevisaoEntrega'].toString(),
        item['OfertaEntregaCodigo'].toString(),
        item['OfertaEntregueEm'].toString(),
        item['OfertaEntreguePorNome'].toString(),
        item['OfertaEntreguePorEmail'].toString(),
        item['OfertaCanceladaEm'].toString(),
        item['OfertaCanceladaPorNome'].toString(),
        item['OfertaCanceladaPorEmail'].toString(),
        item['OfertaLojaID'].toString(),
      ));
    });
    print('qtd pedidos items 2: ' + pedidoItems.length.toString());

    return pedidoItems;
  }

  Future<void> deleteOrderItem(String orderItemGuid) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);
    db.delete('pedidoItens',
        where: "pedidoItemGUID = ?", whereArgs: [orderItemGuid]);

    await db.close();
  }

  Future<void> insertOrderItem(sqlPedidoItem item) async {
    print('insertOrderItem: ' + item.toMap().toString());
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    var ret = await db.insert('pedidoItens', item.toMap());

    print('ret: ' + ret.toString());
    await db.close();
  }

  Future<void> updateOrderItem(sqlPedidoItem item) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    await db.update('pedidoItens', item.toMap(),
        where: "pedidoItemGUID = ?", whereArgs: [item.pedidoItemGUID]);

    await db.close();
  }

  Pedido convertSqlpedToPedido(sqlPedido sqlPed) {
    return new Pedido(
        sqlPed.pedidoGUID,
        sqlPed.pedidoVendedorGUID,
        sqlPed.pedidoVendedorEmail,
        sqlPed.pedidoEm,
        sqlPed.pedidoValorTotal,
        sqlPed.pedidoFormaPagto,
        sqlPed.pedidoCancelada,
        sqlPed.pedidoPagtoEm,
        sqlPed.pedidoPessoaNome,
        sqlPed.pedidoPessoaEmail,
        sqlPed.pedidoUsuGUID,
        sqlPed.pedidoAval,
        sqlPed.pedidoAvalEm,
        sqlPed.pedidoMoeda,
        sqlPed.pedidoCEP,
        sqlPed.pedidoEndereco,
        sqlPed.pedidoNumero,
        sqlPed.pedidoCompl,
        sqlPed.pedidoAutoriza,
        sqlPed.pedidoInstituicao,
        sqlPed.pedidoEntregaPrevista,
        sqlPed.pedidoEntregaRealizadaEm,
        sqlPed.pedidoEntregaPorUsuEmail,
        sqlPed.pedidoEntregaPorUsuNome,
        sqlPed.pedidoDetalhe,
        sqlPed.pedidoEntregaDetalhe,
        // sqlPed.pedidoEntregaEm,
        // sqlPed.pedidoEntregaPorEmail,
        // sqlPed.pedidoEntregaPorNome,
        sqlPed.pedidoRecebidoPor,
        sqlPed.pedidoLojaId,
        sqlPed.pedidoEntregaCodigo);
  }

  PedidoItem convertSqlpedItemToPedidoItem(sqlPedidoItem sqlPedItem) {
    //TODO: adicionar no sqlPedidoItem o Detalhe
    return new PedidoItem(
        sqlPedItem.pedidoItemGUID,
        sqlPedItem.pedidoGUID,
        sqlPedItem.ofertaGuid,
        sqlPedItem.ofertaTitulo,
        sqlPedItem.ofertaCEP,
        sqlPedItem.ofertaVendedorGuid,
        sqlPedItem.ofertaPreco,
        sqlPedItem.ofertaQtd,
        sqlPedItem.ofertaTotal,
        sqlPedItem.ofertaImgPath,
        0, //sqlPedItem.ofertaCancelada, TODO: alterar nas APIs
        sqlPedItem.ofertaEntregueEm,
        sqlPedItem.categoriaChave,
        sqlPedItem.ofertaDetalhe,
        sqlPedItem.ofertaPrevisaoEntrega,
        sqlPedItem.ofertaEntreguePorEmail,
        sqlPedItem.ofertaEntreguePorNome,
        sqlPedItem.ofertaCanceladaEm,
        sqlPedItem.ofertaCanceladaPorEmail,
        sqlPedItem.ofertaCanceladaPorNome,
        sqlPedItem.ofertaLojaID);
  }


  Future<void> verificaTabela() async {
    await initDB();
    var existe = await db.rawQuery(_verificaTabela);
    if (existe.isEmpty) {
      print('tabela pedidos nao existente');
      await initDB();
      await db.execute(_createTablePedidos);
      print('tabela pedidos construída');
    } else { print('tabela pedidos existente'); }
  }

  Future<void> verificaTabelaItems() async {
    await initDB();
    var existe = await db.rawQuery(_verificaTabelaItens);
    if (existe.isEmpty) {
      print('tabela pedidos itens nao existente');
      await initDB();
      await db.execute(_createTablePedidoItens);
      print('tabela pedidos itens construída');
    } else { print('tabela pedidos itens existente'); }
    await closeDB();
  }

  Future<void> redefineTabela() async {
    await initDB();
    await db.execute("DROP TABLE IF EXISTS pedidos");
    await db.execute("DROP TABLE IF EXISTS pedidoitens");
    print('tabela pedidos e pedidoitens itens destruída');
    await verificaTabela();
    await verificaTabelaItems();
  }

  // Future<void> redefineTabelaItems() async {
  //   await initDB();
  //   await db.execute("DROP TABLE IF EXISTS pedidoitens");
  //   print('tabela pedidoitens itens destruída');
  //   await verificaTabelaItems();
  // }


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
  final String _verificaTabela = '''
  SELECT name FROM sqlite_master WHERE name ='Pedidos' and type='table'; 
  ''';

  // pra ver se a tabela de enderecos existe
  final String _verificaTabelaItens = '''
  SELECT name FROM sqlite_master WHERE name ='pedidoitens' and type='table'; 
  ''';


  // somente depois de fechada, enquanto aberta, somente da API
  final String _createTablePedidos = '''
    CREATE TABLE IF NOT EXISTS Pedidos (
    pedidoGUID TEXT,
    pedidoVendedorGUID TEXT,
    pedidoVendedorEmail TEXT,
    pedidoEm TEXT,
    pedidoValorTotal TEXT,
    pedidoFormaPagto TEXT,
    pedidoCancelada INT,
    pedidoPagtoEm TEXT,
    pedidoPessoaNome TEXT,
    pedidoPessoaEmail TEXT,
    pedidoUsuGUID TEXT,
    pedidoAval INT,
    pedidoAvalEm TEXT,
    pedidoMoeda TEXT,
    pedidoCEP TEXT,
    pedidoEndereco TEXT,
    pedidoNumero TEXT,
    pedidoCompl TEXT,
    pedidoAutoriza TEXT,
    pedidoInstituicao TEXT,
    pedidoEntregaPrevista TEXT,
    pedidoEntregaRealizadaEm TEXT,
    pedidoEntregaPorUsuEmail TEXT,
    pedidoEntregaPorUsuNome TEXT,
    pedidoEntregaDetalhe TEXT,
    pedidoDetalhe TEXT,
    pedidoRecebidoPor TEXT,
    pedidoLojaId TEXT
    );
  ''';

  // somente depois de fechada, enquanto aberta, somente da API
  final String _createTablePedidoItens = '''
    CREATE TABLE IF NOT EXISTS pedidoitens (
    pedidoItemGUID INT,
    pedidoGUID TEXT,
    ofertaGUID TEXT,
    ofertaTitulo TEXT,
    ofertaCEP TEXT,
    ofertaVendedorGuid TEXT,
    ofertaPreco REAL,
    ofertaQtd INT,
    ofertaTotal REAL,
    ofertaImgPath TEXT,
    categoriaChave TEXT,
    ofertaDetalhe TEXT,
    ofertaCanceladaEm TEXT,
    ofertaCanceladaPorNome TEXT,
    ofertaCanceladaPorEmail TEXT,
    ofertaEntregaCodigo TEXT,
    ofertaEntregueEm TEXT,
    ofertaEntreguePorNome TEXT,
    ofertaEntreguePorEmail TEXT,
    ofertaPrevisaoEntrega TEXT,
    ofertaLojaID TEXT
    );
  ''';


}
