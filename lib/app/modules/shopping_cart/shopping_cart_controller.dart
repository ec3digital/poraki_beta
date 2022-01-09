import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/sql/sqlCarrinho.dart';
import 'package:poraki/app/services/sqlite/sqlporaki_cart_service.dart';
import '../../data/models/shopping_cart_model.dart';
import 'widgets/dialog_amount_shopping_cart.dart';
import 'widgets/dialog_more_unitys_shopping_cart.dart';

class ShoppingCartController extends GetxController {
  //int tabBarLenght = 0;
  bool change = false;
  var listShoppingCart = [];
  String moreQuantity = '';
  int qty = 0;

  final TextEditingController txtQty = new TextEditingController();

  changeMoreQuantity(String? value) {
    moreQuantity = value!;
    update();
  }

  @override
  void onInit() async {
    await carregaCarrinho();
    super.onInit();
  }

  Future<void> carregaCarrinho() async {
    print('carregaCarrinho');
    // txtQty.text = "1";

    listShoppingCart.clear();
    List<sqlCarrinho> carrinho = await sqlPorakiCartService().carrinho();

    carrinho.forEach((element) {
      listShoppingCart.add(new ShoppingCartModel(
        element.ofertaTitulo.toString(),
        'https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/ofertas%2F' +
            element.ofertaId.toString() +
            '.jpg?alt=media',
        double.parse(element.ofertaPreco),
          element.ofertaId.toString(),
        int.parse(element.ofertaQtd),
      ));
    });
  }

  Future<void> esvaziaCarrinho() async {
    await sqlPorakiCartService().deleteCarrinho();
    await carregaCarrinho();
  }

  Future<void> deleteItemFromCarrinho(String id) async {
    await sqlPorakiCartService().deleteItemCarrinho(int.parse(id));
    await carregaCarrinho();
  }

  Future<void> atualizaQtdItemCarrinho(int id, int qtd) async {
    await sqlPorakiCartService().updateItemCarrinho(id, qtd);
    await carregaCarrinho();
  }


  //
  //   Future<List<sqlCarrinho>> carregaItensCarrinho() async {
  //     print('carregaCarrinho');
  //
  //     List<sqlCarrinho>? carrinho = await sqlPorakiCartService().carrinho();
  //     // listShoppingCart = [];
  //
  //     // for(var c in carrinho) {
  //     //   print('for');
  //     carrinho!.forEach((element) {
  //       print('foreach');
  //       //print(element.values['ofertaTitulo'].toString());
  //       listShoppingCart.add(new ShoppingCartModel(
  //         element.ofertaTitulo.toString(),
  //         element.ofertaImgPath.toString(),
  //         element.ofertaPreco as double,
  //       ));
  //     }
  //     );
  //
  //     return carrinho;
  //   // }
  // }


  showDialog() {
    Get.dialog(DialogAmountShoppingCart(Get.find()));
  }

  showDialogMoreUnitys() {
    Get.back();
    Get.dialog(DialogMoreUnitysShoppingCart(Get.find()));
  }

  cgsfgs() {}

  // = [
  //   ShoppingCartModel('Xiaomi mi 11 Lite', 'assets/images/poraki_small.png', 1.528),
  //   ShoppingCartModel('Xiaomi mi 11 Lite', 'assets/images/poraki_small.png', 1.528),
  //   ShoppingCartModel('Xiaomi mi 11 Lite', 'assets/images/poraki_small.png', 1.528),
  //   ShoppingCartModel('Xiaomi mi 11 Lite', 'assets/images/poraki_small.png', 1.528),
  //   ShoppingCartModel('Xiaomi mi 11 Lite', 'assets/images/poraki_small.png', 1.528),
  // ];

}
