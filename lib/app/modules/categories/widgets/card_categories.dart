import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/routes/app_routes.dart';

class CardCategoriesVertical extends StatelessWidget {
  final String text;
  final IconData iconData;
  final String chave;

  const CardCategoriesVertical({Key? key, required this.text, required this.iconData, required this.chave})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)!.settings.arguments as OffersArgs;
    //print('chave: ' + chave);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Card(
            elevation: 5,
            color: Colors.white,
            shape: CircleBorder(),
            child: Container(
              //color: Colors.grey,
              height: Get.height * 0.07,
              width: Get.width * 0.14,
              child: IconButton(icon: Icon(iconData),
                  onPressed: () => Get.toNamed(AppRoutes.offers, arguments: [
                    {'listName': null}, {'limit': 24}, {'category': chave.toString() }, {'title': null}, {'ofertaGuid': null}] )
              ),
            ),
          ),
          SizedBox(
            width: Get.width * 0.22,
            child: AutoSizeText(
              text,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
              maxLines: 6,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
