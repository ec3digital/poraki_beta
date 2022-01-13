import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'package:poraki/app/modules/shopping_cart/shopping_cart_controller.dart';
import 'package:poraki/app/theme/app_theme.dart';

enum FormasPagto { Cartao, PixQR, CarteirasDigitais, Direto }

class BodyCheckOut extends StatefulWidget {
  ShoppingCartController controller = Get.find();

  @override
  _BodyCheckOut createState() => _BodyCheckOut();
}

class _BodyCheckOut extends State<BodyCheckOut> {
  FormasPagto formaPagto = FormasPagto.Cartao;
  //GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.controller.carregaCarrinho(),
        builder: (context, futuro) {
          print('cart qty:' +
              widget.controller.listShoppingCart.length.toString());

          if (futuro.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); //Text('carrinho vazio'));
            // } else if (futuro.hasError) {
            //   return Center(child: Text(futuro.error.toString()));
          } else {
            if (widget.controller.listShoppingCart.length == 0) {
              return Center(child: Text("carrinho vazio"));
            } else {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: ListView(
                        children: <Widget>[
                          paymentSection(),
                          selectedAddressSection(),
                          widgetEntrega(),
                          checkoutItem(),
                          priceSection()
                        ],
                      ),
                    ),
                    flex: 90,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: ButtonOffer(
                        onPressed: () {
                          final snackBar = SnackBar(
                              backgroundColor: AppColors.primaryColor,
                              content: Container(
                                  height: 40,
                                  child: Center(
                                      child: const Text(
                                          'Obrigado por sua compra!'))));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        colorText: AppColors.primaryColor,
                        text: 'Finalizar',
                        colorButton: AppColors.grayBlueButton,
                      ),
                    ),
                    flex: 10,
                  )
                ],
              );
            }
          }
        });
  }

  selectedAddressSection() {
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
          padding: EdgeInsets.only(left: 12, top: 8, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Danilo Santos",
                      style: Get.textTheme.bodyText1!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              createAddressText("Rua Carlos Magalhães, 100", 16),
              createAddressText("CEP 05735-030", 6),
              createAddressText("São Paulo - SP", 6),
              SizedBox(
                height: 6,
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                color: Colors.grey.shade300,
                height: 1,
                width: double.infinity,
              ),
              addressAction()
            ],
          ),
        ),
      ),
    );
  }

  createAddressText(String strAddress, double topMargin) {
    return Container(
        margin: EdgeInsets.only(top: topMargin),
        child: Text(
          strAddress,
          style: Get.textTheme.bodyText1!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: AppColors.primaryColor,
          ),
        ));
  }

  addressAction() {
    return Container(
      child: Row(
        children: <Widget>[
          Spacer(
            flex: 2,
          ),
          OutlinedButton(
            onPressed: () {},
            child: Text(
              "Mudar Endereço",
            ),
          ),
          // Spacer(
          //   flex: 3,
          // ),
          // Container(
          //   height: 20,
          //   width: 1,
          //   color: Colors.grey,
          // ),
          // Spacer(
          //   flex: 3,
          // ),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }

  widgetEntrega() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          border:
              Border.all(color: Colors.tealAccent.withOpacity(0.4), width: 1),
          color: Colors.tealAccent.withOpacity(0.2)),
      margin: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Radio(
            value: 1,
            groupValue: 1,
            onChanged: (isChecked) {},
            activeColor: Colors.tealAccent.shade400,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Entrega Normal",
                style: Get.textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Previsão de Entrega - ${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}',
                style: Get.textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ],
      ),
    );
  }

  checkoutItem() {
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
            itemCount: widget.controller.listShoppingCart.length,
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
              widget.controller.listShoppingCart[index]
                  .picture,
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
          child:
          Text(
            widget.controller.listShoppingCart[index].name,
            style: Get.textTheme.bodyText1!.copyWith(
                fontSize: 16,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w900),
          )),
          Text(
            widget.controller.listShoppingCart[index].qty.toString(),
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
            widget.controller.listShoppingCart[index].value.toString(),
            style: Get.textTheme.bodyText1!.copyWith(
                fontSize: 16,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }

  priceSection() {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 4,
              ),
              Text(
                "VALOR DETALHADO",
                style: Get.textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                margin: EdgeInsets.symmetric(vertical: 4),
                color: Colors.grey.shade400,
              ),
              SizedBox(
                height: 8,
              ),
              createPriceItem("Total Produtos", getFormattedCurrency(widget.controller.cartTotalItems)),
              createPriceItem("Descontos", getFormattedCurrency(widget.controller.cartDiscount)),
              createPriceItem("Taxas", getFormattedCurrency(widget.controller.cartTaxes)),
              // createPriceItem("TOTAL", getFormattedCurrency(widget.controller.cartTotal)),
              createPriceItem("Taxa Entrega", getFormattedCurrency(widget.controller.cartDelivery)),
              SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                margin: EdgeInsets.symmetric(vertical: 4),
                color: Colors.grey.shade400,
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "TOTAL GERAL",
                    style: Get.textTheme.bodyText1!.copyWith(
                        fontSize: 16,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w900),
                  ),
                  Text(
                    getFormattedCurrency(widget.controller.cartTotal),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String getFormattedCurrency(double amount) {
    return "R\$ " + amount.toStringAsFixed(2);
    // FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(amount: amount);
    // fmf.symbol = "₹";
    // fmf.thousandSeparator = ",";
    // fmf.decimalSeparator = ".";
    // fmf.spaceBetweenSymbolAndNumber = true;
    // return fmf.formattedLeftSymbol;
  }

  paymentSection() {
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
                padding: EdgeInsets.only(left: 6, top: 6, right: 4, bottom: 4),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Escolha a forma de pagamento",
                        style: Get.textTheme.bodyText1!.copyWith(
                            fontSize: 16,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Container(
                        width: double.infinity,
                        height: 0.5,
                        margin: EdgeInsets.symmetric(vertical: 4),
                        color: Colors.grey.shade400,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Column(
                        children: <Widget>[
                          ListTile(
                            title: Text('Cartão',
                                style: Get.textTheme.bodyText1!.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                            leading: Radio<FormasPagto>(
                              value: FormasPagto.Cartao,
                              groupValue: formaPagto,
                              onChanged: (value) {
                                setState(() {
                                  formaPagto = value!;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text('PixQR',
                                style: Get.textTheme.bodyText1!.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                            leading: Radio<FormasPagto>(
                              value: FormasPagto.PixQR,
                              groupValue: formaPagto,
                              onChanged: (value) {
                                setState(() {
                                  formaPagto = value!;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text('Carteiras Digitais',
                                style: Get.textTheme.bodyText1!.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                            leading: Radio<FormasPagto>(
                              value: FormasPagto.CarteirasDigitais,
                              groupValue: formaPagto,
                              onChanged: (value) {
                                setState(() {
                                  formaPagto = value!;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title:
                                Text('Direto com o vendedor (não recomendado)',
                                    style: Get.textTheme.bodyText1!.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    )),
                            leading: Radio<FormasPagto>(
                              value: FormasPagto.Direto,
                              groupValue: formaPagto,
                              onChanged: (value) {
                                setState(() {
                                  formaPagto = value!;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      )
                    ]))));
  }

  //
  //
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: <Widget>[
  //         Text(
  //           key,
  //         ),
  //         Text(
  //           FormaPagto,
  //         )
  //       ],
  //     ),
  //   );
  // }

  createPriceItem(String key, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            key,
          ),
          Text(
            value,
          )
        ],
      ),
    );
  }
}