//import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/lojas.dart';
import 'package:poraki/app/data/models/oferta.dart';
//import 'package:poraki/app/data/repositories/brands_repository.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/moffers/moffer_controller.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'package:poraki/app/routes/app_routes.dart';

import '../../home/widgets/gradient_header_home.dart';

class ListMoffers extends StatefulWidget {
  ListMoffers({
    Key? key,
  }) : super(key: key);

  @override
  State<ListMoffers> createState() => _ListMoffersState();
}

class _ListMoffersState extends State<ListMoffers> {
  final MofferController mofferController = Get.put(MofferController());
  final LoginController _loginController = Get.find();

  List<Lojas> listStores = [];

  Lojas? selStore;
  bool load = true;

  Future<void> loadObjs(bool load) async {
    // if (selStore == null) {
    await mofferController.getMoffers(_loginController.usuGuid.toString());
    // } else {
    print('lojaGuid: ' + selStore!.LojaNome!.toString());

    // if (selStore?.LojaNome.toString() == 'Nenhuma')
    if (selStore == null)
      await mofferController.getMoffers(_loginController.usuGuid.toString());
    else
      await mofferController.getMoffersByStore(selStore!.LojaGUID.toString());
    // }

    // if (load &&
    //     !listStores.contains(new Lojas(null, null, 'Nenhuma', null, null,
    //         null, null, null, null, null, null, null, null, null)))
    //   listStores.add(new Lojas(null, null, 'Nenhuma', null, null, null,
    //       null, null, null, null, null, null, null, null));

    load = false;

    // await BrandsRepository().getAllBrands();
  }

  @override
  Widget build(BuildContext context) {
    // Lojas lojaNenhuma = new Lojas(DateTime.now(), '', 'Nenhuma', _loginController.usuCep, '', 'Nenhuma', _loginController.usuGuid, '', '', '', '', '', '', '', '');
    listStores.clear();
    // if(listStores.contains(lojaNenhuma) == false) listStores.add(lojaNenhuma);
    _loginController.listLojas.forEach((element) {
      listStores.add(element);
    });

    // listStores.forEach((store) { })
    // listStores.remove((store) => store.LojaNome == 'Nenhuma');

    // final Color colorText = _loginController.colorFromHex(_loginController
    //     .listCore
    //     .where((coreItem) => coreItem.coreChave == 'textDark')
    //     .first
    //     .coreValor
    //     .toString());
    final Color backColor = _loginController.colorFromHex(_loginController.backLight);
    final Color textDarkColor = _loginController.colorFromHex(_loginController.textDark);
    final Color soldBackColor = Colors.grey.shade300;

    Widget _buildRow(Oferta moferta) {
      return Column(children: [
        Container(
            // padding: const EdgeInsets.all(2),
            // margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              border: Border.all(
                color: moferta.OfertaDispoAte.toString().length > 4
                    ? soldBackColor
                    : backColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: moferta.OfertaDispoAte.toString().length > 4
                  ? soldBackColor
                  : backColor,
            ),
            child: ListTile(
              leading: CachedNetworkImage(
                imageUrl: _loginController.imgPath + moferta.OfertaGUID.toString() + _loginController.imgPathSuffix,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) =>
                    Icon(Icons.local_offer_outlined),
                height: 110,
              ),
              onTap: () {
                mofferController.singleOffer = moferta;
                Get.toNamed(AppRoutes.mOffer);
              },
              title: Text(
                moferta.OfertaDispoAte.toString().length > 4
                    ? '(Vendido) ' + moferta.OfertaTitulo.toString()
                    : moferta.OfertaTitulo.toString(),
                style: TextStyle(
                    fontSize: 18,
                    decoration: moferta.OfertaDispoAte.toString().length > 4
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    color: moferta.OfertaDispoAte.toString().length > 4
                        ? Colors.redAccent
                        : textDarkColor),
              ),
              subtitle: Text(moferta.OfertaDetalhe.toString(),
                  style: TextStyle(fontSize: 16)),
              trailing: Text(
                  //'R\$ ${moferta.OfertaPreco?.toStringAsFixed(2).replaceAll(',', '').replaceAll('.', ',') ?? ''}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),))
                  moferta.OfertaPreco! > 0
                      ? 'R\$ ${moferta.OfertaPreco?.toStringAsFixed(2).replaceAll(',', '').replaceAll('.', ',') ?? ''}'
                      : 'à combinar',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            )),
        //const SizedBox(height: 3),
      ]);
    }

