import 'package:get/get.dart';
import 'package:poraki/app/data/models/noticias.dart';
import 'package:poraki/app/data/repositories/news_repository.dart';

class NewsController extends GetxController {
  List<Noticia> noticias = [];
  bool isLoading = false;

  Future<void> carregaNoticias() async {
    try {
      _changeLoading(true);
      noticias.clear();
      NewsRepository newsRepo = new NewsRepository();
      var news = await newsRepo.getAllNews();
      news.forEach((n) { noticias.add(n); });

      print('noticias: ' + noticias.length.toString());
    } catch (e) {
      print('Erro no carregaNoticias() controller ${e.toString()}');
    } finally {
      _changeLoading(false);
    }
  }

  void _changeLoading(bool newValue) {
    isLoading = newValue;
    update();
  }
}
