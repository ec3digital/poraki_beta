import 'package:path/path.dart';
import 'package:poraki/app/data/models/sql/sqlPedidoItem.dart';
import 'package:sqflite/sqflite.dart';
import '../../data/models/sql/sqlPedido.dart';

// ignore: camel_case_types
class sqlPorakiPedidoService {

  Future<List<sqlPedido>> listOrders(String tp) async {
    String path = join( await getDatabasesPath(), 'poraki');
    Database db = await openDatabase(
      path,
      version: 1,
    );

    try {
      // List<Map<String, dynamic>> list = await db.query('vendas');
      var list = await db.query('pedidos', where: "pedidoTipo = ?", whereArgs: [tp]) as List<sqlPedido>;

      return list;
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

    await db.update('pedidos', order.toMap(), where: "pedidoGUID = ?", whereArgs: [order.pedidoGUID]);
    //await db.rawUpdate('UPDATE carrinho set ofertaQtd = ? where ofertaId = ?', [qtd, id]);

    await db.close();
  }

  //vendas itens
  Future<List<sqlPedidoItem>> listOrderItems(String orderGuid) async {
    String path = join( await getDatabasesPath(), 'poraki');
    Database db = await openDatabase(
      path,
      version: 1,
    );

    try {
      // List<Map<String, dynamic>> list = await db.query('vendas');
      var list = await db.query('pedidoItens', where: "pedidoGUID = ?", whereArgs: [orderGuid]) as List<sqlPedidoItem>;

      return list;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> deleteOrderItem(String orderItemGuid) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);
    db.delete('pedidoItens', where: "pedidoItemGUID = ?", whereArgs: [orderItemGuid]);

    await db.close();
  }

  Future<void> insertOrderItem(sqlPedidoItem item) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    var ret = await db.insert('pedidoItens', item.toMap());

    print('ret: ' + ret.toString());
    await db.close();
  }

  Future<void> updatepedidoItem(sqlPedidoItem item) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    await db.update('pedidoItens', item.toMap(), where: "pedidoItemGUID = ?", whereArgs: [item.pedidoItemGUID]);
    //await db.rawUpdate('UPDATE carrinho set ofertaQtd = ? where ofertaId = ?', [qtd, id]);

    await db.close();
  }

}



// late List<SqlVenda> venda = [];
//
// list.forEach((item) {
// venda.add(new SqlVenda(
// vendaId,
// pedidoGUID,
// vendaVendedorGUID,
// vendaVendedorEmail,
// vendaEm,
// vendaValorTotal,
// vendaFormaPagto,
// vendaCancelada,
// vendaPagtoEm,
// vendaPessoaNome,
// vendaPessoaEmail,
// vendaUsuGUID,
// vendaAval,
// vendaAvalEm,
// vendaMoeda,
// vendaCEP,
// vendaEndereco,
// vendaNumero,
// vendaCompl,
// vendaAutoriza,
// vendaInstituicao,
// vendaEntregaPrevista,
// vendaEntregaRealizadaEm,
// vendaEntregaPorUsuEmail,
// vendaEntregaPorUsuNome
// )
//
// new SqlVenda(
// item['vendaId'].toString(),
// '',
// item['ofertaTitulo'].toString(),
// item['ofertaCEP'].toString(),
// '',
// item['ofertaPreco'].toString(),
// item['ofertaQtd'].toString(),
// item['ofertaImgPath'].toString(),
// item['categoriaChave'].toString(),
// item['ofertaEntregaPrevEm'].toString()
// ));
// });
//
