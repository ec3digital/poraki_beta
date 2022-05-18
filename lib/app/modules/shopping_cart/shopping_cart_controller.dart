import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/PedidoItem.dart';
import 'package:poraki/app/data/models/enderecos.dart';
import 'package:poraki/app/data/models/pedido.dart';
import 'package:poraki/app/data/models/sql/sqlCarrinho.dart';
import 'package:poraki/app/data/models/sql/sqlPedido.dart';
import 'package:poraki/app/data/models/sql/sqlPedidoItem.dart';
import 'package:poraki/app/data/repositories/order_repository.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/services/sqlite/sqlporaki_cart_service.dart';
import 'package:poraki/app/services/sqlite/sqlporaki_pedido_service.dart';
import '../../data/models/shopping_cart_model.dart';
import 'widgets/dialog_amount_shopping_cart.dart';
import 'widgets/dialog_more_unitys_shopping_cart.dart';

class Sellers<T1, T2> {
  late T1? sellerId;
  late T2? storeId;

  Sellers(this.sellerId, this.storeId);
}

class ShoppingCartController extends GetxController {
  String ctrlMsg = '';
  bool change = false;
  List<ShoppingCartModel> listShoppingCart = [];
  String moreQuantity = '';
  int qty = 0;
  double cartTotal = 0;
  double cartDiscount = 0;
  double cartTaxes = 0;
  RxDouble cartTotalItems = 0.00.obs;
  double cartDelivery = 0;
  String payment = 'Cartao';
  //late Enderecos endereco;
  bool running = false;

  final TextEditingController txtQty = new TextEditingController();
  final LoginController _loginController = Get.find();

  changeMoreQuantity(String? value) {
    moreQuantity = value!;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
  }

  Future<void> increaseQty(int id) async {
    await sqlPorakiCartService().increaseQtyItemCarrinho(id);
    update();
  }

  Future<void> decreaseQty(int id) async {
    await sqlPorakiCartService().increaseQtyItemCarrinho(id);
    update();
  }

  Future<void> changeQty(int id, int qty) async {
    print('changeQty');
    await sqlPorakiCartService().changeQtyItemCarrinho(id, qty);
    await calcTotalItems();
    update();
  }

