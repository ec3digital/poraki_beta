import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/services/fbporaki_service.dart';
import '../../data/models/categorias.dart';
import '../../data/models/produto_oferta.dart';
import '../../data/repositories/categories_repository.dart';
import '../../data/repositories/offer_repository.dart';

class HomeController extends GetxController {

  OfferRepository offerRepository = OfferRepository();
  CategoriesRepository categoriesRepository = CategoriesRepository();
  // PeopleRepository peopleRepository = PeopleRepository();

  List<ProdutoOferta>? offersToday = [];
  List<ProdutoOferta>? bestoffers = [];
  List<ProdutoOferta>? mostfresheroffers = [];
  List<ProdutoOferta>? bestselleroffers = [];
  List<Categorias>? categorias;
  // List<Pessoas>? pessoas;

  bool isLoading = false;

  @override
  void onInit() async {
    await getCategories();
    // mostra as 4 ofertas de cada seção; esses valores sao passados para a API, evitando trazer dados desnecessários
    await getOffers(4);
    await getBestOffers(4);
    await getMostFreshOffers(4);
    await getBestSellersOffers(4);
    // await getPeople();
    await getListBannersFromFBCloud();
    super.onInit();
  }

  //TODO: pegar os banners do firebase
  List<String> listBanners = [
    'http://poraki-assets.ec3.digital/wp-content/uploads/2021/11/PORAKI-Banner-sm_default1.jpg',
  ];

  Future<void> getListBannersFromFBCloud() async {
    LoginController loginController = Get.find();

    var tempBannersApp = await fbPorakiService().getListFromFirebase("akibanners", "core");
    tempBannersApp.forEach((key, value) {
      print('banner: ' + value);
      listBanners.add(value);
    });
    var tempBannersCep = await fbPorakiService().getListFromFirebase("akibanners", loginController.usuCep!.substring(0, 3));
    tempBannersCep.forEach((key, value) {
      listBanners.add(value);
    });
  }

  Future<void> getOffers(int limit) async {
    try {
      changeLoading(true);
      offersToday = await offerRepository.getDayOfferByCEP(limit);
    } catch (e) {
      print('Erro no getOffers() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getBestOffers(int limit) async {
    try {
      changeLoading(true);
      bestoffers = await offerRepository.getBestOffers(limit);
    } catch (e) {
      print('Erro no getBestOffers() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getMostFreshOffers(int limit) async {
    try {
      changeLoading(true);
      mostfresheroffers = await offerRepository.getMostFreshOffers(limit);
    } catch (e) {
      print('Erro no getMostFreshOffers() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getBestSellersOffers(int limit) async {
    try {
      changeLoading(true);
      bestselleroffers = await offerRepository.getBestSellersOffers(limit);
    } catch (e) {
      print('Erro no getBestSellersOffers() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getCategories() async {
    try {
      changeLoading(true);
      categorias = await categoriesRepository.getCategoriesBarra();
      // categorias?.forEach((element) { print(element);});
    } catch (e) {
      print('Erro no getCategories() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  // Future<void> getPeople() async {
  //   try {
  //     changeLoading(true);
  //     pessoas = await peopleRepository.getAllPeople();
  //   } catch (e) {
  //     print('Erro no getPeople() controller ${e.toString()}');
  //   } finally {
  //     changeLoading(false);
  //   }
  // }

  void changeLoading(bool newValue) {
    isLoading = newValue;
    update();
  }


}
