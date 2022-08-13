
import 'package:get/get.dart';
import 'package:poraki/app/data/models/revendas.dart';
import 'package:poraki/app/data/repositories/brands_repository.dart';

class BrandsController extends GetxController {
  List<Revendas>? revendas;
  bool isLoading = false;

  @override
  void onInit() async {
    await getAllBrands();
    super.onInit();
  }

  Future<void> getAllBrands() async {
    try {
      changeLoading(true);
      var brandsRepository = new BrandsRepository();
      revendas = await brandsRepository.getAllBrands();
      print('qt revendas: ' + revendas!.length.toString());
    } catch (e) {
      print('Erro no getAllBrands() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  void changeLoading(bool newValue) {
    isLoading = newValue;
    update();
  }
}