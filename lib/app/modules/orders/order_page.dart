import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/pedido.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/orders/widgets/app_order.dart';
import 'package:poraki/app/modules/orders/widgets/list_order_items.dart';
import 'widgets/bottom_order.dart';

class OrderPage extends StatelessWidget {
  final Pedido? ped;
  OrderPage({Key? key, this.ped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.find();

    var args = ModalRoute.of(context)?.settings.arguments
    as List<Map<String, Pedido>>;
    Pedido pedido = args.first.values.first;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Container(
            decoration: new BoxDecoration(
              color: _loginController.colorFromHex(_loginController.listCore
                  .where((coreItem) => coreItem.coreChave == 'backLight')
                  .first
                  .coreValor
                  .toString()),
            //     gradient: new LinearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            //   colors: [
            //     _loginController.colorFromHex(_loginController.listCore
            //         .where((coreItem) => coreItem.coreChave == 'backLight')
            //         .first
            //         .coreValor
            //         .toString()),
            //     _loginController.colorFromHex(_loginController.listCore
            //         .where((coreItem) => coreItem.coreChave == 'backDark')
            //         .first
            //         .coreValor
            //         .toString()),
            //   ],
            // )
            ),
            child: ListOrderItems(ped: pedido),
          )),
        ],
      ),
      bottomNavigationBar: BottomOrder(ped: pedido),
      appBar: appBarOrder(),
    );
  }
}