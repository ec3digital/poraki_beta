import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/produto_oferta.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/offers/offers_controller.dart';
import 'package:poraki/app/modules/offers/offersfav_controller.dart';
import 'package:poraki/app/routes/app_routes.dart';

class ListPicsOffer extends StatefulWidget {
  List<String> imagesList = [];
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
  bool isLoading = false;
  Icon icon = Icon(Icons.favorite_outline);
  bool favorited = false;

  @override
  void initState() {
    print('passou no initState do list_pics_offer');
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

    favorited = _loginController.favoffersguids!
        .where((ofertaFavGuid) => ofertaFavGuid == widget.offer.ofertaGUID)
        .isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    print('passou no build do list_pics_offer');
    icon = favorited
        ? Icon(Icons.favorite, color: textColor)
        : Icon(Icons.favorite_outline, color: textColor);

    return FutureBuilder(builder: (context, futuro) {
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
                  setState(() {
                    isLoading = true;
                  });

                  OffersFavController _offersFavController = Get.put(OffersFavController());
                  if (favorited) {
                    Future.wait([_offersFavController.removeObj(widget.offer.ofertaGUID.toString(), _offersController)]);
                  } else {
                    Future.wait([_offersFavController.addObj(widget.offer.ofertaGUID.toString(), _offersController)]);
                  }

                  setState(() {
                    favorited = !favorited;
                    isLoading = false;
                  });

                  Get.offAndToNamed(AppRoutes.offers, arguments: [
                    {'listName': 'favsoffers'},
                    {'limit': 24},
                    {'category': null},
                    {'title': 'Favoritas'},
                    {'ofertaGuid': null}
                  ]);
                },
                child: isLoading
                    ? Icon(Icons.cloud_upload, color: textColor)
                    : icon,
              ),
            )
          ],
        ),
      );
    });
  }
}
