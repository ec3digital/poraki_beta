import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import '../models/lojas.dart';

class StoreRepository extends GetConnect {
  LoginController _loginController = Get.find();

  Future<List<Lojas>> getAllStores(String usuguid) async {
    return _loginController.listLojas;
  }

  Future<Lojas> getStore(String guid) async {
    return _loginController.listLojas.where((loja) => loja.LojaGUID == guid).first;
  }

  Future<String> postStore(Lojas loja) async {
    var retAdd = await _loginController.fbInstance!.collection("akilojas").doc(_loginController.usuGuid).collection("Lojas").add(loja.toJson());
    return retAdd.id;
  }

  Future<String> putStore(Lojas loja) async {
    String getId = '';
    await _loginController.fbInstance!.collection("akilojas").doc(_loginController.usuGuid).collection("Lojas").where('LojaGUID', isEqualTo: loja.LojaGUID).get().then((ss) => getId = ss.docs.first.id);
    await _loginController.fbInstance!.collection("akilojas").doc(_loginController.usuGuid).collection("Lojas").doc(getId).set(loja.toJson());

    return getId;
  }

  Future<void> deleteStore(Lojas loja) async {
    String getId = '';
    await _loginController.fbInstance!.collection("akilojas").doc(_loginController.usuGuid).collection("Lojas").where('LojaGUID', isEqualTo: loja.LojaGUID).get().then((ss) => getId = ss.docs.first.id);
    await _loginController.fbInstance!.collection("akilojas").doc(_loginController.usuGuid).collection("Lojas").doc(getId).delete();
  }
}
