import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/pedido.dart';
import 'package:poraki/app/data/models/sql/sqlPedido.dart';
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
  @override
  Widget build(BuildContext context) {
    bool closed = false;
    final OrderController orderController = Get.put(OrderController());
    final LoginController _loginController = Get.find();

    Widget _buildRowClosed(sqlPedido pedido) {
      print(pedido.toMap());
      return Column(children: [
        ListTile(
          leading: Icon(Icons.monetization_on_outlined),
          onTap: () =>
              Get.toNamed(AppRoutes.order, arguments: [pedido.toMap()]),
          // ),
          title: Text('Pedido em: ' +
                  pedido.pedidoEm +
                  ' no valor de ' +
                  pedido.pedidoValorTotal +
                  ' - a partir do CEP: ' +
                  pedido.pedidoCEP
              // style: _biggerFont,
              ),
          subtitle: Text(pedido.pedidoPagtoEm == ''
              ? 'Em aberto'
              : 'Pago em' + pedido.pedidoPagtoEm),
          //trailing: Icon(IconData(int.parse(iconcode), fontFamily: 'MaterialIcons'))
        ),
        const SizedBox(height: 5),
        const Divider(),
        const SizedBox(height: 5),
      ]);
    }

    Widget _buildRowOpen(Pedido pedido) {
      print(pedido.toMap());
      return Column(children: [
        ListTile(
          leading: Icon(Icons.monetization_on_outlined),
          onTap: () =>
              Get.toNamed(AppRoutes.order, arguments: [pedido.toMap()]),
          // ),
          title: Text('Pedido em: ' +
                  pedido.PedidoEm +
                  ' no valor de ' +
                  pedido.PedidoValorTotal +
                  ' - a partir do CEP: ' +
                  pedido.PedidoCEP
              // style: _biggerFont,
              ),
          subtitle: Text(pedido.PedidoPagtoEm == ''
              ? 'Em aberto'
              : 'Pago em' + pedido.PedidoPagtoEm),
          //trailing: Icon(IconData(int.parse(iconcode), fontFamily: 'MaterialIcons'))
        ),
        const SizedBox(height: 5),
        const Divider(),
        const SizedBox(height: 5),
      ]);
    }

    Future<void> loadOrderData() async {
      if (closed)
        await orderController
            .listaTodosPedidos(_loginController.usuGuid.toString());
      else
        await orderController.listaPedidosPorClienteOpenCloud(
            _loginController.usuGuid.toString());
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
            //print('qt pedidos: ' + orderController.listaPedidos.length.toString());

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
                  Scrollbar(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      //scrollDirection: Axis.vertical,
                      // padding: const EdgeInsets.all(16.0),
                      itemCount: closed
                          ? orderController.listaPedidos.length
                          : orderController.listaPedidosCloud.length,
                      itemBuilder: (BuildContext context, int index) {
                        //if (index.isOdd) return const Divider();
                        //index = index ~/ 2 + 1;
                        sqlPedido sqlPed =
                            closed ? orderController.listaPedidos[index] : null;
                        Pedido ped = closed
                            ? orderController.listaPedidosCloud[index]
                            : null;
                        return closed
                            ? _buildRowClosed(sqlPed)
                            : _buildRowOpen(ped);
                      },
                    ),
                  )
                ])));
          }
        });
  }
}
