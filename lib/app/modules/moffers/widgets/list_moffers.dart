import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/oferta.dart';
import 'package:poraki/app/modules/moffers/moffer_controller.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'package:poraki/app/routes/app_routes.dart';
import 'package:poraki/app/theme/app_theme.dart';

class ListMoffers extends StatelessWidget {
  ListMoffers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MofferController mofferController = Get.put(MofferController());


    return FutureBuilder(
        future: mofferController.getMoffers(),
        builder: (context, futuro) {
          if (futuro.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); //Text('carrinho vazio'));
            // } else if (futuro.hasError) {
            //   return Center(child: Text(futuro.error.toString()));
          } else {
            return Container(
              child: GetBuilder<MofferController>(builder: (context) {
                if (mofferController.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                        SizedBox(height: 20),
                        Center(child: Text("Minhas Ofertas")),
                        SizedBox(height: 20),
                        ButtonOffer(
                          onPressed: () {
                            Get.toNamed(AppRoutes.mOffer);
                          },
                          colorText: AppColors.yellowComum,
                          text: 'Criar nova oferta',
                          colorButton: AppColors.primaryColor,
                        ),
                        SizedBox(height: 20),
                        GridView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: mofferController.moffers.length,
                          itemBuilder: (BuildContext context, int index) {
                            Oferta _oferta = mofferController.moffers[index];
                            return InkWell(
                              onTap: () {
                                Get.toNamed(AppRoutes.mOffer,
                                    arguments: [{'offer': _oferta}]);
                                print('offer arg send: ');
                                print (_oferta.OfertaTitulo.toString());

                              },
                              // arguments: _oferta.OfertaID.toString()),
                              child: Container(
                                padding:
                                    EdgeInsets.only(top: 3, right: 5, left: 5),
                                child: Card(
                                  elevation: 2,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 80,
                                        margin: EdgeInsets.only(top: 4),
                                        child: FadeInImage.assetNetwork(
                                          placeholder:
                                              'assets/images/pholder.png',
                                          image:
                                              'https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/ofertas%2F' +
                                                  _oferta.OfertaGUID
                                                      .toString() +
                                                  '.jpg?alt=media',
                                          imageErrorBuilder:
                                              (context, url, error) => new Icon(
                                                  Icons.local_offer_outlined),
                                          height: 50,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 4),
                                        child: AutoSizeText(
                                          _oferta.OfertaTitulo ?? '',
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
                                          'R\$ ${_oferta.OfertaPreco?.toStringAsFixed(2).replaceAll('.', ',') ?? ''}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                      // Container(
                                      //   margin: EdgeInsets.only(top: 2),
                                      //   child: Text(
                                      //     "CEP: ${_oferta.OfertaCEP}",
                                      //     textAlign: TextAlign.left,
                                      //     style: TextStyle(
                                      //       fontWeight: FontWeight.w700,
                                      //       fontSize: 10,
                                      //       color: Colors.blue,
                                      //     ),
                                      //   ),
                                      // ),
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
                        )
                      ]));
                }
              }),
            );
          }
        });
  }
}