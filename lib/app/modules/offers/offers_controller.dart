import 'package:get/get.dart';
import 'package:poraki/app/data/models/oferta.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import '../../data/models/produto_oferta.dart';
import '../../data/repositories/offer_repository.dart';

class OffersController extends GetxController {
  OfferRepository offerRepository = OfferRepository();
  final LoginController _loginController = Get.find();
  List<ProdutoOferta> offers = [];
  Oferta? oferta;
  String? cep;
  String? category;
  String? title;
  String? listName;
  String? storeId;
  String? fkId;
  //String? ofertaGuid;
  // int limit = 24;

  OffersController();

  // final TextEditingController searchProductController = TextEditingController();
  bool isLoading = false;

  Future<void> loadOffers() async {
    if(Get.arguments != null)
    {
      this.listName = Get.arguments[0]['listName'];
      // this.limit = Get.arguments[1]['limit'];
      this.category = Get.arguments[2]['category'];
      this.title = Get.arguments[3]['title'];
      this.storeId = Get.arguments[4]['storeId'];
      this.fkId = Get.arguments[5]['fkId'];

      print('ln: ' + this.listName.toString() + ' / l: ' + ' / c: ' + this.category.toString() + ' / t: ' + this.title.toString());

      print(Get.arguments.toString());

      //this.ofertaGuid = Get.arguments[4]['ofertaGuid'];

      //print('ofertaGuid onInit: ' + this.ofertaGuid.toString());

      // if (this.ofertaGuid != null) {
      //   await getOfferByGuid(this.ofertaGuid);
      //
      // }
      // else

      if (this.title != null) print("busca: " + this.title.toString());

      if (this.listName != null) {
        print('offers listName: ' + this.listName.toString());
        if (this.listName == 'offers1') await getOffers1(_loginController.qtyOfertas);

        if (this.listName == 'offers2') await getOffers2(_loginController.qtyOfertas);

        if (this.listName == 'offers3') await getOffers3(_loginController.qtyOfertas);

        if (this.listName == 'offers4') await getOffers4(_loginController.qtyOfertas);

        if (this.listName == 'favsoffers') await getOffersFavsByUser(_loginController.qtyOfertas); // getBestSellerOffers(limit);
      }
      else {
        if (this.category == null && this.title == null &&
            this.listName == null && this.storeId == null && this.fkId == null) {
          await getOffers(_loginController.qtyOfertas);
        }

        if (this.category == null && this.title == null &&
            this.listName == null && this.storeId == null && this.fkId == null) {
          await getDayOfferByCEP(_loginController.qtyOfertas);
        }

        if (this.category != null && this.title == null &&
            this.listName == null && this.storeId == null && this.fkId == null) {
          //await getOfferByCEPCategory(this.category!);
        }

        if (this.category == null && this.title == null &&
            this.listName == null && this.storeId == null && this.fkId == null) {
          await getOfferByCEPCategoryTitle(this.category!, this.title!);
        }

        if (this.category == null && this.title != null &&
            this.listName == null && this.storeId == null && this.fkId == null) {
          await getOfferByCEPTitle(this.title!);
        }

        if (this.category == null && this.title == null &&
            this.listName == null && this.storeId != null && this.fkId == null) {
          await getOffersByStore(this.storeId!);
        }

        if (this.category == null && this.title == null &&
            this.listName == null && this.storeId == null && this.fkId != null) {
          await getOffersBySeller(this.fkId!);
        }

      }
    }
    this.refresh();

  }

  @override
  void onInit() async {
    print('offers controller onInit');
    // await loadOffers();

    super.onInit();
  }

  @override
  void onClose() {
    // searchProductController.dispose();
    super.onClose();
  }

  void changeLoading(bool newValue) {
    isLoading = newValue;
    update();
  }

