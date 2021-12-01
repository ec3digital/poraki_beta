import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardBannerAloneHome extends StatelessWidget {
  CardBannerAloneHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.defaultDialog(
          title: 'Você descobriu um recurso do futuro!',
          middleText: 'Será implementado na próxima versão!',
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          // child: Image.network(
          //   "http://poraki-assets.ec3.digital/wp-content/uploads/2021/11/poraki_banner.png",
          //   scale: 1.0,
          // ),
        ),
      ),
    );
  }
}