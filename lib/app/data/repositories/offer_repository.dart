import 'package:get/get.dart';
import 'package:poraki/app/data/models/oferta.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import '../models/produto_oferta.dart';
import '../../shared/constants/constants.dart';

class OfferRepository extends GetConnect {

  LoginController _loginController = Get.find();
  late List<Oferta> listOffers = [];

  Future<List<ProdutoOferta>> getOffersAll() async {
    String url = '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiOfertas').first.coreValor.toString()}/' + _loginController.usuCep.toString();
    var response = await get(url, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em getOffersAll()';
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  Future<List<ProdutoOferta>> getDayOfferByCEP() async {
    String url = '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiOfertas').first.coreValor.toString()}/' + _loginController.usuCep.toString();
    var response = await get(url, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em getDayOfferByCEP()';
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  Future<List<ProdutoOferta>> getOfferByCEPCategory(String category) async {
    String url = '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiOfertasCategoria').first.coreValor.toString()}/' + _loginController.usuCep.toString() + '/' + category;
    var response = await get(url, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em getOfferByCEPCategory()';
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  Future<List<ProdutoOferta>> getOfferByCEPCategoryTitle(String title, String category) async {
    String url = '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiOfertasCategoriaTitulo').first.coreValor.toString()}/' + _loginController.usuCep.toString() + '/' + category + '/' + title;
    var response = await get(url, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em getOfferByCEPCategoryTitle()';
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  Future<List<ProdutoOferta>> getOfferByCEPTitle(String title) async {
    String url = '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiOfertasTitulo').first.coreValor.toString()}/' + _loginController.usuCep.toString();
    var response = await get(url, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em getOfferByCEPTitle() - '; // + response.bodyString.toString();
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

  Future<List<ProdutoOferta>> getBestOffers() async {
    String url = '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiMelhoresOfertas').first.coreValor.toString()}/' + _loginController.usuCep.toString();
    var response = await get(url, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em getBestOffers()';
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  Future<List<ProdutoOferta>> getBestSellersOffers() async {
    String url = '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiOfertasMaisVendidas').first.coreValor.toString()}/' + _loginController.usuCep.toString();
    var response = await get(url, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em getBestSellersOffers()';
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  Future<List<ProdutoOferta>> getMostFreshOffers() async {
    String url = '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiOfertasMaisFrescas').first.coreValor.toString()}/' + _loginController.usuCep.toString();
    var response = await get(url, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em getMostFreshOffers()';
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  Future<List<Oferta>> getOfferBySellerGuid(String SellerGuid) async {
    String url = '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiMoffer').first.coreValor.toString()}/' + SellerGuid;
    var response = await get(url, headers: Constants.headers);
    //print(response.body.toString());
    if (response.hasError) throw 'Ocorreu um erro em getOfferBySellerGuid()';
    listOffers = (response.body['Ofertas'] as List)
        .map((oferta) => Oferta.fromJson(oferta))
        .toList();
    return listOffers;
  }

  Oferta getOfferByGuid(String offerGuid) {
    return listOffers.where((oferta) => oferta.OfertaGUID == offerGuid).first;
  }

}
