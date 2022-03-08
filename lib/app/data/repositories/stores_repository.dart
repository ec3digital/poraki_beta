import 'package:get/get.dart';
import '../../shared/constants/constants.dart';
import '../models/lojas.dart';

class StoresRepository extends GetConnect {
  String urlAll = '${Constants.baseUrl}lojasporvendedor/';

  Future<List<Lojas>> getAllStores(String usuguid) async {
    var response = await get(urlAll + usuguid, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em AddressRepository().getAllAddresses';
    return (response.body['Lojas'] as List)
        .map((obj) => Lojas.fromJson(obj))
        .toList();
  }

}
