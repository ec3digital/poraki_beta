import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/pedido.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/home/widgets/gradient_header_home.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'package:poraki/app/modules/orders/order_controller.dart';
import 'package:poraki/app/routes/app_routes.dart';

class ListOrders extends StatefulWidget {
  //String tipo = ''; //compra, venda, entrega
  ListOrders({Key? key}) : super(key: key);

  @override
  State<ListOrders> createState() => _ListOrdersState();
}

class _ListOrdersState extends State<ListOrders> {
  bool closed = false;
  var pagTipo = '';
  final OrderController orderController = Get.find();
  final LoginController _loginController = Get.find();

  @override
  void initState() {
    super.initState();

    //var args =
    //ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    pagTipo = Get.arguments[0].toString();

    orderController.listaPedidoItems.clear();
    orderController.listaPedidos.clear();
  }

  //TODO: implementar acoes nos pedidos
  Future<void> orderAction(String acao, Pedido ped, LoginController loginController, String? info) async {
    print(acao);
    // // paga pedido
    // if (acao == 'pagar') {
    //   await orderController.pagaPedidoCloud(ped.PedidoGUID.toString(), loginController.usuNome.toString());
    // } // paga pedido
    if (acao == 'receber') {
      await orderController.recebePedidoCloud(ped.PedidoGUID.toString(), loginController.usuNome.toString());
    } // marca como recebido
    if (acao == 'aceitar') {
      await orderController.aceitaPedidoCloud(ped.PedidoGUID.toString(), loginController.usuNome.toString());
    } // aceita pedido
    if (acao == 'declinar' || acao == 'cancelar') {
      await orderController.cancelaPedidoCloud(ped.PedidoGUID.toString(), loginController.usuGuid.toString(), info.toString());
    } // cancela / declina pedido
  }

