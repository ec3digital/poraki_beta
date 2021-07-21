import 'package:get/get.dart';
import 'package:poraki/app/data/models/ofertas.dart';
import 'package:poraki/app/shared/constants/constants.dart';

class OfferRepository extends GetConnect {
  String url = '${Constants.baseUrl}ofertasdodia';

  Future<List<Ofertas>> getOffersAll() async {
    var response = await get(url, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em OfferRepository()';
    return (response.body['Ofertas'] as List)
        .map((oferta) => Ofertas.fromJson(oferta))
        .toList();
  }
}
