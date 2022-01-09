import 'package:path/path.dart';
import 'package:poraki/app/data/models/sql/sqlVendaItem.dart';
import 'package:sqflite/sqflite.dart';
import '../../data/models/sql/sqlVenda.dart';

// ignore: camel_case_types
class sqlPorakiVendaService {

  Future<List<sqlVenda>> vendas() async {
    String path = join( await getDatabasesPath(), 'poraki');
    Database db = await openDatabase(
      path,
      version: 1,
    );

    try {
      // List<Map<String, dynamic>> list = await db.query('vendas');
      var list = await db.query('vendas') as List<sqlVenda>;

      return list;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> deleteVenda(int id) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);
    db.delete('vendas', where: "vendaId = ?", whereArgs: [id]);

    await db.close();
  }

  Future<void> insertVenda(sqlVenda item) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    var ret = await db.insert('vendas', item.toMap());

    print('ret: ' + ret.toString());
    await db.close();
  }

  Future<void> updateVenda(sqlVenda item) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    await db.update('vendas', item.toMap(), where: "vendaId = ?", whereArgs: [item.vendaId]);
    //await db.rawUpdate('UPDATE carrinho set ofertaQtd = ? where ofertaId = ?', [qtd, id]);

    await db.close();
  }

  //vendas itens
  Future<List<sqlVendaItem>> vendasItens(int vendaId) async {
    String path = join( await getDatabasesPath(), 'poraki');
    Database db = await openDatabase(
      path,
      version: 1,
    );

    try {
      // List<Map<String, dynamic>> list = await db.query('vendas');
      var list = await db.query('vendaItens', where: "vendaId = ?", whereArgs: [vendaId]) as List<sqlVendaItem>;

      return list;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> deleteVendaItem(int id) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);
    db.delete('vendaItens', where: "vendaItemId = ?", whereArgs: [id]);

    await db.close();
  }

  Future<void> insertVendaItem(sqlVendaItem item) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    var ret = await db.insert('vendaItens', item.toMap());

    print('ret: ' + ret.toString());
    await db.close();
  }

  Future<void> updateVendaItem(sqlVendaItem item) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    await db.update('vendaItens', item.toMap(), where: "vendaItemId = ?", whereArgs: [item.vendaItemId]);
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
