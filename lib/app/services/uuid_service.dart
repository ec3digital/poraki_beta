import 'package:http/http.dart' as http;

class uuidService {

  Future<String> getRandomUUID() async {
    String url = 'https://www.uuidgenerator.net/api/version4';
    var response = await http.get(Uri.parse(url));

    return response.body.toString();
  }
}
