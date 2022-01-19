import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/sql/sqlCarrinho.dart';
import 'package:poraki/app/data/models/sql/sqlPedido.dart';
import 'package:poraki/app/data/models/sql/sqlPedidoItem.dart';
import 'package:poraki/app/services/sqlite/sqlporaki_cart_service.dart';
import 'package:poraki/app/services/sqlite/sqlporaki_pedido_service.dart';
import '../../data/models/shopping_cart_model.dart';
import 'widgets/dialog_amount_shopping_cart.dart';
import 'widgets/dialog_more_unitys_shopping_cart.dart';

class ShoppingCartController extends GetxController {
  //int tabBarLenght = 0;
  String ctrlMsg = '';
  bool change = false;
  var listShoppingCart = [];
  String moreQuantity = '';
  int qty = 0;
  double cartTotal = 0;
  double cartDiscount = 0;
  double cartTaxes = 0;
  double cartTotalItems = 0;
  double cartDelivery = 0;

  final TextEditingController txtQty = new TextEditingController();

  changeMoreQuantity(String? value) {
    moreQuantity = value!;
    update();
  }

  @override
  void onInit() async {
    //await carregaCarrinho();
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
        element.categoriaChave
      ));
    });

    calcTotal();
    update();
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

  Future<void> calcTotal() async {
    cartTotal = 0;
    await calcTotalItems(); await calcTaxes(); await calcDelivery(); await calcDiscount();
    cartTotal = ((cartTotalItems + cartDelivery) + cartTaxes) - cartDiscount;
  }

  Future<void> calcDiscount() async {
    cartDiscount = 0;
  }

  Future<void> calcTaxes() async {
    cartTaxes = 0;
  }

  Future<void> calcTotalItems() async {
    cartTotalItems = 0;
    listShoppingCart.forEach((element) {
      cartTotalItems += element.value;
    });
  }

  Future<void> calcDelivery() async {
    cartDelivery = 3;
  }

  Future<void> saveBuy() async {
    ctrlMsg = '';

    var orderService = new sqlPorakiPedidoService();

    await _saveOrder(orderService);
    await _saveOrderItems(orderService);

    ctrlMsg = 'Pedido foi realizado, obrigado!';
  }

  _saveOrder(sqlPorakiPedidoService orderSvc) async {

    orderSvc.insertOrder(new sqlPedido(
      null, //pedidoGUID,
      'c09cd10b-5aa2-43c2-bb42-10031c0d4280', //pedidoVendedorGUID,
      'danilojazz@gmail.com', // pedidoVendedorEmail,
      DateTime.now().toString(), //pedidoEm,
      cartTotal.toString(), //pedidoValorTotal,
      "Cartão", //pedidoFormaPagto,
      0, //pedidoCancelada,
      '', // pedidoPagtoEm,
      'Danilo Santos', // pedidoPessoaNome,
      'danilojazz@gmail.com', // pedidoPessoaEmail,
      'c09cd10b-5aa2-43c2-bb42-10031c0d4280', //pedidoUsuGUID,
      0, //pedidoAval,
      null, //pedidoAvalEm,
      'R\$', //pedidoMoeda,
      '05735-030', // //pedidoCEP,
      'Rua Carlos Magalhães', // pedidoEndereco,
      '100', // pedidoNumero,
      'ap 55 Bloco 2', //pedidoCompl,
      null, //pedidoAutoriza,
      null, //pedidoInstituicao,
      DateTime.now().toString(), //pedidoEntregaPrevista,
      null, //pedidoEntregaRealizadaEm,
      null, //pedidoEntregaPorUsuEmail,
      null, //pedidoEntregaPorUsuNome
    )
    );
  }

  _saveOrderItems(sqlPorakiPedidoService orderSvc) async{
    print('_saveOrderItems');
    listShoppingCart.forEach((element) {
      orderSvc.insertOrderItem(new sqlPedidoItem(
          '', // pedidoItemGUID,
          'c09cd10b-5aa2-43c2-bb42-10031c0d4280', //pedidoGUID,
          // 0, //ofertaId,
          'c09cd10b-5aa2-43c2-bb42-10031c0d4280', //ofertaGuid,
          element.name, // ofertaTitulo,
          '05735-030', // ofertaCEP,
          0, //ofertaVendedorId,
          element.value, // ofertaPreco,
          element.qty, // ofertaQtd,
          0, //double.parse(element.value) * double.parse(element.qty), // ofertaTotal,
          element.picture, // ofertaImgPath,
          element.categChave, //categoriaChave,
          0, //ofertaCancelada,
          '', // ofertaEntregueEm
      )
      );
    });

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
