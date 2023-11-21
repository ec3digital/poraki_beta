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
      sqlCarrinho elem = element;
      print('element tit: ' + elem.ofertaTitulo);
      print('element ofertaGUID: ' + elem.ofertaGUID.toString());
      listShoppingCart.add(new ShoppingCartModel(
          element.ofertaTitulo.toString(),
          _loginController.imgPath + element.ofertaId.toString() + _loginController.imgPathSuffix,
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

  Future<String> saveOrder() async {
    var ret = 'Seu pedido foi enviado, por favor aguarde os próximos passos';
    var orderSvc = new OrdersRepository();
    var pedDate = DateTime.now().toString();
    var endereco =
        _loginController.listaEnderecos.where((end) => end.EnderecoAtual).first;

    // // sort by eta
    // cartBySeller.sort((a, b) => a.deliverIn!.compareTo(b.deliverIn!));

    var ped = listShoppingCart.first;
    await orderSvc
        .postOrder(new Pedido(
          null,
          ped.sellerId,
          '',
          pedDate,
          cartTotalItems.value.toString(),
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
          ped.deliverIn,
          null,
          null,
          null,
          null,
          null,
          null,
          ped.storeId,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
        ))
        .then((pedGuid) => listShoppingCart.forEach((item) async {
              // salva os itens do pedido
              print('entrou no salva itens ');
              var pedItemGuid = await orderSvc.postOrderItem(new PedidoItem(
                  '',
                  pedGuid,
                  item.offerGuid,
                  item.name,
                  endereco.EnderecoCEP.toString(),
                  item.sellerId.toString(),
                  item.value,
                  item.qty.toDouble(),
                  item.totalValue,
                  item.picture,
                  0,
                  null,
                  item.categChave,
                  null,
                  item.deliverIn,
                  null,
                  null,
                  null,
                  null,
                  null,
                  item.storeId));

              print('new pedItemGuid:  ' + pedItemGuid);
            }));

    return ret;
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