    return FutureBuilder(
        future: loadObjs(load),
        builder: (context, futuro) {
          if (futuro.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
                    backgroundColor: _loginController.colorFromHex(
                        _loginController.backDark)));
          } else {
            return Expanded(
                child: Container(
                    //color: backDark,
                    child: Column(children: [
              // Column(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              const SizedBox(height: 10),
              Center(
                  child: Text(
                "Minhas Ofertas",
                style: TextStyle(fontSize: 24),
              )),
              const SizedBox(height: 5),

              if(_loginController.usuPerfil == 'U' && (mofferController.moffers.length > _loginController.qtyOfertasGratis))
                Container (padding: const EdgeInsets.all(8.0), child: Text("Ative o pacote Premium para publicar quantas ofertas quiser! :-)", style: TextStyle(fontSize: 16), textAlign: TextAlign.center))
              else
                ButtonOffer(
                  onPressed: () {
                    mofferController.singleOffer = null;
                    mofferController.mofferGuid = '';
                    // mofferController.loja = selStore;
                    // mofferController.txtCEP.text = _loginController.usuCep.toString();
                    // mofferController.lojaGuid = selStore == null ? '' : selStore!.LojaGUID.toString();
                    Get.toNamed(AppRoutes.mOffer);
                  },

                  colorText: _loginController.colorFromHex(_loginController.textLight),
                  text: 'Nova oferta',
                  colorButton: _loginController.colorFromHex(_loginController.textDark),
                ),

              const SizedBox(height: 5),
              ListTile(
                title: Text(
                  'Loja: ',
                  style: TextStyle(fontSize: 18),
                ),
                trailing: DropdownButton<Lojas>(
                  items: listStores.map((Lojas loja) {
                    return DropdownMenuItem<Lojas>(
                      value: loja,
                      child: Text(loja.LojaNome.toString()),
                    );
                  }).toList(),
                  value: selStore,
                  onChanged: (Lojas? novaLojaSel) {
                    setState(() {
                      load = false;
                      selStore = novaLojaSel;

                      // listStores.forEach((element) { print(element.LojaNome);});

                      // if (novaLojaSel!.LojaNome != 'Nenhuma') {selStore = novaLojaSel;} else { selStore = listStores.where((element) => element.LojaNome == 'Nenhuma').single; }
                      // try {selStore = newValue!;} catch (Exception) { selStore = selStore;}
                    });
                  },
                ),
              ),
              SizedBox(height: 5),
              if (mofferController.moffers.length == 0)
                Container(
                    height: Get.height * 0.6,
                    child: Center(child: Text("Ops, nada poraki ainda... ;-)")))
              else
                //Expanded(flex: 0, child:
                Expanded(
                    child: Container(
                        //height: 200, // MediaQuery.of(context).size.height,
                        child: Scrollbar(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(6.0),
                      itemCount: mofferController.moffers.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            padding: const EdgeInsets.all(3),
                            margin: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.transparent,
                            ),
                            child: _buildRow(mofferController.moffers[index]));
                      }),
                )
                        //)
                        )

                    // GridView.builder(
                    //   shrinkWrap: true,
                    //   scrollDirection: Axis.vertical,
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   gridDelegate:
                    //       SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 2,
                    //   ),
                    //   itemCount: mofferController.moffers.length,
                    //   itemBuilder: (BuildContext context, int index) {
                    //     Oferta _oferta = mofferController.moffers[index];
                    //     return InkWell(
                    //       onTap: () {
                    //         Get.toNamed(AppRoutes.mOffer, arguments: [
                    //           {'offer': _oferta}
                    //         ]);
                    //         print('offer arg send: ');
                    //         print(_oferta.OfertaTitulo.toString());
                    //       },
                    //       // arguments: _oferta.OfertaID.toString()),
                    //       child: Container(
                    //         padding: EdgeInsets.only(
                    //             top: 3, right: 5, left: 5),
                    //         child: Card(
                    //           elevation: 2,
                    //           child: Column(
                    //             children: [
                    //               Container(
                    //                 height: 80,
                    //                 margin: EdgeInsets.only(top: 4),
                    //                 child: CachedNetworkImage(
                    //                   imageUrl:
                    //                       'https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/ofertas%2F' +
                    //                           _oferta.OfertaGUID
                    //                               .toString() +
                    //                           '.jpg?alt=media',
                    //                   progressIndicatorBuilder: (context,
                    //                           url, downloadProgress) =>
                    //                       CircularProgressIndicator(
                    //                           value: downloadProgress
                    //                               .progress),
                    //                   errorWidget:
                    //                       (context, url, error) => Icon(
                    //                           Icons.local_offer_outlined),
                    //                   height: 50,
                    //                 ),
                    //
                    //                 // child: FadeInImage.assetNetwork(
                    //                 //   placeholder:
                    //                 //       'assets/images/pholder.png',
                    //                 //   image:
                    //                 //       'https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/ofertas%2F' +
                    //                 //           _oferta.OfertaGUID
                    //                 //               .toString() +
                    //                 //           '.jpg?alt=media',
                    //                 //   imageErrorBuilder: (context, url,
                    //                 //           error) =>
                    //                 //       new Icon(
                    //                 //           Icons.local_offer_outlined),
                    //                 //   height: 50,
                    //                 // ),
                    //               ),
                    //               Container(
                    //                 margin: EdgeInsets.only(top: 4),
                    //                 child: AutoSizeText(
                    //                   _oferta.OfertaTitulo ?? '',
                    //                   textAlign: TextAlign.center,
                    //                   style: TextStyle(
                    //                       fontWeight: FontWeight.w700,
                    //                       fontSize: 14,
                    //                       color: _loginController
                    //                           .colorFromHex(
                    //                               _loginController
                    //                                   .listCore
                    //                                   .where((coreItem) =>
                    //                                       coreItem
                    //                                           .coreChave ==
                    //                                       'textDark')
                    //                                   .first
                    //                                   .coreValor
                    //                                   .toString())),
                    //                   maxLines: 2,
                    //                 ),
                    //               ),
                    //               const SizedBox(height: 15),
                    //               Container(
                    //                 child: Text(
                    //                   'R\$ ${_oferta.OfertaPreco?.toStringAsFixed(2).replaceAll('.', ',') ?? ''}',
                    //                   textAlign: TextAlign.center,
                    //                   style: TextStyle(
                    //                     fontWeight: FontWeight.w700,
                    //                     fontSize: 14,
                    //                     color: _loginController
                    //                         .colorFromHex(_loginController
                    //                             .listCore
                    //                             .where((coreItem) =>
                    //                                 coreItem.coreChave ==
                    //                                 'backDark')
                    //                             .first
                    //                             .coreValor
                    //                             .toString()),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // )
                    )
            ]
                        //),
                        //    ]
                        )));
            // ));
            //},
            //);
          }
        });
  }
}