  @override
  Widget build(BuildContext context) {

    String _formatDate(String strData) {
      return strData.substring(8, 10) +
          '/' +
          strData.substring(5, 7) +
          '/' +
          strData.substring(0, 4) +
          ' às ' +
          strData.substring(11, 16);
    }

    Widget _buildRow(Pedido _ped) {
      return Column(
          children: [
        ListTile(
          leading: closed
              ? Icon(Icons.monetization_on)
              : Icon(Icons.monetization_on_outlined),
          onTap: () {
            Get.toNamed(AppRoutes.order, arguments: [
              {'Pedido': _ped}
            ]);
          },
          title: Text('Pedido realizado em ' +
                  _formatDate(_ped.PedidoEm) +
                  ' no valor de R\$ ' +
                  double.parse(_ped.PedidoValorTotal)
                      .toStringAsFixed(2)
                      .replaceAll(',', '')
                      .replaceAll('.', ',')
                      .replaceAll('.', ',')
              // style: _biggerFont,
              ),
          trailing: Text('CEP ' + _ped.PedidoCEP),
          subtitle: Column(
            children: [
              Text('Em aberto'),
              SizedBox(width: 5),
              if (pagTipo == 'Compras' && _ped.PedidoEntregaRealizadaEm == null)
                Column(
                  children: [
                    // ButtonOffer(
                    //     text: 'pagar',
                    //     colorText: _loginController.colorFromHex(
                    //         _loginController.listCore
                    //             .where((coreItem) =>
                    //                 coreItem.coreChave == 'textDark')
                    //             .first
                    //             .coreValor
                    //             .toString()),
                    //     onPressed: () => orderAction('pagar', _ped)),
                    ButtonOffer(
                        text: 'cancelar',
                        colorText: _loginController.colorFromHex(
                            _loginController.listCore
                                .where((coreItem) =>
                                    coreItem.coreChave == 'textDark')
                                .first
                                .coreValor
                                .toString()),
                        onPressed: () async { await orderAction('cancelar', _ped, _loginController, '');}),
                  ],
                ),
              if (pagTipo == 'Compras' && _ped.PedidoPagtoEm == null)
                ButtonOffer(
                    text: 'receber',
                    colorText: _loginController.colorFromHex(_loginController
                        .listCore
                        .where((coreItem) => coreItem.coreChave == 'textDark')
                        .first
                        .coreValor
                        .toString()),
                    onPressed: () async { await orderAction('receber', _ped, _loginController, '');}),
              if (pagTipo == 'Vendas' && _ped.PedidoAceitoEm == null)
                Column(
                  children: [
                    ButtonOffer(
                        text: 'aceitar',
                        colorText: _loginController.colorFromHex(
                            _loginController.listCore
                                .where((coreItem) =>
                                    coreItem.coreChave == 'textDark')
                                .first
                                .coreValor
                                .toString()),
                        onPressed: () async { await orderAction('aceitar', _ped, _loginController, '');}),
                    ButtonOffer(
                        text: 'declinar',
                        colorText: _loginController.colorFromHex(
                            _loginController.listCore
                                .where((coreItem) =>
                                    coreItem.coreChave == 'textDark')
                                .first
                                .coreValor
                                .toString()),
                        onPressed: () async { await orderAction('declinar', _ped, _loginController, ''); }),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        const Divider(),
        const SizedBox(height: 5),
      ]);
    }

    Future<void> loadOrderData() async {
      // tipo = compra, venda, entrega
      orderController.listaPedidos.clear();
      orderController.listaPedidoItems.clear();

      print('widget tipo: ' + pagTipo);

      if (pagTipo == 'Vendas') {
        if (!closed) {
          await orderController.carregaPedidosPorVendedorOpenCloud(
              _loginController.usuGuid.toString());
        } else {
          await orderController
              .carregaPedidosPorVendedorClosedCloud(_loginController.usuGuid.toString());
        }
      }

      if (pagTipo == 'Compras') {
        if (!closed) {
          await orderController.carregaPedidosPorClienteOpenCloud(
              _loginController.usuGuid.toString());
        } else {
          await orderController.carregaPedidosPorClienteClosedCloud(
              _loginController.usuGuid.toString());
        }
      }

      if (pagTipo == 'Entregas') {
        if (!closed) {
          await orderController.carregaPedidosPorVendedorOpenDeliveryCloud(
              _loginController.usuGuid.toString());
        } else {
          await orderController.carregaPedidosPorVendedorClosedDeliveryCloud(
              _loginController.usuGuid.toString());
        }
      }
    }

    return FutureBuilder(
        future: loadOrderData(),
        builder: (context, futuro) {
          if (futuro.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); //Text('carrinho vazio'));
            // } else if (futuro.hasError) {
            //   return Center(child: Text(futuro.error.toString()));
          } if (futuro.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
                child: GradientHeaderHome(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                  const SizedBox(height: 15),
                  Center(
                      child: Text(
                    this.pagTipo == 'Entregas'
                        ? 'Entregas'
                        : this.pagTipo,
                    style: TextStyle(fontSize: 24),
                  )),
                  const SizedBox(height: 5),
                  Column(children: <Widget>[
                    SizedBox(width: 20),
                    Row(
                      children: <Widget>[
                        Switch(
                            value: closed,
                            onChanged: (bool val) async {
                              setState(() {
                                closed = val;
                              });
                              //await loadOrderData();
                            }),
                        SizedBox(width: 20),
                        Text(closed ? 'Finalizados' : 'Em aberto'),
                        SizedBox(height: 20)
                      ],
                    ),
                    SizedBox(width: 20),
                  ]),
                  if (orderController.listaPedidos.length == 0)
                    Container(
                        child: Center(
                            child: Text("Ops, nada poraki ainda... ;-)")))
                  else
                    Container(
                      height: MediaQuery.of(context).size.height + 70,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(16.0),
                        itemCount: orderController.listaPedidos.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _buildRow(orderController.listaPedidos[index]);
                        },
                      ),
                    )
                ])));
          } else { return Container(); }
        });
  }
}
