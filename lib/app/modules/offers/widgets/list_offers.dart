import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/routes/app_routes.dart';
import '../../../data/models/produto_oferta.dart';
import '../offers_controller.dart';

class ListOffers extends StatelessWidget {
  ListOffers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OffersController offersController = Get.put(OffersController());
    LoginController _loginController = Get.find();

    return Expanded(
      child: Container(
        child: GetBuilder<OffersController>(builder: (context) {
          if (offersController.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (offersController.offers.length == 0)
              return Container(
                  child: Center(child: Text("Ops, nada poraki ainda... ;-)")));
            else
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: offersController.offers.length,
                itemBuilder: (BuildContext context, int index) {
                  ProdutoOferta _product = offersController.offers[index];
                  return InkWell(
                    onTap: () => Get.toNamed(AppRoutes.offer,
                        arguments: _product.ofertaID),
                    child: Container(
                      padding: EdgeInsets.only(top: 3, right: 5, left: 5),
                      child: Card(
                        elevation: 2,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Container(
                              height: 80,
                              margin: EdgeInsets.only(top: 4),

                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/pholder.png',
                                image:
                                    'https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/ofertas%2F' +
                                        _product.ofertaID.toString() +
                                        '.jpg?alt=media',
                                imageErrorBuilder: (context, url, error) =>
                                    new Icon(Icons.local_offer_outlined),
                                height: 50,
                              ),

                              // child: Image.network(
                              //   'https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/ofertas%2F' +
                              //       _product.ofertaID.toString() +
                              //       '.jpg?alt=media',
                              //   height: 50,
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
                                    color: _loginController.colorFromHex(
                                        _loginController.listCore
                                            .where((coreItem) =>
                                                coreItem.coreChave ==
                                                'textDark')
                                            .first
                                            .coreValor
                                            .toString())),
                                maxLines: 2,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              child: Text(
                                'R\$ ${_product.ofertaPreco?.toStringAsFixed(2).replaceAll(',', '').replaceAll('.', ',') ?? ''}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: _loginController.colorFromHex(
                                      _loginController.listCore
                                          .where((coreItem) =>
                                              coreItem.coreChave == 'backDark')
                                          .first
                                          .coreValor
                                          .toString()),
                                ),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Container(
                              margin: EdgeInsets.only(top: 2, left: 70),
                              child: Text(
                                "CEP: ${_product.ofertaCEP}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10,
                                  color: Colors
                                      .white, // _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'iconColor').first.coreValor.toString()),
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
                },
              );
          }
        }),
      ),
    );
  }
}
