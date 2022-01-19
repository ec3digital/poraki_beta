// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:poraki/app/data/models/sql/sqlCarrinho.dart';
// import 'package:poraki/app/data/models/sql/sqlPedido.dart';
// import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
// import 'package:poraki/app/modules/offers/widgets/detail_offer.dart';
// import 'package:poraki/app/modules/orders/order_controller.dart';
// import 'package:poraki/app/modules/orders/widgets/bottom_order.dart';
// import 'package:poraki/app/routes/app_routes.dart';
// import 'package:poraki/app/services/sqlite/sqlporaki_cart_service.dart';
// import 'package:poraki/app/theme/app_theme.dart';
// import '../../../data/models/produto_oferta.dart';
//
// // ignore: must_be_immutable
// class BodyOrder extends StatelessWidget {
//   final int offerId;
//   BodyOrder({Key? key, required this.offerId}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     //OffersController offersController = Get.put(OffersController());
//     OrderController orderController = Get.find();
//
//
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: ListShoppingCart(controller: controller),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomOrder(),
//     );
//
//     return Container(
//       child: GetBuilder<OrderController>(builder: (context) {
//         if (orderController.isLoading) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         } else {
//           //offersController.getOfferById(4);
//           orderController.buscaPedido('c09cd10b-5aa2-43c2-bb42-10031c0d4280');
//           sqlPedido pedido = orderController.pedido;
//
//           //listaPedidosItems
//
//           return SingleChildScrollView(
//             child: Container(
//               margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Align(
//                     alignment: Alignment.topLeft,
//                     child: Text(
//                       _product.ofertaTitulo.toString(),
//                       textAlign: TextAlign.start,
//                       style: Get.textTheme.bodyText1!
//                           .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   ListPicsOffer(imagesList: offersImages),
//                   const SizedBox(height: 15),
//                   DetailOffer(detailProduct: _product.ofertaDetalhe),
//                   SizedBox(height: 10),
//                   Text(
//                     'R\$ ${_product.ofertaPreco?.toStringAsFixed(2) ?? ''}',
//                     style: Get.textTheme.bodyText1!.copyWith(
//                       fontSize: 25,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Text('Quantidade: 1'),
//                   SizedBox(height: 10),
//                   ButtonOffer(
//                     onPressed: () {
//                       sqlPorakiCartService().insertItemCarrinho(new sqlCarrinho(
//                           _product.ofertaID.toString(),
//                           '', //ofertaGUID,
//                           _product.ofertaTitulo.toString(),
//                           _product.ofertaCEP.toString(),
//                           '', //ofertaVendedorGUID,
//                           _product.ofertaPreco.toString(),
//                           '1', //ofertaQtd,
//                           _product.ofertaImgPath.toString(),
//                           _product.categoriaChave.toString(),
//                           DateTime.now().add(new Duration(hours: 1)).toString() // adiciona 1h
//                       ));
//
//                       Get.toNamed(AppRoutes.shoppingCart);
//                     },
//                     colorText: Colors.white,
//                     text: 'Comprar agora',
//                     colorButton: AppColors.primaryColor,
//                   ),
//                   ButtonOffer(
//                     onPressed: () {
//                       sqlPorakiCartService().insertItemCarrinho(new sqlCarrinho(
//                           _product.ofertaID.toString(),
//                           '', //ofertaGUID,
//                           _product.ofertaTitulo.toString(),
//                           _product.ofertaCEP.toString(),
//                           '', //ofertaVendedorGUID,
//                           _product.ofertaPreco.toString(),
//                           '1', //ofertaQtd,
//                           _product.ofertaImgPath.toString(),
//                           _product.categoriaChave.toString(),
//                           DateTime.now().add(new Duration(hours: 1)).toString() // adiciona 1h
//                       ));
//
//                       Get.toNamed(
//                         AppRoutes.shoppingCart,
//                       );
//                     },
//                     colorText: AppColors.primaryColor,
//                     text: 'Adicionar ao carrinho',
//                     colorButton: AppColors.grayBlueButton,
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//       }),
//     );
//   }
// }
