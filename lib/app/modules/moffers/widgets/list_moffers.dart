import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/oferta.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/home/widgets/gradient_header_home.dart';
import 'package:poraki/app/modules/moffers/moffer_controller.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'package:poraki/app/modules/stores/store_controller.dart';
import 'package:poraki/app/routes/app_routes.dart';

class ListMoffers extends StatefulWidget {
  ListMoffers({
    Key? key,
  }) : super(key: key);

  @override
  State<ListMoffers> createState() => _ListMoffersState();
}

class _ListMoffersState extends State<ListMoffers> {


  @override
  Widget build(BuildContext context) {
    final MofferController mofferController = Get.put(MofferController());
    final StoreController storeController = Get.put(StoreController());
    LoginController _loginController = Get.find();

    var listStores = ['Nenhuma', 'Loja 1'];
    var selStore = 'Nenhuma';

    Future<void> loadObjs() async {
      await storeController.carregaLojas();
      await mofferController.getMoffers(_loginController.usuGuid.toString());
    }

    return FutureBuilder(
        future: loadObjs(),
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
                  return SingleChildScrollView(child: GradientHeaderHome(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                        SizedBox(height: 20),
                        Center(child: Text("Minhas Ofertas",
                          style: TextStyle(fontSize: 24),)),
                        SizedBox(height: 20),
                        ButtonOffer(
                          onPressed: () {
                            Get.toNamed(AppRoutes.mOffer);
                          },
                          colorText: _loginController.colorFromHex(_loginController
                              .listCore
                              .where((coreItem) => coreItem.coreChave == 'textLight')
                              .first
                              .coreValor
                              .toString()),
                          text: 'Nova oferta',
                          colorButton: _loginController.colorFromHex(_loginController
                              .listCore
                              .where((coreItem) => coreItem.coreChave == 'textDark')
                              .first
                              .coreValor
                              .toString()),
                        ),
                        SizedBox(height: 20),
                        ListTile(
                          leading: Text('Lojas'),
                          trailing: DropdownButton<String>(
                            items: listStores.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            value: selStore,
                            onChanged: (String? newValue) {
                              setState(() {
                                selStore = newValue!;
                              });
                            },
                          ),
                        ),
                        // SizedBox(height: 20),
                        // ButtonOffer(
                        //   onPressed: () {
                        //     Future.delayed(Duration.zero, () async {
                        //       storeController.emptyLoja();
                        //     });
                        //
                        //     Get.toNamed(AppRoutes.store);
                        //     // Get.toNamed(AppRoutes.store,arguments: [{
                        //     //   "lojaObj": null
                        //     // }]);
                        //   },
                        //   colorText: AppColors.primaryBackground,
                        //   text: 'Criar Loja',
                        //   colorButton: AppColors.secondaryColorButton,
                        // ),
                        // SizedBox(height: 20),
                        // IconButton(
                        //     icon: Icon(Icons.store),
                        //     onPressed: () => Get.toNamed(AppRoutes.stores)),
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
                                Get.toNamed(AppRoutes.mOffer, arguments: [
                                  {'offer': _oferta}
                                ]);
                                print('offer arg send: ');
                                print(_oferta.OfertaTitulo.toString());
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
                                            color: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'textDark').first.coreValor.toString())
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
                                            color: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backDark').first.coreValor.toString()),
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
                      ])));
                }
              }),
            );
          }
        });
  }
}
