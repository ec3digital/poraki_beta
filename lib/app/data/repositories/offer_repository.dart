import 'package:get/get.dart';
import '../models/produto_oferta.dart';
import '../../shared/constants/constants.dart';

class OfferRepository extends GetConnect {

  Future<List<ProdutoOferta>> getOffersAll() async {
    String url = '${Constants.baseUrl}ofertasdodiaporcep/05735030';
    var response = await get(url, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em getOffersAll()';
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  Future<List<ProdutoOferta>> getDayOfferByCEP(String cep) async {
    String url = '${Constants.baseUrl}ofertasdodiaporcep/' + cep;
    var response = await get(url, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em getDayOfferByCEP()';
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  Future<List<ProdutoOferta>> getOfferByCEPCategory(String cep, String category) async {
    String url = '${Constants.baseUrl}ofertasporcepcategoria/' + cep + '/' + category;
    var response = await get(url, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em getOfferByCEPCategory()';
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  Future<List<ProdutoOferta>> getOfferByCEPCategoryTitle(String cep, String title, String category) async {
    String url = '${Constants.baseUrl}ofertasporcepcategoriatitulo/' + cep + '/' + category + '/%' + title + '%';
    var response = await get(url, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em getOfferByCEPCategoryTitle()';
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  Future<List<ProdutoOferta>> getOfferByCEPTitle(String cep, String title) async {
    String url = '${Constants.baseUrl}ofertasporceptitulo/' + cep + '/%' + title + '%';
    print(url);
    var response = await get(url, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em getOfferByCEPTitle() - '; // + response.bodyString.toString();
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

  Future<List<ProdutoOferta>> getOfferById(int ofertaId) async {
    String url = '${Constants.baseUrl}ofertasingle/' + ofertaId.toString();
    var response = await get(url, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em getOfferById()';
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }

}
