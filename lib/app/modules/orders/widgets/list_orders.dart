import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/sql/sqlPedido.dart';
import 'package:poraki/app/modules/home/widgets/gradient_header_home.dart';
import 'package:poraki/app/modules/orders/order_controller.dart';
import 'package:poraki/app/routes/app_routes.dart';

class ListOrders extends StatelessWidget {
  ListOrders({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget _buildRow(sqlPedido pedido) {
      print(pedido.toMap());
      return ListTile(
        leading: Icon(Icons.work_outlined),
        onTap: () => Get.toNamed(AppRoutes.order, arguments: [pedido.toMap()]),
        // ),
        title: Text('Pedido em: ' + pedido.pedidoEm + ' no valor de ' + pedido.pedidoValorTotal + ' - a partir do CEP: ' + pedido.pedidoCEP
          // style: _biggerFont,
        ),
        subtitle: Text(pedido.pedidoPagtoEm == '' ? 'Em aberto': 'Pago em' + pedido.pedidoPagtoEm
        ),
        //trailing: Icon(IconData(int.parse(iconcode), fontFamily: 'MaterialIcons'))
      );
    }

    final OrderController orderController = Get.put(OrderController());
    return FutureBuilder(
        future: orderController.listaTodosPedidos('c09cd10b-5aa2-43c2-bb42-10031c0d4280'),
        builder: (context, futuro) {
          if (futuro.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); //Text('carrinho vazio'));
            // } else if (futuro.hasError) {
            //   return Center(child: Text(futuro.error.toString()));
          } else {
            print('qt pedidos: ' + orderController.listaPedidos.length.toString());
            return SingleChildScrollView(
                child: GradientHeaderHome(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 20),
                          Center(child: Text("Pedidos")),
                          SizedBox(height: 20),
                          Scrollbar(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              //scrollDirection: Axis.vertical,
                              // padding: const EdgeInsets.all(16.0),
                              itemCount: orderController.listaPedidos.length,
                              itemBuilder: (BuildContext context, int index) {
                                //if (index.isOdd) return const Divider();
                                //index = index ~/ 2 + 1;
                                sqlPedido pedido = orderController.listaPedidos[index];
                                return _buildRow(pedido);
                              },
                            ),
                          )
                        ])));
          }
        });
  }
}
