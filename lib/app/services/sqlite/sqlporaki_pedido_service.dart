import 'package:path/path.dart';
import 'package:poraki/app/data/models/sql/sqlPedidoItem.dart';
import 'package:sqflite/sqflite.dart';
import '../../data/models/sql/sqlPedido.dart';

// ignore: camel_case_types
class sqlPorakiPedidoService {

  late List<sqlPedido> pedidos = [];
  late List<sqlPedidoItem> pedidoItems = [];

  Future<List<sqlPedido>> listOrders(String userGUID) async {
    String path = join( await getDatabasesPath(), 'poraki');
    Database db = await openDatabase(
      path,
      version: 1,
    );

    try {
      // List<Map<String, dynamic>> list = await db.query('vendas');
      List<Map<String, dynamic>> list = await db.query('pedidos'); // as List<sqlPedido>; //, where: "pedidoUsuGUID = ?", whereArgs: [userGUID]) as List<sqlPedido>;
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
            //item['pedidoCancelada']!,
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
            item['pedidoEntregaPorUsuNome'].toString()
        ));

      });

        return pedidos;
      //return list;
    } catch (e) {
      print('erro pedidos: ' + e.toString());
      return Future.error(e);
    }
  }

  Future<sqlPedido> getOrder(String pedidoGUID) async {
    String path = join( await getDatabasesPath(), 'poraki');
    Database db = await openDatabase(
      path,
      version: 1,
    );

    try {
      // List<Map<String, dynamic>> list = await db.query('vendas');
      var list = await db.query('pedidos') as List<sqlPedido>; //, where: "pedidoGUID = ?", whereArgs: [pedidoGUID]) as List<sqlPedido>;

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

    //try {
      // List<Map<String, dynamic>> list = await db.query('vendas');
      var list = await db.query('pedidoItens'); // as List<sqlPedidoItem>; //, where: "pedidoGUID = ?", whereArgs: [orderGuid]) as List<sqlPedidoItem>;
      print('qtd pedidos items 1: ' + list.length.toString());

      list.forEach((item) {pedidoItems.add(new sqlPedidoItem(
          item['pedidoItemGUID'].toString(),
          item['pedidoGUID'].toString(),
          item['ofertaGuid'].toString(),
          item['ofertaTitulo'].toString(),
          item['ofertaCEP'].toString(),
          int.parse(item['ofertaVendedorId'].toString()),
          double.parse(item['ofertaPreco'].toString()),
          int.parse(item['ofertaQtd'].toString()),
          double.parse(item['ofertaTotal'].toString()),
          item['ofertaImgPath'].toString(),
          item['categoriaChave'].toString(),
          int.parse(item['ofertaCancelada'].toString()),
          item['ofertaEntregueEm'].toString()));
        });
    print('qtd pedidos items 2: ' + pedidoItems.length.toString());

    return pedidoItems;
      }


      //return list;
    // } catch (e) {
    //   return Future.error(e);
    // }


  Future<void> deleteOrderItem(String orderItemGuid) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);
    db.delete('pedidoItens', where: "pedidoItemGUID = ?", whereArgs: [orderItemGuid]);

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
