import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:poraki/app/data/models/pedido.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';

class BottomOrder extends StatelessWidget {
  final Pedido ped;
  BottomOrder({
    Key? key,
    required this.ped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var xPedido =
        ModalRoute.of(context)?.settings.arguments as List<Map<String, Pedido>>;

    Pedido pedidoSingle = xPedido.first.values.first;
    LoginController _loginController = Get.find();
    Color colorText = _loginController.colorFromHex(_loginController.listCore
        .where((coreItem) => coreItem.coreChave == 'textDark')
        .first
        .coreValor
        .toString());

    return Card(
      color: _loginController.colorFromHex(_loginController.listCore
          .where((coreItem) => coreItem.coreChave == 'backDark')
          .first
          .coreValor
          .toString()),
      margin: const EdgeInsets.all(0),
      elevation: 4,
      child: Container(
        width: Get.width,
        height: Get.height * 0.30,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Row(
                children: [
                  // Text(
                  //   'Envio: ',
                  //   style: Get.textTheme.bodyText1!.copyWith(
                  //     color: AppColors.primaryColor,
                  //     fontWeight: FontWeight.w500,
                  //     fontSize: 15,
                  //   ),
                  // ),
                  Text(
                    'Pedido realizado em: ' +
                        DateFormat("dd/MM/yyyy HH:mm").format(
                            DateTime.parse(pedidoSingle.PedidoEm.toString())),
                    // 'Rua tal com tal coisa 85, São Paulo',
                    style: TextStyle(
                      color: colorText,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(color: colorText, fontSize: 20),
                  ),
                  Text(
                    'R\$ ' +
                        double.parse(pedidoSingle.PedidoValorTotal.toString())
                            .toStringAsFixed(2).replaceAll(',', '').replaceAll('.', ',')
                            .replaceAll('.', ','),
                    style: TextStyle(color: colorText, fontSize: 20),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Pago por ' + pedidoSingle.PedidoFormaPagto.toString(),
              style: TextStyle(
                color: colorText,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Entregue no endereço ',
              style: TextStyle(color: colorText),
            ),
            const SizedBox(height: 5),
            Text(
              pedidoSingle.PedidoEndereco.toString(),
              style: TextStyle(
                color: colorText,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // createAddressText(String strAddress, double topMargin, Color colorText) {
  //   return Container(
  //       margin: EdgeInsets.only(top: topMargin),
  //       child: Text(
  //         strAddress,
  //         style: Get.textTheme.bodyText1!.copyWith(
  //           fontSize: 16,
  //           fontWeight: FontWeight.normal,
  //           color: colorText
  //         ),
  //       ));
  // }

  //
  // priceSection() {
  //   return Container(
  //     margin: EdgeInsets.all(4),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.all(Radius.circular(4)),
  //     ),
  //     child: Card(
  //       elevation: 0,
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(4))),
  //       child: Container(
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.all(Radius.circular(4)),
  //             border: Border.all(color: Colors.grey.shade200)),
  //         padding: EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             SizedBox(
  //               height: 4,
  //             ),
  //             Text(
  //               "VALOR DETALHADO",
  //               style: Get.textTheme.bodyText1!.copyWith(
  //                   fontSize: 16,
  //                   color: AppColors.primaryColor,
  //                   fontWeight: FontWeight.w900),
  //             ),
  //             SizedBox(
  //               height: 4,
  //             ),
  //             Container(
  //               width: double.infinity,
  //               height: 0.5,
  //               margin: EdgeInsets.symmetric(vertical: 4),
  //               color: Colors.grey.shade400,
  //             ),
  //             SizedBox(
  //               height: 8,
  //             ),
  //             createPriceItem("Total Produtos", getFormattedCurrency(widget.controller.cartTotalItems)),
  //             createPriceItem("Descontos", getFormattedCurrency(widget.controller.cartDiscount)),
  //             createPriceItem("Taxas", getFormattedCurrency(widget.controller.cartTaxes)),
  //             // createPriceItem("TOTAL", getFormattedCurrency(widget.controller.cartTotal)),
  //             createPriceItem("Taxa Entrega", getFormattedCurrency(widget.controller.cartDelivery)),
  //             SizedBox(
  //               height: 8,
  //             ),
  //             Container(
  //               width: double.infinity,
  //               height: 0.5,
  //               margin: EdgeInsets.symmetric(vertical: 4),
  //               color: Colors.grey.shade400,
  //             ),
  //             SizedBox(
  //               height: 8,
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: <Widget>[
  //                 Text(
  //                   "TOTAL GERAL",
  //                   style: Get.textTheme.bodyText1!.copyWith(
  //                       fontSize: 16,
  //                       color: AppColors.primaryColor,
  //                       fontWeight: FontWeight.w900),
  //                 ),
  //                 Text(
  //                   getFormattedCurrency(widget.controller.cartTotal),
  //                 )
  //               ],
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  String getFormattedCurrency(double amount) {
    return "R\$ " + amount.toStringAsFixed(2).replaceAll(',', '').replaceAll('.', ',');
    // FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(amount: amount);
    // fmf.symbol = "₹";
    // fmf.thousandSeparator = ",";
    // fmf.decimalSeparator = ".";
    // fmf.spaceBetweenSymbolAndNumber = true;
    // return fmf.formattedLeftSymbol;
  }
}
