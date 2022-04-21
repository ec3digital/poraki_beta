import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/pedido.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/home/widgets/gradient_header_home.dart';
import 'package:poraki/app/modules/orders/order_controller.dart';
import 'package:poraki/app/routes/app_routes.dart';

class ListOrders extends StatefulWidget {
  ListOrders({
    Key? key,
  }) : super(key: key);

  @override
  State<ListOrders> createState() => _ListOrdersState();
}

class _ListOrdersState extends State<ListOrders> {
  bool closed = false;

  @override
  Widget build(BuildContext context) {
    final OrderController orderController = Get.put(OrderController());
    final LoginController _loginController = Get.find();

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
                  ' no valor de R\$ ' + double.parse(_ped.PedidoValorTotal).toStringAsFixed(2).replaceAll('.', ',')
              // style: _biggerFont,
              ),
          trailing: Text('CEP ' + _ped.PedidoCEP),
          subtitle: Text('Em aberto'),
        ),
        const SizedBox(height: 5),
        const Divider(),
        const SizedBox(height: 5),
      ]);
    }

    Future<void> loadOrderData() async {
      if (!closed) {
        await orderController.carregaPedidosPorClienteOpenCloud(
            _loginController.usuGuid.toString());
      } else {
        await orderController
            .carregaPedidosFechadosLocal(_loginController.usuGuid.toString());
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
                    "Pedidos",
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
                            height: MediaQuery.of(context).size.height,
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
