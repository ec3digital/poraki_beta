import 'package:get/get.dart';
import 'package:poraki/app/data/models/oferta.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import '../models/produto_oferta.dart';

class OfferRepository extends GetConnect {
  LoginController _loginController = Get.find();
  late List<Oferta> listOffers = [];

  Future<List<ProdutoOferta>> getOffersAll(int limit) async {
    await _loginController.getOffersApiEndpoints();
    var response = await get('${_loginController.regionBaseUrl + _loginController.apiOfertas1}/' + _loginController.cloudId.toString() + '%25/' + limit.toString(), headers: _loginController.regionHeaders);
    if (response.hasError) throw 'Ocorreu um erro em getOffersAll() / resp: ${response.body}';
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  Future<List<ProdutoOferta>> getDayOfferByCEP(int limit) async {
    await _loginController.getOffersApiEndpoints();
    var response = await get('${_loginController.regionBaseUrl + _loginController.apiOfertas1}/' + _loginController.cloudId.toString() + '%25/' + limit.toString(), headers: _loginController.regionHeaders);
    if (response.hasError) throw 'Ocorreu um erro em getDayOfferByCEP() / resp: ${response.body}';
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  Future<List<ProdutoOferta>> getOfferByCEPCategory(String category) async {
    var response = await get('${_loginController.regionBaseUrl + _loginController.apiOfertasCategoria}/' + _loginController.cloudId.toString() + '%25/' + category, headers: _loginController.regionHeaders);
    if (response.hasError) throw 'Ocorreu um erro em getOfferByCEPCategory() / resp: ${response.body}';
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  Future<List<ProdutoOferta>> getOfferByCEPCategoryTitle(String title, String category) async {
    var response = await get('${_loginController.regionBaseUrl + _loginController.apiOfertasCategoriaTitulo}/' + _loginController.cloudId.toString() + '%25/' + category + '/' + title, headers: _loginController.regionHeaders);
    if (response.hasError) throw 'Ocorreu um erro em getOfferByCEPCategoryTitle() / resp: ${response.body}';
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  Future<List<ProdutoOferta>> getOfferByCEPTitle(String title) async {
    var url = '${_loginController.regionBaseUrl + _loginController.apiOfertasTitulo}/' + _loginController.cloudId.toString() + '%25' + '/%25' + title + '%25';
    print('url: ' + url);
    var response = await get('${_loginController.regionBaseUrl + _loginController.apiOfertasTitulo}/' + _loginController.cloudId.toString() + '%25' + '/%25' + title + '%25', headers: _loginController.regionHeaders);
    if (response.hasError) throw 'Ocorreu um erro em getOfferByCEPTitle() - ' + response.bodyString.toString();
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  Future<List<ProdutoOferta>> getOffers2(int limit) async {
    await _loginController.getOffersApiEndpoints();
    var response = await get('${_loginController.regionBaseUrl + _loginController.apiOfertas2}/' + _loginController.cloudId.toString() + '%25/' + limit.toString(), headers: _loginController.regionHeaders);
    // print('resp bestOffers: ' + response.body.toString());
    if (response.hasError) throw 'Ocorreu um erro em getOffers2() ' + response.body.toString();
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  Future<List<ProdutoOferta>> getOffers4(int limit) async {
    await _loginController.getOffersApiEndpoints();
    var response = await get('${_loginController.regionBaseUrl + _loginController.apiOfertas3}/' + _loginController.cloudId.toString() + '%25/' + limit.toString(), headers: _loginController.regionHeaders);
    if (response.hasError) throw 'Ocorreu um erro em getOffers4() ' + response.body.toString();
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  Future<List<ProdutoOferta>> getOffers3(int limit) async {
    await _loginController.getOffersApiEndpoints();
    var response = await get('${_loginController.regionBaseUrl + _loginController.apiOfertas4}/' + _loginController.cloudId.toString() + '%25/' + limit.toString(), headers: _loginController.regionHeaders);
    if (response.hasError) throw 'Ocorreu um erro em getOffers3() ' + response.body.toString();
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  Future<List<ProdutoOferta>> getFavsOffers() async {
    var response = await get('${_loginController.regionBaseUrl + _loginController.apiOfertasFavPerUserKeys}/' + _loginController.usuGuid.toString(), headers: _loginController.regionHeaders);
    if (response.hasError) throw 'Ocorreu um erro em getFavsOffers() ' + response.body.toString();
    return (response.body['OfertasFavsNew'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta['OfertaFavXofertas']))
        .toList();
  }

  Future<List<Oferta>> getOffersByStore(String StoreGuid) async {
    var response = await get('${_loginController.regionBaseUrl + _loginController.apiOfertasPorLoja}/' + StoreGuid, headers: _loginController.regionHeaders);
    if (response.hasError) throw 'Ocorreu um erro em getOffersByStore() ' + response.body.toString();
    return (response.body['Ofertas'] as List)
        .map((oferta) => Oferta.fromJson(oferta))
        .toList();
  }

  Future<List<ProdutoOferta>> getOffersBySeller(String SellerGuid) async {
    var response = await get('${_loginController.regionBaseUrl + _loginController.apiMoffer}/' + SellerGuid, headers: _loginController.regionHeaders);
    if (response.hasError) throw 'Ocorreu um erro em getOffersBySeller() ' + response.body.toString();
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  Future<List<ProdutoOferta>> getOfferByStoreGuid(String StoreGuid) async {
    var response = await get('${_loginController.regionBaseUrl + _loginController.apiMoffersStore}/' + StoreGuid, headers: _loginController.regionHeaders);
    if (response.hasError) throw 'Ocorreu um erro em getOfferByStoreGuid() ' + response.body.toString();
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  Future<List<Oferta>> getOfferBySellerGuid(String SellerGuid) async {
    var response = await get('${_loginController.regionBaseUrl + _loginController.apiMoffer}/' + SellerGuid, headers: _loginController.regionHeaders);
    if (response.hasError) throw 'Ocorreu um erro em getOfferBySellerGuid() ' + response.body.toString();

    var jsonResult = response.body['Ofertas'];
    listOffers = (jsonResult as List)
        .map((oferta) => Oferta.fromJson(oferta))
        .toList();

    return listOffers;
  }

  Future<List<String>> getFavOffersGuids(String usuGuid) async {
    List<String> retOffersGuids = [];
    var response = await get('${_loginController.regionBaseUrl + _loginController.apiOfertasFavGuidsPerUser}/' + usuGuid, headers: _loginController.regionHeaders);
    if (response.hasError) throw 'Ocorreu um erro em getFavOffersGuids() ' + response.body.toString();

    var jsonResult = response.body['OfertasFavsNew'];
    print(jsonResult);
    var result = (jsonResult as List<dynamic>).toList();

    List<Map<String,dynamic>> convertedList;
    convertedList = List<Map<String, dynamic>>.from(result);
    convertedList.forEach((element) { retOffersGuids.add(element.values.single.toString()); });

    return retOffersGuids;
  }

  Oferta getOfferByGuid(String offerGuid) {
    return listOffers.where((oferta) => oferta.OfertaGUID == offerGuid).first;
  }

  Future<List<ProdutoOferta>> getOfferByGuidFromApi(String offerGuid) async {
    await _loginController.getOffersApiEndpoints();
    var response = await get('${_loginController.regionBaseUrl + _loginController.apiOfertas1}/' + offerGuid, headers: _loginController.regionHeaders);
    if (response.hasError) throw 'Ocorreu um erro em getOfferByGuidFromApi() ' + response.body.toString();
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  Future<void> deleteOfferByGuidFromApi(String offerGuid) async {
    var response = await put('${_loginController.regionBaseUrl + _loginController.apiOfertaInativ}/' + offerGuid, '', headers: _loginController.regionHeaders);
    if (response.hasError) throw 'Ocorreu um erro em deleteOfferByGuidFromApi() ' + response.body.toString();
    else print(response.body);
  }

  Future<void> markOfferAsSold(String offerGuid) async {
    var response = await put('${_loginController.regionBaseUrl + _loginController.apiOfertaVendida}/' + offerGuid, '', headers: _loginController.regionHeaders);
    if (response.hasError) throw 'Ocorreu um erro em markOfferAsSold() $offerGuid';
    else print(response.body);
  }

  Future<void> reactivateOffer(String offerGuid) async {
    var response = await put('${_loginController.regionBaseUrl + _loginController.apiOfertaReativa}/' + offerGuid, '', headers: _loginController.regionHeaders);
    if (response.hasError) throw 'Ocorreu um erro em markOfferAsSold() $offerGuid';
    else print(response.body);
  }

  Future<void> deleteOfferByStore(String offerStoreId) async {
    var response = await put('${_loginController.regionBaseUrl + _loginController.apiOfertaLojaInativa}/' + offerStoreId, '', headers: _loginController.regionHeaders);
    if (response.hasError) throw 'Ocorreu um erro em deleteOfferByStore() $offerStoreId';
    else print(response.body);
  }

  Future<void> deleteOfferByVendor(String offerFkid) async {
    var response = await put('${_loginController.regionBaseUrl + _loginController.apiOfertaVendedorInativa}/' + offerFkid, '', headers: _loginController.regionHeaders);
    if (response.hasError) throw 'Ocorreu um erro em deleteOfferByVendor() $offerFkid';
    else print(response.body);
  }

}
