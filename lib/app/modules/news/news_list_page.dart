import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:poraki/app/data/models/noticias.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/home/widgets/gradient_header_home.dart';
import 'package:poraki/app/modules/news/news_controller.dart';
import 'package:poraki/app/modules/home/home_controller.dart';

class NewsListPage extends StatelessWidget {
  final HomeController controller = Get.find(); // Get.put(HomeController());
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

    Widget _buildRow(Noticia noticia) {
      return Column(children: [
        ListTile(
          //leading: retIcon(endereco.enderecoTipo, endereco.enderecoAtual),
          // onTap: () {
          //   controller.enderecoSingle = endereco;
          //   Get.toNamed(AppRoutes.address, arguments: [
          //     {'enderecoGuid': endereco.enderecoGuid}
          //   ]);
          // },
          leading: Icon(Icons.newspaper),
          title: Text(noticia.NoticiaTitulo.toString(),
              style: TextStyle(
                  fontSize: 20, color: colorText, fontWeight: FontWeight.w900)
              // style: _biggerFont,
              ),
          subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 10),
            Text(
              noticia.NoticiaTexto.toString(),
              style: TextStyle(fontSize: 16, color: colorText),),
            const SizedBox(height: 30),
            // TODO: jogar a Image da noticia se existir
            Text('Publicado em: ' +
                DateFormat("dd/MM/yyyy")
                    .format(noticia.NoticiaDesde!.toDate()) +
                ' às ' +
                DateFormat("hh:mm").format(noticia.NoticiaDesde!.toDate()),style: TextStyle(fontSize: 13, color: colorText),),
          ]),
          // trailing: Column(
          //   children: [
          // Expanded(
          // child: Text(noticia.NoticiaFonte.toString(),style: TextStyle(
          //     fontSize: 16,
          //     color: colorText,
          //     fontWeight: FontWeight.w900),)),
          //   ],
          // ),
          //trailing: Icon(IconData(int.parse(iconcode), fontFamily: 'MaterialIcons'))
        ),
        const SizedBox(height: 5),
        const Divider(),
        const SizedBox(height: 5),
      ]);
    }

    Future<void> pegaNoticias() async {
      await _newsController.carregaNoticias();
    }

    return FutureBuilder(
        future: pegaNoticias(),
        builder: (context, futuro) {
          if (futuro.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); //Text('carrinho vazio'));
            // } else if (futuro.hasError) {
            //   return Center(child: Text(futuro.error.toString()));
          } else {
            // print('qt news: ' + _newsController.noticias.length.toString());
            return SingleChildScrollView(
                //child: GradientHeaderHome(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                  const SizedBox(height: 15),
                  Center(
                      child: Text(
                    "Notícias da Região",
                    style: TextStyle(fontSize: 24),
                  )),
                  const SizedBox(height: 15),
                  //Text('merda')

                  if (_newsController.noticias.length == 0)
                    Container(
                        child: Center(
                            child: Text(
                                "Ops, nenhuma novidade poraki agora... ;-)")))
                  else
                    //Scrollbar(
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      //scrollDirection: Axis.vertical,
                      // padding: const EdgeInsets.all(16.0),
                      itemCount: _newsController.noticias.length,
                      itemBuilder: (BuildContext context, int index) {
                        //if (index.isOdd) return const Divider();
                        //index = index ~/ 2 + 1;
                        Noticia news = _newsController.noticias[index];
                        return _buildRow(news);
                      },
                    ),
                  //)
                ])
                //)
            );
          }
        });
  }
}
