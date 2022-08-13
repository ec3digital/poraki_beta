import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/services/fbporaki_service.dart';

class CardBannerAloneHome extends StatelessWidget {
  CardBannerAloneHome({Key? key}) : super(key: key);

  String avisoApp = '';
  String avisoCep = '';
  final LoginController loginController = Get.find();

  Future<void> carregaAvisos() async {

    var tempAvisosApp =
        await fbPorakiService().getListFromFirebase("akiavisos", "avisos");
    tempAvisosApp.forEach((key, value) {
      avisoApp = value; // + ' (' + key + ')';
    });
    // print('avisoApp: ' + avisoApp.toString());

    var tempAvisosCep = await fbPorakiService().getListFromFirebase(
        "akiavisos", loginController.usuCep!.substring(0, 3));
    tempAvisosCep.forEach((key, value) {
      avisoCep = value; // + ' (' + key + ')';
    });

    if(avisoApp.isEmpty)
      avisoApp = 'Sem avisos para a sua região no momento';

    // print('avisoCep: ' + avisoCep.toString());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: carregaAvisos(),
        builder: (context, futuro) {
          if (futuro.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); //Text('carrinho vazio'));
            // } else if (futuro.hasError) {
            //   return Center(child: Text(futuro.error.toString()));
          } else {
            return GestureDetector(
                onTap: () {
                  Get.defaultDialog(
                    title: 'Você descobriu um recurso do futuro!',
                    middleText: 'Será implementado na próxima versão!',
                  );
                },
                child: Container(height: 30, width: Get.width * 0.92, decoration: BoxDecoration(
                    // border: Border.all(color: Colors.black),
                    color: Colors.white
                ),
                  //margin: EdgeInsets.all(10),
                  child: Marquee(text: avisoApp + ' / ' + ' ', startAfter: Duration(seconds: 1), style: TextStyle(color: loginController.colorFromHex(loginController.listCore.where((coreItem) => coreItem.coreChave == 'textDark').first.coreValor.toString()),),),
                  // child: ClipRRect(
                  //   borderRadius: BorderRadius.circular(15),
                  //   // child: Image.network(
                  //   //   "http://poraki-assets.ec3.digital/wp-content/uploads/2021/11/poraki_banner.png",
                  //   //   scale: 1.0,
                  //   // ),
                  // ),
                ));
          }
        });
  }
}
