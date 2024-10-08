import 'package:get/get.dart';
import 'package:poraki/app/data/models/ofertafav.dart';
import 'package:poraki/app/data/repositories/offerfav_repository.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/offers/offers_controller.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class OffersFavController extends GetxController {
  var offerfavRepo = new OfferfavRepository();
  final LoginController _loginController = Get.find();
  bool isLoading = false;

  @override
  void onInit() async {
    super.onInit();
  }

  Future<void> addObj(String ofertafavguid, OffersController offersController) async {
    var oFav = new OfertasFavs(ofertafavguid, _loginController.usuGuid, false, true);
    await offerfavRepo.postObj(oFav).then((value) => offersController.getOffersFavsByUser(_loginController.qtyOfertas));

    _loginController.favoffersguids!.add(ofertafavguid);
  }

  Future<void> removeObj(String ofertafavguid, OffersController offersController) async {
    try {
        var oFav = new OfertasFavs(ofertafavguid, _loginController.usuGuid, false, true);
        await offerfavRepo.deleteObj(oFav).then((value) => offersController.getOffersFavsByUser(_loginController.qtyOfertas));

        _loginController.favoffersguids!.remove(ofertafavguid);
        // _loginController.update();
    } catch (e, stackTrace) {
      changeLoading(false);
      FirebaseCrashlytics.instance.recordError(
          'Erro no removeObj() controller ${e.toString()}', stackTrace);
    } finally {
      changeLoading(false);
    }
  }

  Future<void> addObjApi(OfertasFavs ofertafav) async {
    try {
      changeLoading(true);
      await offerfavRepo.postObj(ofertafav);
    } catch (e, stackTrace) {
      changeLoading(false);
      FirebaseCrashlytics.instance.recordError(
          'Erro no addObjApi() controller ${e.toString()}', stackTrace);
    } finally {
      changeLoading(false);
    }
  }

  Future<void> removeObjApi(OfertasFavs ofertafav) async {
    try {
      changeLoading(true);
      await offerfavRepo.deleteObj(ofertafav);
    } catch (e, stackTrace) {
      changeLoading(false);
      FirebaseCrashlytics.instance.recordError(
          'Erro no removeObjApi() controller ${e.toString()}', stackTrace);
    } finally {
      changeLoading(false);
    }
  }

  void changeLoading(bool newValue) {
    isLoading = newValue;
    update();
  }
}