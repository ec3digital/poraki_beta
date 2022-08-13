import 'package:get/get.dart';
import 'package:poraki/app/data/models/parceiros.dart';
import 'package:poraki/app/data/repositories/partner_repository.dart';

class PartnersController extends GetxController {
  List<Parceiros>? parceiros;
  bool isLoading = false;

  @override
  void onInit() async {
    await getAll();
    super.onInit();
  }

  Future<void> getAll() async {
    try {
      changeLoading(true);
      var partnersRepository = new PartnerRepository();
      parceiros = await partnersRepository.getAll();
      print('qt parceiros: ' + parceiros!.length.toString());
    } catch (e) {
      print('Erro no getAll() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  void changeLoading(bool newValue) {
    isLoading = newValue;
    update();
  }
}