
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/revendas.dart';
import 'package:poraki/app/data/repositories/brands_repository.dart';

import '../auth/login/login_controller.dart';

class BrandsController extends GetxController {
  List<Revendas> revendas = [];
  //late var revendas;
  bool isLoading = false;

  @override
  void onInit() async {
    await getAllBrands();
    super.onInit();
  }

  Future<void> getAllBrands() async {
    LoginController _login = Get.find();
    final FirebaseFirestore? fbInstance = _login.fbInstance;

    isLoading = true;
    await fbInstance!.collection("akirevendas").doc("WY8Min9Tn7phgZV11n0V").get().then((value) {
      value.data()!.values.toList().forEach((element) { List<dynamic> lista = element; lista.sort(); lista.forEach((ee) { revendas.add(new Revendas(ee.toString(), ee.toString())); });  });
    });
    isLoading = false;

    // try {
    //   changeLoading(true);
    //   var brandsRepository = new BrandsRepository();
    //   revendas = await brandsRepository.getAllBrands();
    //   print('qt revendas: ' + revendas!.length.toString());
    // } catch (e) {
    //   print('Erro no getAllBrands() controller ${e.toString()}');
    // } finally {
    //   changeLoading(false);
    // }
  }

  void changeLoading(bool newValue) {
    isLoading = newValue;
    update();
  }
}