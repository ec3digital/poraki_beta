import 'package:get/get.dart';
import 'package:poraki/app/data/models/parceiros.dart';
import '../../shared/constants/constants.dart';

class PartnerRepository extends GetConnect {
  //String url = '${Constants.baseUrl}parceiros';
  String url = 'https://poraki.hasura.app/api/rest/parceirosentrega/%25%2C05735%25';

  Future<List<Parceiros>> getAll() async {
    var response = await get(url, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em PartnerRepository.getAll()';
    return (response.body['ParceirosEntrega'] as List)
        .map((parceiro) => Parceiros.fromJson(parceiro))
        .toList();
  }
}
