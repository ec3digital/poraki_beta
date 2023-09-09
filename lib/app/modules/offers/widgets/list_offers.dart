//import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
    final OffersController offersController =
        Get.find(); // Get.put(OffersController());
    final LoginController _loginController = Get.find();
    final Color backDark = _loginController.colorFromHex(_loginController
        .listCore
        .where((coreItem) => coreItem.coreChave == 'backDark')
        .first
        .coreValor
        .toString());
    final Color backColor = _loginController.colorFromHex(_loginController
        .listCore
        .where((coreItem) => coreItem.coreChave == 'backLight')
        .first
        .coreValor
        .toString());

    Widget _buildRow(ProdutoOferta oferta) {
      // List<ProdutoOferta>? listOffer = offersController.offers;
      // print('qtd: ${listOffer.isEmpty}');
      // // ignore: unnecessary_null_comparison
      // String _lojaID = listOffer == null ? '' : listOffer.first.lojaID.toString();

      // if(_lojaID != "")
      //   const SizedBox(height: 5),
      // CachedNetworkImage(
      // imageUrl: 'https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/lojas%2F$_lojaID.jpg?alt=media',
      // height: 250,
      // progressIndicatorBuilder:
      // (context, url, downloadProgress) =>
      // CircularProgressIndicator(
      // value: downloadProgress.progress),
      // errorWidget: (context, url, error) =>
      // Icon(Icons.local_offer_outlined),
      // ),
      // const SizedBox(height: 5),

      return Column(children: [
        Container(
          padding: const EdgeInsets.all(2),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: backColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: backColor,
          ),
          child: ListTile(
              leading: CachedNetworkImage(
                imageUrl: _loginController.listCore
                        .where((coreItem) => coreItem.coreChave == 'imgpath')
                        .first
                        .coreValor
                        .toString() +
                    oferta.ofertaGUID.toString() +
                    _loginController.listCore
                        .where(
                            (coreItem) => coreItem.coreChave == 'imgpathsuffix')
                        .first
                        .coreValor
                        .toString(),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) =>
                    Icon(Icons.local_offer_outlined),
                height: 160,
              ),
              onTap: () => Get.toNamed(AppRoutes.offer, arguments: oferta),
              title: Text(oferta.ofertaTitulo.toString()),
              subtitle: Text(oferta.ofertaDetalhe.toString()),
              trailing: Text(
                  'R\$ ${oferta.ofertaPreco?.toStringAsFixed(2).replaceAll(',', '').replaceAll('.', ',') ?? ''}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)),
        ) //const Divider(),
      ]);
    }

    return Expanded(
        child: Container(
            //     color: backDark,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
          const SizedBox(height: 10),
          GetBuilder<OffersController>(builder: (context) {
            if (offersController.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (offersController.offers.length == 0)
                return Container(
                    child: Center(
                        child:
                            Text("Ops, ainda não temos nada por aqui... ;-)")));
              else
                return Expanded(
                    child: Container(
                        child: Scrollbar(
                            child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: offersController.offers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildRow(offersController.offers[index]);
                  },
                ))));
            }
          })
        ])));
  }
}
