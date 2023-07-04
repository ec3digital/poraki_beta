import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
//import 'package:poraki/app/data/models/ofertafav.dart';
import 'package:poraki/app/data/repositories/offerfav_repository.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
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
  // List<Categorias>? categorias;
  bool isLoading = false;

  // List<Pessoas>? pessoas;

  @override
  void onInit() async {
    // await getCategories();
    // mostra as 4 ofertas de cada seção; esses valores sao passados para a API, evitando trazer dados desnecessários
    await getOffers(4);
    await getBestOffers(4);
    await getMostFreshOffers(4);
    await getBestSellersOffers(4);

    // await getPeople();

    super.onInit();
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
      LoginController _loginController = Get.find();
      _loginController.ofertasFavs = bestoffers!;
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
  //
  // Future<void> getCategories() async {
  //   FirebaseFirestore? _fbInstance;
  //   if (Firebase.apps.isEmpty) {
  //     await Firebase.initializeApp();
  //   }
  //
  //   _fbInstance = FirebaseFirestore.instance;
  //
  //   await _fbInstance.collection("akicategs").doc("Categorias").collection("lista").get().then((value) => value.docs.forEach((element) { categorias!.add(Categorias.fromJson(element.data())); }));
  // }

  // Future<void> getAddresses() async {
  //   try {
  //     changeLoading(true);
  //     enderecos = await AddressRepository().getAllAddresses();
  //     // categorias?.forEach((element) { print(element);});
  //   } catch (e) {
  //     print('Erro no getCategories() controller ${e.toString()}');
  //   } finally {
  //     changeLoading(false);
  //   }
  // }


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
