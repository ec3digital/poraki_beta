import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/routes/app_routes.dart';
import '../../../data/models/produto_oferta.dart';
import '../days_offers_controller.dart';

class ListProductsDayOffers extends StatelessWidget {
  ListProductsDayOffers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DaysOffersController controller = Get.find(); // Get.put(DaysOffersController());
    LoginController _loginController = Get.find();

    return Expanded(
      child: Container(
          child: GetBuilder<DaysOffersController>(builder: (context) {
            if (controller.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: controller.offers.length,
              itemBuilder: (BuildContext context, int index) {
                final ProdutoOferta _product = controller.offers[index];
                return InkWell(
                  onTap: () =>
                      Get.toNamed(AppRoutes.showDayOffer,
                      arguments: {'id': _product.ofertaID.toString()}),
                  child: Container(
                    padding: EdgeInsets.only(top: 3, right: 5, left: 5),
                    child: Card(
                      elevation: 2,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Container(
                            height: 100,
                            margin: EdgeInsets.only(top: 4),

                            child: CachedNetworkImage(
                              imageUrl: 'https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/ofertas%2F' + _product.ofertaGUID.toString() + '.jpg?alt=media',
                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                  CircularProgressIndicator(value: downloadProgress.progress),
                              errorWidget: (context, url, error) => Icon(Icons.local_offer_outlined),
                              height: 100,
                            ),

                            // child: FadeInImage.assetNetwork(
                            //   placeholder: 'assets/images/pholder.png',
                            //   image: 'https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/ofertas%2F' + _product.ofertaID.toString() + '.jpg?alt=media',
                            //   imageErrorBuilder: (context, url, error) => new Icon(Icons.local_offer_outlined),
                            //   height: 100,
                            // ),

                            // child: Image.network(
                            //   'https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/ofertas%2F' +
                            //       _product.ofertaID.toString() +
                            //       '.jpg?alt=media',
                            //   height: 100,
                            // ),

                          ),
                          Container(
                            margin: EdgeInsets.only(top: 4),
                            child: AutoSizeText(
                              _product.ofertaTitulo ?? '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'textDark').first.coreValor.toString())
                              ),
                              maxLines: 2,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            child: Text(
                              //'R\$ ${_product.ofertaPreco?.toStringAsFixed(2).replaceAll(',', '').replaceAll('.', ',') ?? ''}',
                              _product.ofertaPreco! > 0 ? 'R\$ ${_product.ofertaPreco!.toStringAsFixed(2).replaceAll(',', '').replaceAll('.', ',')}' : 'à combinar',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backDark').first.coreValor.toString()),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 2, left: 3),
                            child: Text(
                              "CEP: ${_product.ofertaCEP}",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: Colors.black, // _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'iconColor').first.coreValor.toString()),
                              ),
                            ),
                          ),
                          // Container(
                          //   width: 150,
                          //   margin: EdgeInsets.only(top: 3),
                          //   child: Text(
                          //     "Vendedor",
                          //     textAlign: TextAlign.left,
                          //     style: TextStyle(
                          //       fontWeight: FontWeight.w400,
                          //       fontSize: 10,
                          //       color: Colors.grey[800],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        }
      })),
    );
  }
}
