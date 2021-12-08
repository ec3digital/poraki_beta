import 'package:get/get.dart';
import '../../data/models/produto_oferta.dart';
import '../../data/repositories/offer_repository.dart';

class OffersController extends GetxController {
  OfferRepository offerRepository = OfferRepository();
  List<ProdutoOferta> offers = [];
  String? cep;
  String? category;
  String? title;
  int? offerId;

  OffersController();

  // final TextEditingController searchProductController = TextEditingController();
  bool isLoading = false;

  @override
  void onInit() async {
    print('offers onInit');
    this.cep = Get.arguments[0]['cep'];
    this.category = Get.arguments[1]['category'];
    this.title = Get.arguments[2]['title'];
    this.offerId = Get.arguments[0]['id'];


    //print('offers onInit - cep: ' + this.cep.toString());
    //print('offers onInit - title: ' + this.title.toString());
    print('offers onInit - offerId: ' + this.offerId.toString());

      if(this.cep == null && this.category == null && this.title == null && this.offerId == null) {
        await getOffers();
      }

      if(this.cep != null && this.category == null && this.title == null && this.offerId == null) {
        await getDayOfferByCEP(this.cep!);
      }

      if(this.cep != null && this.category != null && this.title == null && this.offerId == null) {
        await getOfferByCEPCategory(this.cep!, this.category!);
      }

      if(this.cep == null && this.category == null && this.title == null && this.offerId == null) {
        await getOfferByCEPCategoryTitle(this.cep!, this.category!, this.title!);
      }

    if(this.cep != null && this.category == null && this.title != null && this.offerId == null) {
      await getOfferByCEPTitle(this.cep!, this.title!);
    }

    if(this.offerId != null) {
      await getOfferById(this.offerId!);
    }

    super.onInit();
  }

  @override
  void onClose() {
    // searchProductController.dispose();
    super.onClose();
  }

  Future<void> getOffers() async {
    try {
      changeLoading(true);
      offers = await offerRepository.getOffersAll();
    } catch (e) {
      print('Erro no getOffers() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getDayOfferByCEP(String cep) async {
    try {
      changeLoading(true);
      offers = await offerRepository.getDayOfferByCEP(cep);
    } catch (e) {
      print('Erro no getDayOfferByCEP() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getOfferByCEPCategory(String cep, String category) async {
    try {
      changeLoading(true);
      print('entrou no getOfferByCEPCategory');
      offers = await offerRepository.getOfferByCEPCategory(cep, category);
    } catch (e) {
      print('Erro no getOfferByCEPCategory() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getOfferByCEPCategoryTitle(String cep, String title, String category) async {
    try {
      changeLoading(true);
      print('entrou no getOfferByCEPCategoryTitle');
      offers = await offerRepository.getOfferByCEPCategoryTitle(cep, title, category);
    } catch (e) {
      print('Erro no getOfferByCEPCategoryTitle() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getOfferByCEPTitle(String cep, String title) async {
    try {
      changeLoading(true);
      print('entrou no getOfferByCEPTitle');
      offers = await offerRepository.getOfferByCEPTitle(cep, title);
    } catch (e) {
      print('Erro no getOfferByCEPTitle() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getOfferById(int ofertaId) async {
    try {
      changeLoading(true);
      print('entrou no getOfferById');
      offers = await offerRepository.getOfferById(ofertaId);
    } catch (e) {
      print('Erro no getOfferById() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  void changeLoading(bool newValue) {
    isLoading = newValue;
    update();
  }
}
