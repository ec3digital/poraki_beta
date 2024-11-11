import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
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
  InternetStatus? _connectionStatus;
  late StreamSubscription<InternetStatus> _subscription;
  final LoginController _loginController = Get.find();
  final OffersController _offersController = Get.find();
  late Color backColor;
  late Color textColor;
  bool isLoading = false;
  Icon icon = Icon(Icons.favorite_outline);
  bool favorited = false;

  @override
  void initState() {
    super.initState();
    _subscription = InternetConnection().onStatusChange.listen(
      (status) {
        setState(() {
          _connectionStatus = status;
        });
      },
    );

    backColor = _loginController.colorFromHex(_loginController.backLight);
    textColor = _loginController.colorFromHex(_loginController.backDark);
    favorited = _loginController.favoffersguids!
        .where((ofertaFavGuid) => ofertaFavGuid == widget.offer.ofertaGUID)
        .isNotEmpty;
  }

  Future<void> _toggleFavorite() async {
    OffersFavController _offersFavController = Get.put(OffersFavController());
    if (favorited) {
      await _offersFavController.removeObj(
          widget.offer.ofertaGUID.toString(), _offersController);
    } else {
      await _offersFavController.addObj(
          widget.offer.ofertaGUID.toString(), _offersController);
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
  }

  @override
  Widget build(BuildContext context) {
    icon = favorited
        ? Icon(Icons.favorite, color: textColor)
        : Icon(Icons.favorite_outline, color: textColor);

    return Container(
      height: Get.height * 0.40,
      child: Stack(
        children: [
          const Text('Conexão: '),
          Text(_connectionStatus?.toString() ?? '...'),
          ListView.builder(
            itemCount: widget.imagesList.length,
            itemBuilder: (context, index) {
              return Container(
                width: Get.width * 1,
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
                ),
              );
            },
          ),
          Positioned(
            right: 15,
            top: 0,
            child: FloatingActionButton(
              elevation: 0,
              backgroundColor: backColor,
              mini: true,
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                await _toggleFavorite();
              },
              child: isLoading
                  ? Icon(Icons.cloud_upload, color: textColor)
                  : icon,
            ),
          )
        ],
      ),
    );
  }
}
