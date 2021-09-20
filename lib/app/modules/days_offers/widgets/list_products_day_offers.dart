import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/routes/app_routes.dart';

import '../../../data/models/produto_oferta.dart';
import '../days_offers_controller.dart';
import '../show_day_offer/show_day_offer_page.dart';

class ListProductsDayOffers extends StatelessWidget {
  final DaysOffersController controller;
  ListProductsDayOffers({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: GetBuilder<DaysOffersController>(
          builder: (_) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: controller.offers.length,
              itemBuilder: (BuildContext context, int index) {
                final ProdutoOferta _product = controller.offers[index];
                return InkWell(
                  onTap: () => Get.toNamed(AppRoutes.showDayOffer),
                  child: Container(
                    padding: EdgeInsets.only(top: 5, right: 5, left: 5),
                    child: Card(
                      elevation: 2,
                      child: Column(
                        children: [
                          Container(
                            height: 85,
                            margin: EdgeInsets.only(top: 10),
                            child: _product.ofertaImgPath != null
                                ? Image.asset(_product.ofertaImgPath!)
                                : Icon(Icons.broken_image_rounded),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: AutoSizeText(
                              _product.ofertaTitulo ?? '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                              maxLines: 2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            child: Text(
                              'R\$ ${_product.ofertaPreco?.toStringAsFixed(2) ?? ''}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
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
          },
        ),
      ),
    );
  }
}
