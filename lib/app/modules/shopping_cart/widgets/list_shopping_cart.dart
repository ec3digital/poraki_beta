import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/app_theme.dart';
import '../shopping_cart_controller.dart';
import 'container_dialog_quantity_shopping_cart.dart';

class ListShoppingCart extends StatefulWidget {
  ListShoppingCart({
    Key? key,
    required this.controller,
  }) : super(key: key);

  ShoppingCartController controller = Get.put(ShoppingCartController());

  @override
  _ListShoppingCartState createState() => _ListShoppingCartState();
}

class _ListShoppingCartState extends State<ListShoppingCart> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.controller.carregaCarrinho(),
        builder: (context, futuro) {
          if (futuro.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); //Text('carrinho vazio'));
          // } else if (futuro.hasError) {
          //   return Center(child: Text(futuro.error.toString()));
          }
          else {
          print('qtd: ' + widget.controller.listShoppingCart.length.toString());

            return ListView.builder(
                itemCount: widget.controller.listShoppingCart.length,
                itemBuilder: (context, index) {
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
                                    widget.controller.listShoppingCart[index].picture,
                                    height: 60,
                                    //scale: 5.5,
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    widget.controller.listShoppingCart[index].name,
                                    style: Get.textTheme.bodyText1!.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ContainerDialogShoppingCart(
                                    controller: widget.controller),
                                Text(
                                    'R\$ ${widget.controller.listShoppingCart[index].value}')
                              ],
                            ),
                          ),
                          Divider(),
                          //Container(height: 1, color: Colors.grey,),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {},
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
                                  onTap: () {},
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
         );
   }
 }
