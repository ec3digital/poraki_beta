import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../data/models/sql/sqlCarrinho.dart';

// ignore: camel_case_types
class sqlPorakiCartService {

  Future<List<sqlCarrinho>> carrinho() async {
    String path = join( await getDatabasesPath(), 'poraki');
    Database db = await openDatabase(
      path,
      version: 1,
    );

    try {
      List<Map<String, dynamic>> list = await db.query('carrinho');
      print('qt tab cart: ' + list.length.toString());
      late List<sqlCarrinho> itemsCarrinho = [];

      list.forEach((item) {
        itemsCarrinho.add(new sqlCarrinho(
            item['ofertaId'].toString(),
            item['ofertaGUID'].toString(),
            item['ofertaTitulo'].toString(),
            item['ofertaCEP'].toString(),
          item['ofertaVendedorGUID'].toString(),
            item['ofertaPreco'].toString(),
            item['ofertaQtd'].toString(),
            item['ofertaImgPath'].toString(),
            item['categoriaChave'].toString(),
            item['ofertaEntregaPrevEm'].toString(),
            item['ofertaLojaGUID'].toString(),
            item['ofertaDetalhe'].toString(),
        ));
      });

      print('qt itens cart: ' + itemsCarrinho.length.toString());

      return itemsCarrinho;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> deleteItemCarrinho(int id) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);
    db.delete('carrinho', where: "ofertaId = ?", whereArgs: [id]);

    await db.close();
  }

  Future<void> deleteCarrinho() async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);
    await db.delete('carrinho');

    await db.close();
  }

  Future<String> insertItemCarrinho(sqlCarrinho item) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    bool exist = await existeItemCarrinho(int.parse(item.ofertaId));
    if(exist) {
      print('caiu no existe');
      await increaseQtyItemCarrinho(int.parse(item.ofertaId));
      return "Item  adicionado!";
    }
    else {
      print('caiu no NAO existe');
      List<sqlCarrinho> carrinho = await sqlPorakiCartService().carrinho();
      if(carrinho.where((prod) => prod.ofertaGUID == item.ofertaGUID).isNotEmpty) {
        return "Desculpe, por enquanto o Carrinho nao pode ter itens de vendedores/lojas diferentes ;-(";
      }

      carrinho.forEach((element) {
        sqlCarrinho elem = element;
      });

      await db.insert('carrinho', item.toMap());
      return "Item  adicionado!";
    }

    // print('ret: ' + ret.toString());
    await db.close();
  }

  Future<void> updateItemCarrinho(int id, int qtd) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    //db.update('carrinho', item.toMap(), where: "ofertaId = ?", whereArgs: [item.ofertaId]);
    await db.rawUpdate('UPDATE carrinho set ofertaQtd = ? where ofertaId = ?', [qtd, id]);

    await db.close();
  }

  Future<void> increaseQtyItemCarrinho(int itemId) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    print('ofertaId carrinho -> ' + itemId.toString());
    await db.rawUpdate('UPDATE carrinho set ofertaQtd = ofertaQtd + 1 where ofertaId = ?', [itemId]);

    await db.close();
  }

  Future<void> decreaseQtyItemCarrinho(int itemId) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    print('ofertaId carrinho -> ' + itemId.toString());
    await db.rawUpdate('UPDATE carrinho set ofertaQtd = ofertaQtd - 1 where ofertaId = ?', [itemId]);

    await db.close();
  }

  Future<void> changeQtyItemCarrinho(int itemId, int qtd) async {
    print('changeQtyItemCarrinho');
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    print('ofertaId carrinho -> ' + itemId.toString());
    await db.rawUpdate('UPDATE carrinho set ofertaQtd = ' + qtd.toString() + ' where ofertaId = ?', [itemId.toString()]);

    await db.close();
  }

  Future<bool> existeItemCarrinho(int id) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    var ret = await db.rawQuery('SELECT ofertaId FROM carrinho where ofertaId = ?', [id]); // .rawUpdate('UPDATE carrinho set ofertaQtd = ? where ofertaId = ?', [qtd, id]);

    // await db.close();

    print('existe? -> ' + ret.isNotEmpty.toString());
    return ret.isNotEmpty;
  }

}