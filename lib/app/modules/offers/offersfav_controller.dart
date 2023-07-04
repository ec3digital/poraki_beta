import 'package:get/get.dart';
import 'package:poraki/app/data/models/oferta.dart';
import 'package:poraki/app/data/models/ofertafav.dart';
import 'package:poraki/app/data/models/produto_oferta.dart';
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

  void addObj(ProdutoOferta ofertafav) {
    _loginController.ofertasFavs.add(ofertafav);
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

  void removeObj(ProdutoOferta ofertafav) {
    _loginController.ofertasFavs.remove(ofertafav);
  }

  // void removeObj(OfertasFavs ofertafav) {
  //   try {
  //     if(_loginController.ofertasFavs.where((ofav) => ofav.OfertaGUID == ofertafav.OfertaGUID).isNotEmpty) {
  //       var oFav = new OfertasFavs(ofertafav.OfertaGUID, ofertafav.usuGUID, false, true);
  //       _loginController.ofertasFavs.remove(oFav);
  //     }
  //       //offerfavRepo.deleteObj(_loginController.ofertasFavs.where((ofav) => ofav.OfertaGUID == ofertafav.OfertaGUID).first);
  //   } catch (e) {
  //     print('Erro no removeObj() controller ${e.toString()}');
  //   } finally {
  //     changeLoading(false);
  //   }
  // }

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