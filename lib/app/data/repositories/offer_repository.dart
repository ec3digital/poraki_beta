import 'package:get/get.dart';
import '../models/produto_oferta.dart';
import '../../shared/constants/constants.dart';

class OfferRepository extends GetConnect {
  String url = '${Constants.baseUrl}ofertasdodia';

  Future<List<ProdutoOferta>> getOffersAll() async {
    var response = await get(url, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em OfferRepository()';
    return (response.body['Ofertas'] as List)
        .map((oferta) => ProdutoOferta.fromJson(oferta))
        .toList();
  }
}
