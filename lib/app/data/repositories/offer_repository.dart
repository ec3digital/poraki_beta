import 'package:get/get.dart';
import 'package:poraki/app/data/models/oferta.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import '../models/produto_oferta.dart';
import '../../shared/constants/constants.dart';

class OfferRepository extends GetConnect {

  LoginController _loginController = Get.find();
  late List<Oferta> listOffers = [];

  Future<List<ProdutoOferta>> getOffersAll(int limit) async {
    String url = '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiOfertas').first.coreValor.toString()}/' + _loginController.cloudId.toString() + '%25/' + limit.toString();
    var response = await get(url, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em getOffersAll()';
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  Future<List<ProdutoOferta>> getDayOfferByCEP(int limit) async {
    String url = '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiOfertas').first.coreValor.toString()}/' + _loginController.cloudId.toString() + '%25/' + limit.toString();
    var response = await get(url, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em getDayOfferByCEP() url: $url / resp: ${response.body}';
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  Future<List<ProdutoOferta>> getOfferByCEPCategory(String category) async {
    String url = '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiOfertasCategoria').first.coreValor.toString()}/' + _loginController.cloudId.toString() + '%25/' + category;
    var response = await get(url, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em getOfferByCEPCategory()';
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  Future<List<ProdutoOferta>> getOfferByCEPCategoryTitle(String title, String category) async {
    String url = '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiOfertasCategoriaTitulo').first.coreValor.toString()}/' + _loginController.cloudId.toString() + '%25/' + category + '/' + title;
    var response = await get(url, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em getOfferByCEPCategoryTitle()';
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  Future<List<ProdutoOferta>> getOfferByCEPTitle(String title) async {
    String url = '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiOfertasTitulo').first.coreValor.toString()}/' + _loginController.cloudId.toString() + '%25';
    var response = await get(url, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em getOfferByCEPTitle() - ' + response.bodyString.toString();
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  // Future<List<ProdutoOferta>> getOfferById(int ofertaId) async {
  //   // String url = '${Constants.baseUrl}ofertasingle/' + ofertaId.toString();
  //   String url = '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiOferta').first.coreValor.toString()}/' + _loginController.usuCep.toString();
  //   var response = await get(url, headers: Constants.headers);
  //   if (response.hasError) throw 'Ocorreu um erro em getOfferById()';
  //   return (response.body['Ofertas'] as List)
  //       .map((oferta) => ProdutoOferta.fromJson(oferta))
  //       .toList();
  // }

  Future<List<ProdutoOferta>> getBestOffers(int limit) async {
    String url = '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiMelhoresOfertas').first.coreValor.toString()}/' + _loginController.cloudId.toString() + '%25/' + limit.toString();
    // print('url: ' + url);
    var response = await get(url, headers: Constants.headers);
    // print('resp bestOffers: ' + response.body.toString());
    if (response.hasError) throw 'Ocorreu um erro em getBestOffers() ' + response.body.toString();
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  Future<List<ProdutoOferta>> getBestSellersOffers(int limit) async {
    String url = '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiOfertasMaisVendidas').first.coreValor.toString()}/' + _loginController.cloudId.toString() + '%25/' + limit.toString();
    var response = await get(url, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em getBestSellersOffers()';
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  Future<List<ProdutoOferta>> getMostFreshOffers(int limit) async {
    String url = '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiOfertasMaisFrescas').first.coreValor.toString()}/' + _loginController.cloudId.toString() + '%25/' + limit.toString();
    var response = await get(url, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em getMostFreshOffers()';
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  Future<List<ProdutoOferta>> getFavsOffers(int limit) async {
    // String url = '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiMelhoresOfertas').first.coreValor.toString()}/' + _loginController.usuCep.toString().substring(0,3) + '%25/' + limit.toString();
    String url = 'https://poraki.hasura.app/api/rest/ofertasfavperuserkeys/' + _loginController.usuGuid.toString();
    var response = await get(url, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em getFavsOffers()';
    return (response.body['OfertasFavsNew'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta['OfertaFavXofertas']))
        .toList();
  }

  Future<List<ProdutoOferta>> getOffersBySeller(String SellerGuid) async {
    print('getOffersBySeller ' + SellerGuid);
    String url = '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiMoffer').first.coreValor.toString()}/' + SellerGuid;
    var response = await get(url, headers: Constants.headers);
    //print(response.body.toString());
    if (response.hasError) throw 'Ocorreu um erro em getOfferBySellerGuid()';
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  Future<List<Oferta>> getOfferBySellerGuid(String SellerGuid) async {
    print('getOfferBySellerGuid ' + SellerGuid);
    String url = '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiMoffer').first.coreValor.toString()}/' + SellerGuid;
    print('url moffer: ' + url);
    var response = await get(url, headers: Constants.headers);
    //print(response.body.toString());
    if (response.hasError) throw 'Ocorreu um erro em getOfferBySellerGuid()';

    var jsonResult = response.body['Ofertas'];
    // print(jsonResult);
    listOffers = (jsonResult as List)
        .map((oferta) => Oferta.fromJson(oferta))
        .toList();


    return listOffers;
  }

  Future<List<Oferta>> getOfferByStoreGuid(String StoreGuid) async {
    print('getOfferByStoreGuid ' + StoreGuid);
    String url = '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiMoffersStore').first.coreValor.toString()}/' + StoreGuid;
    var response = await get(url, headers: Constants.headers);
    //print(response.body.toString());
    if (response.hasError) throw 'Ocorreu um erro em getOfferByStoreGuid()';
    listOffers = (response.body['Ofertas'] as List)
        .map((oferta) => Oferta.fromJson(oferta))
        .toList();
    return listOffers;
  }

  Oferta getOfferByGuid(String offerGuid) {
    return listOffers.where((oferta) => oferta.OfertaGUID == offerGuid).first;
  }

  Future<List<ProdutoOferta>> getOfferByGuidFromApi(String offerGuid) async {
    print('getOfferByGuidFromApi');
    String url = '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiOferta').first.coreValor.toString()}/' + offerGuid;
    var response = await get(url, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em getOfferByGuidFromApi()';
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  Future<void> deleteOfferByGuidFromApi(String offerGuid) async {
    print('getOfferByGuidFromApi');
    String url = Constants.baseUrl + 'ofertainativ/' + offerGuid;
    var response = await put(url, '', headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em deleteOfferByGuidFromApi()';
    else print(response.body);
  }

}
