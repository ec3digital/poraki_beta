import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/ofertafav.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
//import '../offersfav_controller.dart';

class ListPicsOffer extends StatefulWidget {
  List<String> imagesList = [];
  final String offerGuid;

  ListPicsOffer({
    Key? key,
    required this.imagesList,
    required this.offerGuid,
  }) : super(key: key);

  @override
  State<ListPicsOffer> createState() => _ListPicsOfferState();
}

class _ListPicsOfferState extends State<ListPicsOffer> {
  final LoginController _loginController = Get.find();
  //final OffersFavController _offersFavController = Get.put(OffersFavController()); //.find();
  late Color backColor;
  late Color textColor;
  //late OfertasFavs ofertaFav;
  // late bool favorited;

  @override
  void initState() {
    backColor = _loginController.colorFromHex(_loginController.listCore
        .where((coreItem) => coreItem.coreChave == 'backLight')
        .first
        .coreValor
        .toString());

    textColor = _loginController.colorFromHex(_loginController.listCore
        .where((coreItem) => coreItem.coreChave == 'backDark')
        .first
        .coreValor
        .toString());
  }

  @override
  Widget build(BuildContext context) {
    print('fav usuGuid: ' + _loginController.usuGuid.toString());
    var ofertaFav = new OfertasFavs(widget.offerGuid.toString(),
        _loginController.usuGuid.toString(), false, false);
    print('qtd fav de novo: ' + _loginController.ofertasFavs.length.toString());
    bool favorited = _loginController.ofertasFavs
            .where((ofav) => ofav.OfertaGUID == widget.offerGuid)
            .isNotEmpty
        ? true
        : false;
    print('fav : ' + widget.offerGuid + ' / ' + favorited.toString());

    var icon = favorited
        ? Icon(Icons.favorite, color: textColor)
        : Icon(Icons.favorite_outline, color: textColor);

    return Container(
      height: Get.height * 0.40,
      child: Stack(
        children: [
          ListView.builder(

            //scrollDirection: Axis.horizontal,
            itemCount: 1, //controller.listPictures.length,
            itemBuilder: (context, index) {
              return Container(
                width: Get.width * 1,
                // child: Align(
                //   alignment: Alignment.topCenter,
                  child: Container(
                    height: Get.height * 0.37,

                    child: CachedNetworkImage(
                      imageUrl: widget.imagesList[index],
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.local_offer_outlined),
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
                //),
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
              onPressed: () async {
                //OffersFavController _offersFavController = Get.put(OffersFavController());
                //_loginController.refreshOfertasFavs = true;
                if (favorited) {
                  _loginController.ofertasFavs.removeWhere(
                      (ofFav) => ofFav.OfertaGUID == ofertaFav.OfertaGUID);
                  //await _offersFavController.removeObj(ofertaFav);
                } else {
                  _loginController.ofertasFavs.add(ofertaFav);
                  //await _offersFavController.addObj(ofertaFav);
                }

                setState(() {
                  favorited = !favorited;
                });
              },
              child: icon,
            ),
          )
        ],
      ),
    );
  }
}
