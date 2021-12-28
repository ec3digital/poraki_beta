// import 'package:flutter/cupertino.dart';
// import 'package:poraki/app/data/models/categorias.dart';
// import 'package:sqflite/sqflite.dart';
// import '../db.dart';
//
// class DbCategoriesRepo extends ChangeNotifier{
//   late Database db;
//   List<Categorias> _categorias = [];
//
//   List<Categorias> get categorias => _categorias;
//
//   DbCategoriesRepo() {
//     _initRepo();
//   }
//
//   _initRepo() async {
//     await getCategorias();
//   }
//
//   getCategorias() async {
//     db = await DB.instance.database;
//     _categorias = (await db.query('categorias')).cast<Categorias>();
//     notifyListeners();
//   }
//
// }