  Future<void> getOffers(int limit) async {
    try {
      changeLoading(true);
      offers = await offerRepository.getOffersAll(limit);
      this.refresh();
    } catch (e) {
      print('Erro no getOffers() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getDayOfferByCEP(int limit) async {
    try {
      changeLoading(true);
      offers = await offerRepository.getDayOfferByCEP(limit);
      this.refresh();
    } catch (e) {
      print('Erro no getDayOfferByCEP() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getOfferByCEPCategory(String category) async {
    try {
      changeLoading(true);
      print('entrou no getOfferByCEPCategory');
      offers = await offerRepository.getOfferByCEPCategory(category);
      this.refresh();
    } catch (e) {
      print('Erro no getOfferByCEPCategory() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getOfferByCEPCategoryTitle(String title, String category) async {
    try {
      changeLoading(true);
      print('entrou no getOfferByCEPCategoryTitle');
      offers =
          await offerRepository.getOfferByCEPCategoryTitle(title, category);
      this.refresh();
    } catch (e) {
      print('Erro no getOfferByCEPCategoryTitle() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getOfferByCEPTitle(String title) async {
    try {
      changeLoading(true);
      print('entrou no getOfferByCEPTitle: ' + title);
      offers = await offerRepository.getOfferByCEPTitle(title);
      this.refresh();
    } catch (e) {
      print('Erro no getOfferByCEPTitle() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getOffers1(int limit) async {
    try {
      changeLoading(true);
      print('entrou no getOffers1');
      offers = await offerRepository.getDayOfferByCEP(limit);
      this.refresh();
    } catch (e) {
      print('Erro no getOffers1() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getOffers2(int limit) async {
    try {
      changeLoading(true);
      print('entrou no getOfferByCEPTitle');
      offers = await offerRepository.getOffers2(limit);
      this.refresh();
    } catch (e) {
      print('Erro no getOfferByCEPTitle() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getOffers3(int limit) async {
    try {
      changeLoading(true);
      print('entrou no getOffers3');
      offers = await offerRepository.getOffers3(limit);
      this.refresh();
    } catch (e) {
      print('Erro no getOffers3() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getOffers4(int limit) async {
    try {
      changeLoading(true);
      print('entrou no getBestSellerOffers');
      offers = await offerRepository.getOffers4(limit);
      this.refresh();
    } catch (e) {
      print('Erro no getOffers4() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  // Future<void> getOfferByGuid(String? offerGuid) async {
  //   try {
  //     changeLoading(true);
  //     print('entrou no getOfferByGuid');
  //     oferta = await offerRepository.getOfferByGuidFromApi(offerGuid.toString());
  //   } catch (e) {
  //     print('Erro no getOfferByGuid() controller ${e.toString()}');
  //   } finally {
  //     changeLoading(false);
  //   }
  // }

  Future<void> getOffersBySeller(String sellerId) async {
    try {
      changeLoading(true);
      print('entrou no getOffersBySeller');
      offers = await offerRepository.getOffersBySeller(sellerId);
      this.refresh();
    } catch (e) {
      print('Erro no getOffersBySeller() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getOffersByStore(String storeId) async {
    try {
      changeLoading(true);
      print('entrou no getOffersByStore');
      offers = await offerRepository.getOfferByStoreGuid(storeId);
      this.refresh();
    } catch (e) {
      print('Erro no getOffersByStore() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getOffersFavsByUser(int qtyOfertas) async {
    try {
      changeLoading(true);
      print('entrou no getOffersFavsByUser');
      // LoginController _loginController = Get.find();
      offers = await offerRepository.getFavsOffers();
      this.refresh();
    } catch (e) {
      print('Erro no getOffersFavsByUser() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  // Future<void> getOffersFavsFromMemory() async {
  //   LoginController _loginController = Get.find();
  //   offers = _loginController.ofertasFavs;
  // }

  Future<void> getOfferById(int ofertaId) async {
    try {
      changeLoading(true);
      print('entrou no getOfferById');
      offers = await offerRepository.getOfferByGuidFromApi(ofertaId.toString());
      this.refresh();
    } catch (e) {
      print('Erro no getOfferById() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

}
