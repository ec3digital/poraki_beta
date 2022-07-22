import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/pedido.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import '../order_controller.dart';

class ListOrderItems extends StatelessWidget {
  final Pedido ped;
  ListOrderItems({Key? key,
    required this.ped,
  }) : super(key: key);

  OrderController orderController = Get.find();

  @override
  Widget build(BuildContext context) {
    var xPedido =
    ModalRoute.of(context)?.settings.arguments as List<Map<String, Pedido>>;

    Pedido pedidoSingle = xPedido.first.values.first;

    Future<void> loadDataItem() async {
      print('loadDataItem()');
      if (pedidoSingle.PedidoPagtoEm == '') {
        await orderController.carregaPedidoLocalItems(pedidoSingle.PedidoGUID.toString());
      }
      else {
        await orderController.carregaPedidoCloudItems(pedidoSingle.PedidoGUID.toString());
      }
    }

    return FutureBuilder(
        future: loadDataItem(),
        builder: (context, futuro) {
          if (futuro.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); //Text('carrinho vazio'));
            // } else if (futuro.hasError) {
            //   return Center(child: Text(futuro.error.toString()));
          } else {
                  return Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: ListView(
                            children: <Widget>[
                              checkoutItem(),
                            ],
                          ),
                        ),
                        flex: 90,
                      ),
                    ],
                  //)
          );
          }
        });
  }

  checkoutItem() {
    LoginController _loginController = Get.find();
    Color colorText = _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'textDark').first.coreValor.toString());

    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: colorText)),
          padding: EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
          child: ListView.builder(
            itemBuilder: (context, position) {
              return checkoutListItem(position, colorText);
            },
            itemCount: orderController.listaPedidoItems.length,
            shrinkWrap: true,
            primary: false,
            scrollDirection: Axis.vertical,
          ),
        ),
      ),
    );
  }

  checkoutListItem(int index, Color colorText) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Container(
            child: CachedNetworkImage(
              imageUrl: orderController.listaPedidoItems[index].OfertaImgPath.toString(),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Icon(Icons.local_offer_outlined),
              height: 30, fit: BoxFit.fitHeight,
            ),

            // child: FadeInImage.assetNetwork(
            //   placeholder: 'assets/images/pholder.png',
            //   image: orderController.listaPedidoItems[index].OfertaImgPath.toString(),
            //   imageErrorBuilder: (context, url, error) => new Icon(Icons.local_offer_outlined),
            //   height: 30, fit: BoxFit.fitHeight,
            // ),

            decoration:
                BoxDecoration(border: Border.all(color: colorText, width: 1)),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
              child: Text(this.orderController.listaPedidoItems[index].OfertaTitulo,
            style: TextStyle(
                fontSize: 16,
                color: colorText,
                fontWeight: FontWeight.w500),
          )),
          Text(orderController.listaPedidoItems[index].OfertaQtd.toString(),
            style: TextStyle(
                fontSize: 16,
                color: colorText,
                fontWeight: FontWeight.w900),
          ),
          Text(
            ' x ',
            style: TextStyle(
                fontSize: 16,
                color: colorText,
                fontWeight: FontWeight.w900),
          ),
          Text("R\$ " + orderController.listaPedidoItems[index].OfertaPreco.toStringAsFixed(2).replaceAll(',', '').replaceAll('.', ','),
            style: TextStyle(
                fontSize: 16,
                color: colorText,
                fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}
