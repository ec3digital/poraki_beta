import 'package:get/get.dart';
import '../../shared/constants/constants.dart';
import '../models/lojas.dart';

class StoreRepository extends GetConnect {
  String urlAll = '${Constants.baseUrl}lojasporusuario/';
  String urlSingle = '${Constants.baseUrl}loja/';

  Future<List<Lojas>> getAllStores(String usuguid) async {
    var response = await get(urlAll + usuguid, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em StoreRepository().getAllStores';
    return (response.body['Lojas'] as List)
        .map((obj) => Lojas.fromJson(obj))
        .toList();
  }

  Future<Lojas> getStore(String guid) async {
    var response = await get(urlSingle + guid, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em StoreRepository().getStore';
    return (response.body['Lojas'] as List)
        .map((obj) => Lojas.fromJson(obj))
        .toList().first;
  }

  //TODO: inativar loja

}
