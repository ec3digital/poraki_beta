import 'package:get/get.dart';
import 'package:poraki/app/data/models/sql/sqlCarrinho.dart';
import 'package:poraki/app/services/sqlite/sqlporaki_cart_service.dart';
import '../../data/models/shopping_cart_model.dart';
import 'widgets/dialog_amount_shopping_cart.dart';
import 'widgets/dialog_more_unitys_shopping_cart.dart';

class ShoppingCartController extends GetxController {
  int tabBarLenght = 0;
  bool change = false;
  var listShoppingCart = [];
  String moreQuantity = '';

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

    List<sqlCarrinho> carrinho = await sqlPorakiCartService().carrinho();
    // listShoppingCart = [];

    // for(var c in carrinho) {
    //   print('for');
    carrinho.forEach((element) {
      print('foreach: ' + element.ofertaImgPath.toString());
      //print(element.values['ofertaTitulo'].toString());
      listShoppingCart.add(new ShoppingCartModel(
        element.ofertaTitulo.toString(),
        'https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/ofertas%2F' +
            element.ofertaId.toString() +
            '.jpg?alt=media',
        10.0,
      ));
    });

    // return carrinho;
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
