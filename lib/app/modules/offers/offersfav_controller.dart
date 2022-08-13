import 'package:get/get.dart';
import 'package:poraki/app/data/models/ofertafav.dart';
import 'package:poraki/app/data/repositories/offerfav_repository.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';

class OffersFavController extends GetxController {
  var offerfavRepo = new OfferfavRepository();
  final LoginController _loginController = Get.find();
  //List<OfertasFavs>? ofertasfavs;
  bool isLoading = false;

  @override
  void onInit() async {
    await getAll();
    super.onInit();
  }

  Future<void> getAll() async {
    try {
      changeLoading(true);
      _loginController.ofertasFavs = await offerfavRepo.getAll();
      if(_loginController.ofertasFavs == null)
        _loginController.ofertasFavs = List.generate(1, (index) => new OfertasFavs('', ''));

      print('qt ofertasfavs: ' + _loginController.ofertasFavs.length.toString());
    } catch (e) {
      print('Erro no getAll() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> addObj(OfertasFavs ofertafav) async {
    try {
      changeLoading(true);
      await offerfavRepo.postObj(ofertafav);
    } catch (e) {
      print('Erro no addObj() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> removeObj(OfertasFavs ofertafav) async {
    try {
      changeLoading(true);
      await offerfavRepo.deleteObj(ofertafav);
    } catch (e) {
      print('Erro no removeObj() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  void changeLoading(bool newValue) {
    isLoading = newValue;
    update();
  }
}