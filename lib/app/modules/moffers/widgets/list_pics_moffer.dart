import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/theme/app_theme.dart';

class ListPicsMoffer extends StatelessWidget {
  List<String> imagesList = [];

  ListPicsMoffer({
    Key? key,
    required this.imagesList,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
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

                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/pholder.png',
                      image: imagesList[index],
                      imageErrorBuilder: (context, url, error) => new Icon(Icons.local_offer_outlined),
                    ),

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
            bottom: 0,
            child: FloatingActionButton(
              elevation: 0,
              backgroundColor: AppColors.grayLightContainer,
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
