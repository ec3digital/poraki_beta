import 'package:get/get.dart';
import '../models/pessoas.dart';
import '../../shared/constants/constants.dart';

class PeopleRepository extends GetConnect {
  String url = '${Constants.baseUrl}pessoas';

  Future<List<Pessoas>> getAllPeople() async {
    var response = await get(url, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em PeopleRepository()';
    return (response.body['Pessoas'] as List)
        .map((pessoas) => Pessoas.fromJson(pessoas))
        .toList();
  }
}
