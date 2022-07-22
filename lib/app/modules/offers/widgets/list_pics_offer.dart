import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';

class ListPicsOffer extends StatelessWidget {
  List<String> imagesList = [];

  ListPicsOffer({
    Key? key,
    required this.imagesList,
  }) : super(key: key);

  final LoginController _loginController = Get.find();

  @override
  Widget build(BuildContext context) {

    final Color backColor = _loginController.colorFromHex(_loginController
        .listCore
        .where((coreItem) => coreItem.coreChave == 'backLight')
        .first
        .coreValor
        .toString());

    return Container(
      height: Get.height * 0.40,
      child: Stack(
        children: [
          ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 1, //controller.listPictures.length,
            itemBuilder: (context, index) {
              return Container(
                width: Get.width * 1,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: Get.height * 0.37,

                    child: CachedNetworkImage(
                      imageUrl: imagesList[index],
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          CircularProgressIndicator(value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Icon(Icons.local_offer_outlined),
                    ),

                    // child: FadeInImage.assetNetwork(
                    //   placeholder: 'assets/images/pholder.png',
                    //   image: imagesList[index],
                    //   imageErrorBuilder: (context, url, error) => new Icon(Icons.local_offer_outlined),
                    // ),

                    // child: Image.network(
                    //   imagesList[index],
                    // ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            right: 15,
            //bottom: 0,
            top: 0,
            child: FloatingActionButton(
              elevation: 0,
              backgroundColor: backColor, //AppColors.containerLightColor,
              mini: true,
              onPressed: () {},
              child: Icon(Icons.favorite_outline, color: Colors.black,),
            ),
          )
        ],
      ),
    );
  }
}
