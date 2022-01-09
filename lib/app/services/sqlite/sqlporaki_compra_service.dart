import 'package:path/path.dart';
import 'package:poraki/app/data/models/sql/sqlCompraItem.dart';
import 'package:sqflite/sqflite.dart';
import '../../data/models/sql/sqlCompra.dart';

// ignore: camel_case_types
class sqlPorakiCompraService {

  Future<List<sqlCompra>> compras() async {
    String path = join( await getDatabasesPath(), 'poraki');
    Database db = await openDatabase(
      path,
      version: 1,
    );

    try {
      // List<Map<String, dynamic>> list = await db.query('vendas');
      var list = await db.query('compras') as List<sqlCompra>;

      return list;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> deleteCompra(int id) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);
    db.delete('compras', where: "compraId = ?", whereArgs: [id]);

    await db.close();
  }

  Future<void> insertCompra(sqlCompra item) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    var ret = await db.insert('compras', item.toMap());

    print('ret: ' + ret.toString());
    await db.close();
  }

  Future<void> updateCompra(sqlCompra item) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    await db.update('compras', item.toMap(), where: "compraId = ?", whereArgs: [item.compraId]);
    //await db.rawUpdate('UPDATE carrinho set ofertaQtd = ? where ofertaId = ?', [qtd, id]);

    await db.close();
  }

  //vendas itens
  Future<List<sqlCompraItem>> comprasItens(int compraId) async {
    String path = join( await getDatabasesPath(), 'poraki');
    Database db = await openDatabase(
      path,
      version: 1,
    );

    try {
      // List<Map<String, dynamic>> list = await db.query('vendas');
      var list = await db.query('compraItens', where: "compraId = ?", whereArgs: [compraId]) as List<sqlCompraItem>;

      return list;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> deleteCompraItem(int id) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);
    db.delete('compraItens', where: "compraItemId = ?", whereArgs: [id]);

    await db.close();
  }

  Future<void> insertCompraItem(sqlCompraItem item) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    var ret = await db.insert('compraItens', item.toMap());

    print('ret: ' + ret.toString());
    await db.close();
  }

  Future<void> updateCompraItem(sqlCompraItem item) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    await db.update('compraItens', item.toMap(), where: "compraItemId = ?", whereArgs: [item.compraItemId]);
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
