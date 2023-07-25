import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/noticias.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/news/news_controller.dart';
import 'package:poraki/app/modules/home/home_controller.dart';

class NewsListPage extends StatelessWidget {
  final HomeController controller = Get.find();
  NewsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController _loginController = Get.find();
    final NewsController _newsController = Get.put(NewsController());
    final Color colorText = _loginController.colorFromHex(_loginController
        .listCore
        .where((coreItem) => coreItem.coreChave == 'textDark')
        .first
        .coreValor
        .toString());
    final Color backColor = _loginController.colorFromHex(_loginController
        .listCore
        .where((coreItem) => coreItem.coreChave == 'backLight')
        .first
        .coreValor
        .toString());

    Widget _buildRow(Noticia noticia) {
      return ListTile(
        leading: Icon(Icons.newspaper),
        //trailing: Text(noticia.NoticiaPor.toString()),
        title: Text(noticia.NoticiaTitulo.toString(),
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 18, color: colorText, fontWeight: FontWeight.w900)
            // style: _biggerFont,
            ),
        subtitle:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 10),
          Text(
            noticia.NoticiaTexto.toString(),
            style: TextStyle(fontSize: 16, color: colorText),
          ),
          const SizedBox(height: 20),
          // TODO: jogar a Image da noticia se existir
          // Text('Publicado por ' + noticia.NoticiaPor.toString() + ' em ' +
          //     DateFormat("dd/MM/yyyy")
          //         .format(noticia.NoticiaDesde!.toDate()) +
          //     ' às ' +
          //     DateFormat("hh:mm").format(noticia.NoticiaDesde!.toDate()),style: TextStyle(fontSize: 13, color: colorText),),
          Text('Publicado por ' + noticia.NoticiaPor.toString()),
        ]),
      );
    }

    Future<void> pegaNoticias() async {
      await _newsController.carregaNoticias();
    }

    return FutureBuilder(
        future: pegaNoticias(),
        builder: (context, futuro) {
          if (futuro.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  Center(
                      child: Text(
                    "Notícias da Região",
                    style: TextStyle(fontSize: 26),
                  )),
                  const SizedBox(height: 10),
                  if (_newsController.noticias.length == 0)
                    Container(
                        child: Center(
                            child: Text(
                                "Ops, nenhuma novidade poraki agora... ;-)", style: TextStyle(fontSize: 16))))
                  else
                    Expanded(
                        child: Container(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(6.0),
                          itemCount: _newsController.noticias.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: backColor,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: backColor,
                                ),
                                child: _buildRow(_newsController.noticias[index]));
                          }),
                    ))
                ]
                //)
                );
          }
        });
  }
}
