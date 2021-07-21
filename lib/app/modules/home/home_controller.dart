import 'package:get/get.dart';
import 'package:poraki/app/data/models/categorias.dart';
import 'package:poraki/app/data/models/ofertas.dart';
import 'package:poraki/app/data/models/pessoas.dart';
import 'package:poraki/app/data/repositories/categories_repository.dart';
import 'package:poraki/app/data/repositories/offer_repository.dart';
import 'package:poraki/app/data/repositories/people_repository.dart';

class HomeController extends GetxController {
  OfferRepository offerRepository = OfferRepository();
  CategoriesRepository categoriesRepository = CategoriesRepository();
  PeopleRepository peopleRepository = PeopleRepository();

  Ofertas? offerToday;
  List<Categorias>? categorias;
  List<Pessoas>? pessoas;

  bool isLoading = false;

  @override
  void onInit() async {
    await getOffers();
    await getCategories();
    await getPeople();
    super.onInit();
  }

  List<String> listBanners = [
    'https://cdn.pixabay.com/photo/2016/11/29/12/30/phone-1869510_960_720.jpg',
    'https://cdn.pixabay.com/photo/2015/02/07/20/58/tv-627876_960_720.jpg',
  ];

  Future<void> getOffers() async {
    try {
      changeLoading(true);
      List<Ofertas> ofertas = await offerRepository.getOffersAll();
      offerToday = ofertas[0];
    } catch (e) {
      print('Erro no getOffers() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getCategories() async {
    try {
      changeLoading(true);
      categorias = await categoriesRepository.getAllCategories();
    } catch (e) {
      print('Erro no getOffers() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getPeople() async {
    try {
      changeLoading(true);
      pessoas = await peopleRepository.getAllPeople();
    } catch (e) {
      print('Erro no getOffers() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  void changeLoading(bool newValue) {
    isLoading = newValue;
    update();
  }
}
