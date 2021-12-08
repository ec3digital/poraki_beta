import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    return Expanded(
      child: Container(
        child: GetBuilder<OffersController>(builder: (context) {
          if (offersController.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: offersController.offers.length,
              itemBuilder: (BuildContext context, int index) {
                ProdutoOferta _product = offersController.offers[index];
                return InkWell(
                    onTap: () => Get.toNamed(AppRoutes.offer, arguments:
                      _product.ofertaID),
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
                            child: Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/ofertas%2F' +
                                  _product.ofertaID.toString() +
                                  '.jpg?alt=media',
                              height: 100,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 4),
                            child: AutoSizeText(
                              _product.ofertaTitulo ?? '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                              maxLines: 2,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            child: Text(
                              'R\$ ${_product.ofertaPreco?.toStringAsFixed(2) ?? ''}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 2),
                            child: Text(
                              "CEP: ${_product.ofertaCEP}",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 10,
                                color: Colors.blue,
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