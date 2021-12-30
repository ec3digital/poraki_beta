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
      // var list = await db.rawQuery('SELECT * FROM carrinho', []);
      // var list = await db.query('carrinho');
      List<Map<String, dynamic>> list = await db.query('carrinho');
      print('qt tab cart: ' + list.length.toString());
      late List<sqlCarrinho> itemsCarrinho = [];

      list.forEach((item) {
        itemsCarrinho.add(new sqlCarrinho(
            item['ofertaId'].toString(),
            '',
            item['ofertaTitulo'].toString(),
            item['ofertaCEP'].toString(),
            '',
            item['ofertaPreco'].toString(),
            item['ofertaQtd'].toString(),
            item['ofertaImgPath'].toString(),
            item['categoriaChave'].toString(),
            item['ofertaEntregaPrevEm'].toString()
        ));
      });

      print('qt itens cart: ' + itemsCarrinho.length.toString());

      return itemsCarrinho;
    } catch (e) {
      return Future.error(e);
    }

  //
  //   final maps = await db.query('carrinho');
  //
  //   return List.generate(maps.length, (i) { //create a list of memos
  //     //return sqlCarrinho(ofertaId, ofertaGUID, ofertaTitulo, ofertaCEP, ofertaVendedorGUID, ofertaPreco, ofertaQtd, ofertaImgPath, categoriaChave, ofertaEntregaPrevEm).toMap();
  //     return new sqlCarrinho(
  //       maps[i]['ofertaID'].toString(),
  //         maps[i]['ofertaGUID'].toString(),
  //         maps[i]['ofertaTitulo'].toString(),
  //       maps[i]['ofertaCEP'].toString(),
  //     maps[i]['ofertaVendedorGUID'].toString(),
  //       maps[i]['ofertaPreco'].toString(),
  //         maps[i]['ofertaQtd'].toString(),
  //         maps[i]['ofertaImgPath'].toString(),
  //         maps[i]['categoriaChave'].toString(),
  //     maps[i]['ofertaEntregaPrevEm'].toString()
  //     );
  // });
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
    db.delete('carrinho');

    await db.close();
  }

  Future<void> insertItemCarrinho(sqlCarrinho item) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    var ret = await db.insert('carrinho', item.toMap());

    print('ret: ' + ret.toString());
    await db.close();
  }

  Future<void> updateItemCarrinho(sqlCarrinho item) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    db.update('carrinho', item.toMap(), where: "ofertaId = ?", whereArgs: [item.ofertaId]);

    await db.close();
  }

}