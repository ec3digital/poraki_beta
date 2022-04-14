import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/pedido.dart';
import 'package:poraki/app/data/models/sql/sqlPedido.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/home/widgets/gradient_header_home.dart';
import 'package:poraki/app/theme/app_theme.dart';

import '../order_controller.dart';

// ignore: must_be_immutable
class ListOrderItems extends StatelessWidget {
  final sqlPedido? sqlPed;
  final Pedido? ped;
  final OrderController orderController = Get.find(); //put(OrderController());

  ListOrderItems({Key? key, this.sqlPed, this.ped}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Future<void> loadDataItem() async {
      if (sqlPed != null) {
        await orderController.carregaPedidoLocalItems(sqlPed!.pedidoGUID.toString());
        print('qtd itens pedido sql: ' + orderController.listaPedidosItems.length.toString());
      }
      else {
        await orderController.carregaPedidoCloudItems(ped!.PedidoGUID.toString());
        print('qtd itens pedido cloud: ' + orderController.listaPedidosItemsCloud.length.toString());
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

            //return SingleChildScrollView(
                // child: GradientHeaderHome(
                //     child: Column(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //   SizedBox(height: 20),
                //   Center(child: Text("Items do pedido")),
                //   SizedBox(height: 20),
                //    Scrollbar(
                  //   child: ListView.builder(
                  //     scrollDirection: Axis.vertical,
                  //     shrinkWrap: true,
                  //     //scrollDirection: Axis.vertical,
                  //     // padding: const EdgeInsets.all(16.0),
                  //     itemCount: orderController.listaPedidosItems.length,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       //if (index.isOdd) return const Divider();
                  //       //index = index ~/ 2 + 1;
                  //       sqlPedido pedido = orderController.listaPedidosItems[index];
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
                   //)])));
          }
        });
  } //),;
  //);//);
  // ])));

  //});

  //}

  checkoutItem() {
    //print('items qt: ' + orderController.listaPedidosItems.length.toString());

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
            itemCount: sqlPed != null ? orderController.listaPedidosItems.length : orderController.listaPedidosItemsCloud.length,
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

            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/pholder.png',
              image: sqlPed != null ? orderController.listaPedidosItems[index].ofertaImgPath.toString() : orderController.listaPedidosItemsCloud[index].OfertaImgPath.toString(),
              imageErrorBuilder: (context, url, error) => new Icon(Icons.local_offer_outlined),
              height: 30, fit: BoxFit.fitHeight,
            ),

            // child: Image.network(
            //   orderController.listaPedidosItems[index].ofertaImgPath.toString(),
            //   height: 30,
            //   fit: BoxFit.fitHeight,
            // ),

            decoration:
                BoxDecoration(border: Border.all(color: colorText, width: 1)),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
              child: Text(sqlPed != null ?
            orderController.listaPedidosItems[index].ofertaTitulo : orderController.listaPedidosItemsCloud[index].OfertaTitulo,
            style: TextStyle(
                fontSize: 16,
                color: colorText,
                fontWeight: FontWeight.w500),
          )),
          Text(sqlPed != null ?
            orderController.listaPedidosItems[index].ofertaQtd.toString() : orderController.listaPedidosItemsCloud[index].OfertaQtd.toString(),
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
          Text(sqlPed != null ? "R\$ " + orderController.listaPedidosItems[index].ofertaPreco.toStringAsFixed(2) :
          "R\$ " + orderController.listaPedidosItemsCloud[index].OfertaPreco.toStringAsFixed(2),
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
