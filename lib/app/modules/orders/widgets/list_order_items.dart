import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/sql/sqlPedido.dart';
import 'package:poraki/app/modules/home/widgets/gradient_header_home.dart';
import 'package:poraki/app/theme/app_theme.dart';

import '../order_controller.dart';

// ignore: must_be_immutable
class ListOrderItems extends StatelessWidget {
  final sqlPedido? pedido;
  final OrderController orderController = Get.find(); //put(OrderController());

  ListOrderItems({Key? key, required this.pedido}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: orderController
            .buscaPedido(''), //'c09cd10b-5aa2-43c2-bb42-10031c0d4280'),
        builder: (context, futuro) {
          if (futuro.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); //Text('carrinho vazio'));
            // } else if (futuro.hasError) {
            //   return Center(child: Text(futuro.error.toString()));
          } else {
            print('qt pedidos: ' +
                orderController.listaPedidos.length.toString());
            //return SingleChildScrollView(
                // child: GradientHeaderHome(
                //     child: Column(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //   SizedBox(height: 20),
                //   Center(child: Text("Items do pedido")),
                //   SizedBox(height: 20),
                //    Scrollbar(
                  //   child: ListView.builder(
                  //     scrollDirection: Axis.vertical,
                  //     shrinkWrap: true,
                  //     //scrollDirection: Axis.vertical,
                  //     // padding: const EdgeInsets.all(16.0),
                  //     itemCount: orderController.listaPedidosItems.length,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       //if (index.isOdd) return const Divider();
                  //       //index = index ~/ 2 + 1;
                  //       sqlPedido pedido = orderController.listaPedidosItems[index];
                  return Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: ListView(
                            children: <Widget>[
                              checkoutItem(),
                            ],
                          ),
                        ),
                        flex: 90,
                      ),
                    ],
                  //)
          );
                   //)])));
          }
        });
  } //),;
  //);//);
  // ])));

  //});

  //}

  checkoutItem() {
    print('items qt: ' + orderController.listaPedidosItems.length.toString());
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Colors.grey.shade200)),
          padding: EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
          child: ListView.builder(
            itemBuilder: (context, position) {
              return checkoutListItem(position);
            },
            itemCount: orderController.listaPedidosItems.length,
            shrinkWrap: true,
            primary: false,
            scrollDirection: Axis.vertical,
          ),
        ),
      ),
    );
  }

  checkoutListItem(int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Container(
            child: Image.network(
              orderController.listaPedidosItems[index].ofertaImgPath.toString(),
              height: 30,
              fit: BoxFit.fitHeight,
            ),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
              child: Text(
            orderController.listaPedidosItems[index].ofertaTitulo,
            style: Get.textTheme.bodyText1!.copyWith(
                fontSize: 16,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w900),
          )),
          Text(
            orderController.listaPedidosItems[index].ofertaQtd.toString(),
            style: Get.textTheme.bodyText1!.copyWith(
                fontSize: 16,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w900),
          ),
          Text(
            ' x ',
            style: Get.textTheme.bodyText1!.copyWith(
                fontSize: 16,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w900),
          ),
          Text(
            orderController.listaPedidosItems[index].ofertaPreco.toString(),
            style: Get.textTheme.bodyText1!.copyWith(
                fontSize: 16,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}
