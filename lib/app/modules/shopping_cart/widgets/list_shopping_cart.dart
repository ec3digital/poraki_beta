import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/routes/app_routes.dart';
import '../../../theme/app_theme.dart';
import '../shopping_cart_controller.dart';
import 'numeric_button_widget.dart';

class ListShoppingCart extends StatefulWidget {
  ListShoppingCart({
    Key? key,
    required this.controller,
  }) : super(key: key);

  ShoppingCartController controller = Get.find(); // Get.put(ShoppingCartController());

  @override
  _ListShoppingCartState createState() => _ListShoppingCartState();
}

class _ListShoppingCartState extends State<ListShoppingCart> {
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: widget.controller.carregaCarrinho(),
        builder: (context, futuro) {
          print('cart qty:' + widget.controller.listShoppingCart.length.toString());


          if (futuro.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); //Text('carrinho vazio'));
            // } else if (futuro.hasError) {
            //   return Center(child: Text(futuro.error.toString()));
          } else {
            if (widget.controller.listShoppingCart.length == 0) {
              return Center(child: Text("carrinho vazio"));
            } else {
              return ListView.builder(
                  itemCount: widget.controller.listShoppingCart.length,
                  itemBuilder: (context, index) {
                    widget.controller.qty = widget.controller.listShoppingCart[index].qty;
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
                                        style:
                                            Get.textTheme.bodyText1!.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
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
                                    'R\$ ${widget.controller.listShoppingCart[index].value?.toStringAsFixed(2) ?? ''}',
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: NumericStepButton(
                                maxValue: 20,
                                num: widget.controller.qty,
                                onChanged: (value) {
                                  widget.controller.qty = value;
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
                                      final ShoppingCartController controller =
                                          Get.find();
                                      controller.deleteItemFromCarrinho(widget
                                          .controller
                                          .listShoppingCart[index]
                                          .id);
                                      widget.controller.carregaCarrinho();
                                      // widget.controller.
                                      setState(() {});
                                    },
                                    child: Text(
                                      'Excluir',
                                      style: Get.textTheme.bodyText1!.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.primaryColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 30),
                                  GestureDetector(
                                    onTap: () => Get.toNamed(AppRoutes.offers,
                                        arguments: [
                                          {'cep': '05735030'},
                                          {'category': null},
                                          {'title': null}
                                        ]), //TODO: falta fazer fkid
                                    child: Text(
                                      'Ver outros produtos deste vendedor',
                                      style: Get.textTheme.bodyText1!.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.primaryColor,
                                        fontSize: 14,
                                      ),
                                    ),
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
