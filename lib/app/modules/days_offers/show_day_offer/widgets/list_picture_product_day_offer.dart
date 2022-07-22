import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme/app_theme.dart';
import '../show_day_offer_controller.dart';

class ListPictureProduct extends StatelessWidget {
  const ListPictureProduct({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ShowDayOfferController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.40,
      child: Stack(
        children: [
          ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.listPictures.length,
            itemBuilder: (context, index) {
              return Container(
                width: Get.width * 1,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: Get.height * 0.37,

                    child: CachedNetworkImage(
                      imageUrl: controller.listPictures[index],
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          CircularProgressIndicator(value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Icon(Icons.local_offer_outlined),
                    ),

                    // child: FadeInImage.assetNetwork(
                    //   placeholder: 'assets/images/pholder.png',
                    //   image: controller.listPictures[index],
                    //   imageErrorBuilder: (context, url, error) => new Icon(Icons.local_offer_outlined),
                    // ),

                    // child: Image.network(
                    //   controller.listPictures[index],
                    // ),

                  ),
                ),
              );
            },
          ),
          Positioned(
            right: 15,
            bottom: 0,
            child: FloatingActionButton(
              elevation: 0,
              backgroundColor: AppColors.containerLightColor,
              mini: true,
              onPressed: () {},
              child: Icon(Icons.share_outlined, color: Colors.black,),
            ),
          )
        ],
      ),
    );
  }
}
