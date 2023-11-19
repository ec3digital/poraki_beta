import 'package:get/get.dart';
import 'package:poraki/app/data/models/oferta.dart';
import 'package:poraki/app/data/models/ofertafav.dart';
import 'package:poraki/app/data/models/produto_oferta.dart';
import 'package:poraki/app/data/repositories/offerfav_repository.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/offers/offers_controller.dart';

class OffersFavController extends GetxController {
  var offerfavRepo = new OfferfavRepository();
  final LoginController _loginController = Get.find();
  //final OffersController _offersController = Get.find();
  //List<OfertasFavs>? ofertasfavs;
  bool isLoading = false;

  @override
  void onInit() async {
    await getAll();
    super.onInit();
  }

  Future<void> getAll() async {
    // try {
    //   changeLoading(true);
    //   _loginController.ofertasFavs = await offerfavRepo.getAll();
    //
    //   // if(_loginController.ofertasFavs == null)
    //   //   _loginController.ofertasFavs = List.generate(1, (index) => new OfertasFavs('', ''));
    //
    //   print('qt ofertasfavs: ' + _loginController.ofertasFavs.length.toString());
    // } catch (e) {
    //   print('Erro no getAll() controller ${e.toString()}');
    // } finally {
    //   changeLoading(false);
    // }
  }

  Future<void> addObj(String ofertafavguid, OffersController offersController) async {
    var oFav = new OfertasFavs(ofertafavguid, _loginController.usuGuid, false, true);
    await offerfavRepo.postObj(oFav).then((value) => offersController.getOffersFavsByUser(_loginController.qtyOfertas));

    _loginController.favoffersguids!.add(ofertafavguid);
    // _loginController.update();

  }

  // void addObj(OfertasFavs ofertafav) {
  //   try {
  //     if(_loginController.ofertasFavs.where((ofav) => ofav.OfertaGUID == ofertafav.OfertaGUID).isNotEmpty) {
  //       var oFav = new OfertasFavs(ofertafav.OfertaGUID, ofertafav.usuGUID, true, false);
  //       _loginController.ofertasFavs.add(oFav);
  //     }
  //       //offerfavRepo.postObj(_loginController.ofertasFavs.where((ofav) => ofav.OfertaGUID == ofertafav.OfertaGUID).first);
  //   } catch (e) {
  //     print('Erro no addObj() controller ${e.toString()}');
  //   } finally {
  //     changeLoading(false);
  //   }
  // }

  // void removeObj(ProdutoOferta ofertafav) {
  //   _loginController.ofertasFavs.remove(ofertafav);
  // }

  Future<void> removeObj(String ofertafavguid, OffersController offersController) async {
    try {
        var oFav = new OfertasFavs(ofertafavguid, _loginController.usuGuid, false, true);
        await offerfavRepo.deleteObj(oFav).then((value) => offersController.getOffersFavsByUser(_loginController.qtyOfertas));

        _loginController.favoffersguids!.remove(ofertafavguid);
        // _loginController.update();
    } catch (e) {
      print('Erro no removeObj() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> addObjApi(OfertasFavs ofertafav) async {
    try {
      changeLoading(true);
      await offerfavRepo.postObj(ofertafav);
    } catch (e) {
      print('Erro no addObj() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> removeObjApi(OfertasFavs ofertafav) async {
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