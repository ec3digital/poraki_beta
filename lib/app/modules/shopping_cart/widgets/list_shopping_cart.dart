import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/offers/offers_controller.dart';
import 'package:poraki/app/routes/app_routes.dart';
import '../shopping_cart_controller.dart';
import 'numeric_button_widget.dart';

class ListShoppingCart extends StatefulWidget {
  ListShoppingCart({
    Key? key,
    required this.controller,
  }) : super(key: key);

  ShoppingCartController controller =
      Get.find(); // Get.put(ShoppingCartController());

  @override
  _ListShoppingCartState createState() => _ListShoppingCartState();
}

class _ListShoppingCartState extends State<ListShoppingCart> {
  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.find();
    Color linkText = _loginController.colorFromHex(_loginController.listCore
        .where((coreItem) => coreItem.coreChave == 'backDark')
        .first
        .coreValor
        .toString());
    Color darkText = _loginController.colorFromHex(_loginController.listCore
        .where((coreItem) => coreItem.coreChave == 'textDark')
        .first
        .coreValor
        .toString());

    return FutureBuilder(
        future: widget.controller.carregaCarrinho(),
        builder: (context, futuro) {
          print('cart qty:' +
              widget.controller.listShoppingCart.length.toString());

          if (futuro.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); //Text('carrinho vazio'));
            // } else if (futuro.hasError) {
            //   return Center(child: Text(futuro.error.toString()));
          } else {
            if (widget.controller.listShoppingCart.length == 0) {
              return Center(
                  child: Text(
                "carrinho vazio",
                style: TextStyle(fontSize: 22, color: darkText),
              ));
            } else {
              return ListView.builder(
                  itemCount: widget.controller.listShoppingCart.length,
                  itemBuilder: (context, index) {
                    widget.controller.qty =
                        widget.controller.listShoppingCart[index].qty;
                    return Card(
                      child: Container(
                        //height: Get.height *
                        padding: const EdgeInsets.only(bottom: 15),
                        color: Colors.white,
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 15, top: 15),
                              child: Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      widget.controller.listShoppingCart[index]
                                          .picture,
                                      height: 60,
                                      //scale: 5.5,
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Text(
                                          widget.controller
                                              .listShoppingCart[index].name,
                                          style: TextStyle(
                                              fontSize: 18, color: darkText)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(right: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(width: 05),
                                  Text(
                                      'R\$ ${widget.controller.listShoppingCart[index].totalValue.toStringAsFixed(2).replaceAll(',', '').replaceAll('.', ',')}',
                                      style: TextStyle(
                                          fontSize: 18, color: darkText)),
                                ],
                              ),
                            ),
                            Container(
                              child: NumericStepButton(
                                maxValue: 20,
                                num: widget.controller.qty,
                                onChanged: (value) {
                                  widget.controller.qty = value;
                                  widget.controller.listShoppingCart[index]
                                      .totalValue = widget.controller
                                          .listShoppingCart[index].value *
                                      value;

                                  var id = int.parse(widget
                                      .controller.listShoppingCart[index].id
                                      .toString());

                                  Future.wait(
                                      [widget.controller.changeQty(id, value)]);

                                  setState(() {});

                                  widget.controller.refresh();
                                  widget.controller.update();
                                },
                              ),
                            ),
                            Divider(),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      widget.controller.deleteItemFromCarrinho(
                                          widget.controller
                                              .listShoppingCart[index].id);
                                      widget.controller.carregaCarrinho();
                                      // widget.controller.
                                      setState(() {});
                                    },
                                    child: Text('Excluir',
                                        style: TextStyle(
                                            fontSize: 15, color: linkText)),
                                  ),
                                  const SizedBox(width: 30),
                                  GestureDetector(
                                    onTap: () {
                                      OffersController offersController =
                                          Get.find();
                                      Future.wait([
                                        offersController.getOffersBySeller(
                                            'eyCv21RfaURoMn0SUndCg6LPyJP2')
                                      ]);

                                      Get.toNamed(AppRoutes.offers, arguments: [
                                        {'category': null},
                                        {'title': null}
                                      ]);
                                    },
                                    //}//TODO: falta fazer fkid
                                    child: Text(
                                        'Ver outros produtos deste vendedor',
                                        style: TextStyle(
                                            fontSize: 15, color: linkText)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
          }
        });
  }
}
