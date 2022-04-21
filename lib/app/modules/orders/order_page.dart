import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/pedido.dart';
import 'package:poraki/app/data/models/sql/sqlPedido.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/home/home_controller.dart';
import 'package:poraki/app/modules/orders/widgets/app_order.dart';
import 'package:poraki/app/modules/orders/widgets/list_order_items.dart';
import 'widgets/bottom_order.dart';

class OrderPage extends StatelessWidget {
  final HomeController controller = Get.find();
  // final sqlPedido? sqlPed;
  final Pedido? ped;
  OrderPage({Key? key, this.ped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final gPedido = Get.arguments as List<Map<String, String>>;
    // print('gpedido: ' + gPedido.toString());

    //this.ped = gPedido.first as Pedido;

    var args = ModalRoute.of(context)?.settings.arguments
    as List<Map<String, Pedido>>;

    Pedido pedido = args.first.values.first;

    LoginController _loginController = Get.find();

    // sqlPedido? pedNew;
    // gPedido.forEach((item) {
    //   pedNew = new sqlPedido(
    //       item[0],
    //       item[1],
    //       item[2].toString(),
    //       item[3].toString(),
    //       item[4].toString(),
    //       item[5],
    //       0,
    //       item[7].toString(),
    //       item[8].toString(),
    //       item[9].toString(),
    //       item[10],
    //       0,
    //       item[12],
    //       item[13],
    //       item[14].toString(),
    //       item[15],
    //       item[16],
    //       item[17],
    //       item[18],
    //       item[19],
    //       item[20],
    //       item[21],
    //       item[22],
    //       item[22].toString());
    // });

    print('pedido dentro da order page: ' + pedido.toString());
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Container(
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                _loginController.colorFromHex(_loginController.listCore
                    .where((coreItem) => coreItem.coreChave == 'backLight')
                    .first
                    .coreValor
                    .toString()),
                _loginController.colorFromHex(_loginController.listCore
                    .where((coreItem) => coreItem.coreChave == 'backDark')
                    .first
                    .coreValor
                    .toString()),
              ],
            )),
            child: ListOrderItems(ped: pedido),
          )),
        ],
      ),
      bottomNavigationBar: BottomOrder(ped: pedido),
      appBar: appBarOrder(),
    );
  }
}