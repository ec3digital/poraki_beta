import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class hivePorakiUserService {

  late Box _box; // = Hive.box('userBox');

  hivePorakiUserService() {
    _iniHive();

    //_testHive();
  }

  _iniHive() async {
    print('_iniHive');
    await Hive.initFlutter();
    await Hive.openBox('userBox');
    _box = Hive.box('userBox');
  }

  Future<String> GetUserCep() async {
    return _box.get('userCep');
  }

  void SetUserCep(String cep) async {
    _box.put('userCep', cep);
  }

  Future<String> GetUserName() async {
    return _box.get('userName');
  }

  void SetUserName(String nome) async {
    _box.put('userName', nome);
  }

  Future<String> GetUserEmail() async {
    return _box.get('userEmail');
  }

  void SetUserEmail(String email) async {
    _box.put('userEmail', email);
  }

  Future<int> GetUserRate() async {
    return _box.get('userRate');
  }

  void SetUserRate(int rate) async {
    _box.put('userRate', rate);
  }

  Future<String> GetUserUID() async {
    return _box.get('userUID');
  }

  void SetUserUID(String userUID) async {
    _box.put('userUID', userUID);
  }

  Future<String> GetLastLogin() async {
    return _box.get('userLastLogin');
  }

  void SetLastLogin(String lastLogin) async {
    _box.put('userLastLogin', lastLogin);
  }

//
  // String GetBucketAssetsUri() {
  //   var box = Hive.box('cepUser');
  //   return box.get('cepAtual');
  // }
  //
  // void SetBucketAssetsUri(String cep) {
  //   var box = Hive.box('cepUser');
  //   box.put('cepAtual', cep);
  // }
  //
  // String GetBucketOffersUri() {
  //   var box = Hive.box('cepUser');
  //   return box.get('cepAtual');
  // }
  //
  // void SetBucketOffersUri(String cep) {
  //   var box = Hive.box('cepUser');
  //   box.put('cepAtual', cep);
  // }
  //
  // String GetBucketUsersUri() {
  //   var box = Hive.box('cepUser');
  //   return box.get('cepAtual');
  // }
  //
  // void SetBucketUsersUri(String cep) {
  //   var box = Hive.box('cepUser');
  //   box.put('cepAtual', cep);
  // }
  //
  // String GetCepOffersUri() {
  //   var box = Hive.box('cepUser');
  //   return box.get('cepAtual');
  // }
  //
  // void SetCepOffersUri(String cep) {
  //   var box = Hive.box('cepUser');
  //   box.put('cepAtual', cep);
  // }
  //
  // String GetColor1() {
  //   var box = Hive.box('colors');
  //   return box.get('color1');
  // }
  //
  // void SetColor1(String cep) {
  //   var box = Hive.box('colors');
  //   box.put('color1', cep);
  // }
  //
  // String GetColor2() {
  //   var box = Hive.box('colors');
  //   return box.get('color2');
  // }
  //
  // void SetColor2(String cep) {
  //   var box = Hive.box('colors');
  //   box.put('color2', cep);
  // }
  //
  // String GetColorButton1() {
  //   var box = Hive.box('colorsButton');
  //   return box.get('colorButton1');
  // }
  //
  // void SetColorButton1(String cep) {
  //   var box = Hive.box('colorsButton');
  //   box.put('colorButton1', cep);
  // }
  //
  // String GetColorButton2() {
  //   var box = Hive.box('colorsButton');
  //   return box.get('colorButton2');
  // }
  //
  // void SetColorButton2(String cep) {
  //   var box = Hive.box('colorsButton');
  //   box.put('colorButton2', cep);
  // }

// _testHive() async {
//   //await Hive.initFlutter();
//   var box = Hive.box('myBox');
//   box.put('name', 'David');
//   var name = box.get('name');
//   print('Name: $name');
// }

}