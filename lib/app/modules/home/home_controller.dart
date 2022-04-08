import 'package:get/get.dart';
import '../../data/models/categorias.dart';
import '../../data/models/produto_oferta.dart';
import '../../data/repositories/categories_repository.dart';
import '../../data/repositories/offer_repository.dart';

class HomeController extends GetxController {

  OfferRepository offerRepository = OfferRepository();
  CategoriesRepository categoriesRepository = CategoriesRepository();
  // PeopleRepository peopleRepository = PeopleRepository();
  String strCep = "05735030";

  ProdutoOferta? offerToday;
  ProdutoOferta? bestoffer;
  ProdutoOferta? mostfresheroffer;
  ProdutoOferta? bestselleroffer;
  List<Categorias>? categorias;
  // List<Pessoas>? pessoas;

  bool isLoading = false;

  @override
  void onInit() async {
    await getOffers(strCep);
    await getCategories();
    await getBestOffers(strCep);
    // await getMostFreshOffers(strCep);
    await getBestSellersOffers(strCep);
    // await getPeople();
    super.onInit();
  }

  //TODO: pegar os banners do firebase
  List<String> listBanners = [
    'http://poraki-assets.ec3.digital/wp-content/uploads/2021/11/PORAKI-Banner-sm_default1.jpg',
    // 'https://cdn.pixabay.com/photo/2015/02/07/20/58/tv-627876_960_720.jpg',
  ];

  Future<void> getOffers(String cep) async {
    try {
      changeLoading(true);
      List<ProdutoOferta> ofertas = await offerRepository.getDayOfferByCEP(cep);
      offerToday = ofertas.first;
      
    } catch (e) {
      print('Erro no getOffers() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getBestOffers(String cep) async {
    try {
      changeLoading(true);
      List<ProdutoOferta> ofertas = await offerRepository.getBestOffers(cep);
      bestoffer = ofertas.first;

    } catch (e) {
      print('Erro no getBestOffers() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getMostFreshOffers(String cep) async {
    try {
      changeLoading(true);
      List<ProdutoOferta> ofertas = await offerRepository.getMostFreshOffers(cep);
      mostfresheroffer = ofertas.first;

    } catch (e) {
      print('Erro no getMostFreshOffers() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getBestSellersOffers(String cep) async {
    try {
      changeLoading(true);
      List<ProdutoOferta> ofertas = await offerRepository.getBestSellersOffers(cep);
      bestselleroffer = ofertas.first;

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