  Future<void> carregaCarrinho() async {
    print('carregaCarrinho');

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
          element.categoriaChave,
          element.ofertaVendedorGUID.toString(),
          element.ofertaLojaGUID.toString(),
          double.parse(element.ofertaPreco) * int.parse(element.ofertaQtd),
          element.ofertaEntregaPrevEm,
          element.ofertaDetalhe,
          element.ofertaGUID));
    });

    calcTotal();
    update();
  }

  Future<void> esvaziaCarrinho() async {
    await sqlPorakiCartService().deleteCarrinho();
    await carregaCarrinho();
    update();
  }

  Future<void> deleteItemFromCarrinho(String id) async {
    await sqlPorakiCartService().deleteItemCarrinho(int.parse(id));
    await carregaCarrinho();
    update();
  }

  Future<void> calcTotal() async {
    cartTotal = 0;
    await calcTotalItems();
    await calcTaxes();
    await calcDelivery();
    await calcDiscount();
    cartTotal =
        ((double.parse(cartTotalItems.value.toString()) + cartDelivery) +
                cartTaxes) -
            cartDiscount;
  }

  Future<void> calcDiscount() async {
    cartDiscount = 0;
  }

  Future<void> calcTaxes() async {
    cartTaxes = 0;
  }

  Future<void> calcTotalItems() async {
    var tmpCalc = 0.00;
    listShoppingCart.forEach((element) {
      tmpCalc += (element.value * element.qty);
    });

    cartTotalItems.value = tmpCalc;
    update();
    refresh();
  }

  Future<void> calcDelivery() async {
    cartDelivery = 3;
  }

  Future<void> saveBuy() async {
    ctrlMsg = '';

    if (!this.running) {

      var pedidoService = new OrdersRepository();
      var orderService = new sqlPorakiPedidoService();

      List<Sellers<String, String>> vendedoresGUIDs = [];
      listShoppingCart.forEach((ped) {
        if (!vendedoresGUIDs.contains(new Sellers(ped.sellerId, ped.storeId)))
          vendedoresGUIDs.add(new Sellers(ped.sellerId, ped.storeId));
      });

      vendedoresGUIDs.forEach((vendedor) async {
        await _saveOrder(orderService, pedidoService, vendedor);
      });

      running = true;
      ctrlMsg = 'Pedido foi enviado, obrigado!';
    }
  }

  Future<void> _saveOrder(sqlPorakiPedidoService orderSvc,
      OrdersRepository pedidoSvc, Sellers seller) async {
    var pedDate = DateTime.now().toString();
    var endereco = _loginController.listEnderecos.where((end) => end.EnderecoAtual).first;

    List<ShoppingCartModel> cartBySeller = [];

    listShoppingCart.forEach((ped) {
      if (ped.sellerId == seller.sellerId) cartBySeller.add(ped);
    });

    var totalBySeller = 0.00;
    cartBySeller.forEach((pedSeller) {
      totalBySeller += pedSeller.totalValue;
    });

    // sort by eta
    cartBySeller.sort((a, b) => a.deliverIn!.compareTo(b.deliverIn!));

    var pedPost = new Pedido(
      null,
      seller.sellerId,
      '',
      pedDate,
      totalBySeller.toString(),
      payment,
      0,
      '',
      _loginController.usuNome.toString(),
      _loginController.usuEmail.toString(),
      _loginController.usuGuid,
      0,
      null,
      'R\$',
      endereco.EnderecoCEP.toString(),
      endereco.EnderecoLogra,
      endereco.EnderecoNumero,
      endereco.EnderecoCompl,
      '',
      '',
      cartBySeller.first.deliverIn,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
    );

    var pedGuid = await pedidoSvc.postOrder(pedPost);

    print('new pedGuid:  ' + pedGuid);
    //
    // if (pedGuid.toString() != '') {
    //   orderSvc.insertOrder(new sqlPedido(
    //     pedGuid.toString(),
    //     pedPost.PedidoVendedorGUID, //pedidoVendedorGUID,
    //     pedPost.PedidoVendedorEmail, // pedidoVendedorEmail,
    //     pedDate, //pedidoEm,
    //     totalBySeller.toString(), //pedidoValorTotal,
    //     payment, //pedidoFormaPagto,
    //     0, //pedidoCancelada,
    //     pedPost.PedidoAvalEm.toString(), // pedidoPagtoEm,
    //     pedPost.PedidoPessoaNome, // pedidoPessoaNome,
    //     pedPost.PedidoPessoaEmail, // pedidoPessoaEmail,
    //     pedPost.PedidoUsuGUID, //pedidoUsuGUID,
    //     0, //pedidoAval,
    //     null, //pedidoAvalEm,
    //     pedPost.PedidoMoeda, //pedidoMoeda,
    //     pedPost.PedidoCEP, // //pedidoCEP,
    //     pedPost.PedidoEndereco, // pedidoEndereco,
    //     pedPost.PedidoNumero, // pedidoNumero,
    //     pedPost.PedidoCompl, //pedidoCompl,
    //     null, //pedidoAutoriza,
    //     null, //pedidoInstituicao,
    //     pedPost.PedidoEntregaPrevista, //pedidoEntregaPrevista,
    //     null, //pedidoEntregaRealizadaEm,
    //     null, //pedidoEntregaPorUsuEmail,
    //     null, //pedidoEntregaPorUsuNome
    //     null,
    //     null,
    //     null,
    //     null,
    //   ));
    // }

    // salva items na nuvem
    cartBySeller.forEach((pedItem) async {
      PedidoItem pedidoItem = new PedidoItem(
          '',
          pedGuid,
          pedItem.offerGuid,
          pedItem.name,
          endereco.EnderecoCEP.toString(),
          pedItem.sellerId.toString(),
          pedItem.value,
          pedItem.qty.toDouble(),
          pedItem.totalValue,
          pedItem.picture,
          0,
          null,
          pedItem.categChave,
          pedItem.details,
          pedItem.deliverIn,
          null,
          null,
          null,
          null,
          null,
          pedItem.storeId);
      var pedItemGuid = await pedidoSvc.postOrderItem(pedidoItem);

      print('new pedItemGuid:  ' + pedItemGuid);

    //   // salva no sqlite
    //   orderSvc.insertOrderItem(new sqlPedidoItem(
    //       pedItemGuid.toString(),
    //       pedidoItem.PedidoGUID,
    //       pedidoItem.OfertaGuid,
    //       pedidoItem.OfertaTitulo,
    //       pedidoItem.OfertaCEP,
    //       pedidoItem.OfertaVendedorGuid,
    //       pedidoItem.OfertaPreco,
    //       pedidoItem.OfertaQtd,
    //       pedidoItem.OfertaTotal,
    //       pedidoItem.OfertaImgPath,
    //       pedidoItem.CategoriaChave.toString(),
    //       pedidoItem.OfertaDetalhe,
    //       pedidoItem.OfertaPrevisaoEntrega,
    //       null,
    //       null,
    //       null,
    //       null,
    //       null,
    //       null,
    //       null,
    //       pedidoItem.OfertaLojaID));
    });
  }

  showDialog() {
    Get.dialog(DialogAmountShoppingCart(Get.find()));
  }

  showDialogMoreUnitys() {
    Get.back();
    Get.dialog(DialogMoreUnitysShoppingCart(Get.find()));
  }

  cgsfgs() {}
}
