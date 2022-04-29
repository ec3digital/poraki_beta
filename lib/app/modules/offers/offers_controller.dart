import 'package:get/get.dart';
import 'package:poraki/app/data/models/oferta.dart';
import '../../data/models/produto_oferta.dart';
import '../../data/repositories/offer_repository.dart';

class OffersController extends GetxController {
  OfferRepository offerRepository = OfferRepository();
  List<ProdutoOferta> offers = [];
  Oferta? oferta;
  String? cep;
  String? category;
  String? title;
  String? listName;
  //String? ofertaGuid;
  int limit = 24;

  OffersController();

  // final TextEditingController searchProductController = TextEditingController();
  bool isLoading = false;

  @override
  void onInit() async {
    print('offers controller onInit');
    if(!Get.arguments.isBlank)
      {
        this.listName = Get.arguments[0]['listName'];
        this.limit = Get.arguments[1]['limit'];
        this.category = Get.arguments[2]['category'];
        this.title = Get.arguments[3]['title'];
        //this.ofertaGuid = Get.arguments[4]['ofertaGuid'];

        //print('ofertaGuid onInit: ' + this.ofertaGuid.toString());

        // if (this.ofertaGuid != null) {
        //   await getOfferByGuid(this.ofertaGuid);
        //
        // }
        // else
        if (this.listName != null) {
          if (this.listName == 'dayoffers') await getDayOffers(limit);

          if (this.listName == 'bestoffers') await getBestOffers(limit);

          if (this.listName == 'freshoffers') await getMostFreshOffers(limit);

          if (this.listName == 'bestsellers') await getBestSellerOffers(limit);
        }
        else {
          if (this.category == null && this.title == null &&
              this.listName == null) {
            await getOffers(24);
          }

          if (this.category == null && this.title == null &&
              this.listName == null) {
            await getDayOfferByCEP(24);
          }

          if (this.category != null && this.title == null &&
              this.listName == null) {
            await getOfferByCEPCategory(this.category!);
          }

          if (this.category == null && this.title == null &&
              this.listName == null) {
            await getOfferByCEPCategoryTitle(this.category!, this.title!);
          }

          if (this.category == null && this.title != null &&
              this.listName == null) {
            await getOfferByCEPTitle(this.title!);
          }
        }
      }


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
    } catch (e) {
      print('Erro no getOfferByCEPCategoryTitle() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getOfferByCEPTitle(String title) async {
    try {
      changeLoading(true);
      print('entrou no getOfferByCEPTitle');
      offers = await offerRepository.getOfferByCEPTitle(title);
    } catch (e) {
      print('Erro no getOfferByCEPTitle() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getBestOffers(int limit) async {
    try {
      changeLoading(true);
      print('entrou no getOfferByCEPTitle');
      offers = await offerRepository.getBestOffers(limit);
    } catch (e) {
      print('Erro no getOfferByCEPTitle() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getBestSellerOffers(int limit) async {
    try {
      changeLoading(true);
      print('entrou no getBestSellerOffers');
      offers = await offerRepository.getBestSellersOffers(limit);
    } catch (e) {
      print('Erro no getBestSellerOffers() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getDayOffers(int limit) async {
    try {
      changeLoading(true);
      print('entrou no getDayOffers');
      offers = await offerRepository.getDayOfferByCEP(limit);
    } catch (e) {
      print('Erro no getDayOffers() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getMostFreshOffers(int limit) async {
    try {
      changeLoading(true);
      print('entrou no getMostFreshOffers');
      offers = await offerRepository.getMostFreshOffers(limit);
    } catch (e) {
      print('Erro no getMostFreshOffers() controller ${e.toString()}');
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


  Future<void> getOfferById(int ofertaId) async {
    try {
      changeLoading(true);
      print('entrou no getOfferById');
      offers = await offerRepository.getOfferByGuidFromApi(ofertaId.toString());
    } catch (e) {
      print('Erro no getOfferById() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }
}
