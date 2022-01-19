import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/sql/sqlPedido.dart';
import 'package:poraki/app/modules/orders/order_controller.dart';
import '../../../theme/app_theme.dart';

class BottomOrder extends StatelessWidget {
  final sqlPedido pedido;
  BottomOrder({
    Key? key, required this.pedido,
  }) : super(key: key);

  // sqlPedido? pedidoAtual;
  // OrderController _controller = Get.put(OrderController());
  //
  // Future<void> getPedidoAtual() async {
  //   await _controller.buscaPedido('c09cd10b-5aa2-43c2-bb42-10031c0d4280');
  //   pedidoAtual = _controller.pedido;
  // }

  @override
  Widget build(BuildContext context) {
    final gPedido = Get.arguments as List<Map<String, String>>;
    print('gpedido bottom: ' + gPedido.toString());

    // return FutureBuilder(
    //     future: getPedidoAtual(),
    //     builder: (context, futuro) {
    //       if (futuro.connectionState == ConnectionState.waiting) {
    //         return Center(
    //             child: CircularProgressIndicator()); //Text('carrinho vazio'));
    //         // } else if (futuro.hasError) {
    //         //   return Center(child: Text(futuro.error.toString()));
    //       }
    //       else {
            return Card(
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
                            'Pedido realizado em: ' + gPedido[0]['pedidoEm'].toString(),
                            // 'Rua tal com tal coisa 85, São Paulo',
                            style: Get.textTheme.bodyText1!.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
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
                          Text('Total'),
                          Text('R\$ ' + gPedido[0]['pedidoValorTotal'].toString(),
                          )],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Pago por: ' + gPedido[0]['pedidoFormaPagto'].toString(),
                      style: Get.textTheme.bodyText1!.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Entregue no endereço: ' + gPedido[0]['pedidoEndereco'].toString(),
                      style: Get.textTheme.bodyText1!.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        //}
  //   );
  // }


  createAddressText(String strAddress, double topMargin) {
    return Container(
        margin: EdgeInsets.only(top: topMargin),
        child: Text(
          strAddress,
          style: Get.textTheme.bodyText1!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: AppColors.primaryColor,
          ),
        ));
  }

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
    return "R\$ " + amount.toStringAsFixed(2);
    // FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(amount: amount);
    // fmf.symbol = "₹";
    // fmf.thousandSeparator = ",";
    // fmf.decimalSeparator = ".";
    // fmf.spaceBetweenSymbolAndNumber = true;
    // return fmf.formattedLeftSymbol;
  }


}
