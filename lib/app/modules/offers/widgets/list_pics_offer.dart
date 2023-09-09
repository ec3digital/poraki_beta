import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/ofertafav.dart';
import 'package:poraki/app/data/models/produto_oferta.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/offers/offers_controller.dart';
import 'package:poraki/app/modules/offers/offersfav_controller.dart';
import 'package:poraki/app/routes/app_routes.dart';
//import '../offersfav_controller.dart';

class ListPicsOffer extends StatefulWidget {
  List<String> imagesList = [];
  // final String offerGuid;
  final ProdutoOferta offer;

  ListPicsOffer({
    Key? key,
    required this.imagesList,
    required this.offer,
  }) : super(key: key);

  @override
  State<ListPicsOffer> createState() => _ListPicsOfferState();
}

class _ListPicsOfferState extends State<ListPicsOffer> {
  final LoginController _loginController = Get.find();
  final OffersController _offersController = Get.find();
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
    bool favorited = _loginController.ofertasFavs
        .where((ofertaFav) => ofertaFav.ofertaGUID == widget.offer.ofertaGUID)
        .isNotEmpty;

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

                  // child: CachedNetworkImage(
                  //   imageUrl: widget.imagesList[index],
                  //   progressIndicatorBuilder:
                  //       (context, url, downloadProgress) =>
                  //           CircularProgressIndicator(
                  //               value: downloadProgress.progress),
                  //   errorWidget: (context, url, error) =>
                  //       Icon(Icons.local_offer_outlined),
                  // ),

                  child: FullScreenWidget(
                      disposeLevel: DisposeLevel.Medium,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: CachedNetworkImage(
                          imageUrl: widget.imagesList[index],
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.local_offer_outlined),
                        ),
                      )),

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
                // OffersFavController offersFavController = Get.put(OffersFavController());
                //_loginController.refreshOfertasFavs = true;
                if (favorited) {
                  _loginController.ofertasFavs.removeWhere((ofertaFav) =>
                      ofertaFav.ofertaGUID == widget.offer.ofertaGUID);
                  // Future.wait([offersFavController.removeObj(ofertaFav);]);
                } else {
                  _loginController.ofertasFavs.add(widget.offer);
                  // Future.wait([_offersFavController.addObj(ofertaFav)]);
                }

                setState(() {
                  favorited = !favorited;
                });

                Future.wait([_offersController.getOffersFavsFromMemory()]);

                Get.offAndToNamed(AppRoutes.offers, arguments: [
                  {'listName': 'favsoffers'},
                  {'limit': 24},
                  {'category': null},
                  {'title': 'Favoritas'},
                  {'ofertaGuid': null}
                ]);
              },
              child: icon,
            ),
          )
        ],
      ),
    );
  }
}
