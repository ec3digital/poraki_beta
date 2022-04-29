import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/pedido.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/home/widgets/gradient_header_home.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'package:poraki/app/modules/orders/order_controller.dart';
import 'package:poraki/app/routes/app_routes.dart';

class ListOrders extends StatefulWidget {
  String tipo = ''; //compra, venda, entrega
  ListOrders({Key? key, required this.tipo}) : super(key: key);

  @override
  State<ListOrders> createState() => _ListOrdersState();
}

class _ListOrdersState extends State<ListOrders> {
  bool closed = false;
  final OrderController orderController = Get.put(OrderController());

  //TODO: implementar acoes nos pedidos
  Future<void> orderAction(String acao, Pedido ped) async {
    print(acao);
    // paga pedido
    if (acao == 'pagar') {} //recebe pedido
    if (acao == 'receber') {} // aceita pedido
    if (acao == 'aceitar') {}
    if (acao == 'declinar') {}
    if (acao == 'cancelar') {}
  }

  @override
  Widget build(BuildContext context) {
    final LoginController _loginController = Get.find();

    var args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    widget.tipo = args['tipo'].toString();

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
      return Column(children: [
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
                      .toStringAsFixed(2).replaceAll(',', '').replaceAll('.', ',')
                      .replaceAll('.', ',')
              // style: _biggerFont,
              ),
          trailing: Text('CEP ' + _ped.PedidoCEP),
          subtitle: Column(
            children: [
              Text('Em aberto'),
              SizedBox(width: 5),
              if (widget.tipo == 'Compras' && _ped.PedidoPagtoEm.isEmpty)
                Column(
                  children: [
                    ButtonOffer(
                        text: 'pagar',
                        colorText: _loginController.colorFromHex(
                            _loginController.listCore
                                .where((coreItem) =>
                                    coreItem.coreChave == 'textDark')
                                .first
                                .coreValor
                                .toString()),
                        onPressed: () => orderAction('pagar', _ped)),
                    ButtonOffer(
                        text: 'cancelar',
                        colorText: _loginController.colorFromHex(
                            _loginController.listCore
                                .where((coreItem) =>
                                    coreItem.coreChave == 'textDark')
                                .first
                                .coreValor
                                .toString()),
                        onPressed: () => orderAction('cancelar', _ped)),
                  ],
                ),
              if (widget.tipo == 'Compras' && _ped.PedidoPagtoEm.isNotEmpty)
                ButtonOffer(
                    text: 'receber',
                    colorText: _loginController.colorFromHex(_loginController
                        .listCore
                        .where((coreItem) => coreItem.coreChave == 'textDark')
                        .first
                        .coreValor
                        .toString()),
                    onPressed: () => orderAction('receber', _ped)),
              if (widget.tipo == 'Vendas' && _ped.PedidoPagtoEm.isEmpty)
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
                        onPressed: () => orderAction('aceitar', _ped)),
                    ButtonOffer(
                        text: 'declinar',
                        colorText: _loginController.colorFromHex(
                            _loginController.listCore
                                .where((coreItem) =>
                                    coreItem.coreChave == 'textDark')
                                .first
                                .coreValor
                                .toString()),
                        onPressed: () => orderAction('declinar', _ped)),
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

      if (widget.tipo == 'Vendas') {
        if (!closed) {
          await orderController.carregaPedidosPorClienteOpenCloud(
              _loginController.usuGuid.toString());
        } else {
          await orderController
              .carregaPedidosFechadosLocal(_loginController.usuGuid.toString());
        }
      }

      if (widget.tipo == 'Compras') {
        if (!closed) {
          await orderController.carregaPedidosPorClienteClosedCloud(
              _loginController.usuGuid.toString());
        } else {
          await orderController.carregaPedidosPorClienteOpenCloud(
              _loginController.usuGuid.toString());
        }
      }

      if (widget.tipo == 'Entregas') {
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
          } else {
            return SingleChildScrollView(
                child: GradientHeaderHome(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                  const SizedBox(height: 15),
                  Center(
                      child: Text(
                    this.widget.tipo == 'Entregas' ? 'Entregas à realizar': this.widget.tipo,
                    style: TextStyle(fontSize: 24),
                  )),
                  const SizedBox(height: 5),
                  Column(children: <Widget>[
                    SizedBox(width: 20),
                    Row(
                      children: <Widget>[
                        Switch(
                            value: closed,
                            onChanged: (bool val) {
                              setState(() {
                                closed = val;
                              });
                            }),
                        SizedBox(width: 20),
                        Text(closed ? 'Finalizados' : 'Em aberto'),
                        SizedBox(height: 20)
                      ],
                    ),
                    SizedBox(width: 20),
                  ]),
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
          }
        });
  }
}
