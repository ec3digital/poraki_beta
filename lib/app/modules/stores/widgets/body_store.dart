import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/lojas.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/home/widgets/gradient_header_home.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'package:poraki/app/routes/app_routes.dart';
import 'package:poraki/app/theme/app_theme.dart';

import '../store_controller.dart';

// ignore: must_be_immutable
class StoreBody extends StatelessWidget {
  // final Lojas? loja;
  StoreBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StoreController controller = Get.find();
    LoginController _loginController = Get.find();
    Color textColor = _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'textDark').first.coreValor.toString());

    return Container(child: GetBuilder<StoreController>(builder: (context) {
      if (controller.isLoading) {
        return Center(
          child: Container(),
        );
      } else {
        if (controller.loja != null) {
          Future.delayed(Duration.zero, () async {
            controller.bindLoja();
          });
        }

        return SingleChildScrollView(
          child: GradientHeaderHome(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        "Loja",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    Form(
                      // key: controller.formKey,
                      child: Column(children: [
                        TextFormField(
                          // validator: (value) {
                          //   if (value!.length < 4) {
                          //     return "Digite um nome maior";
                          //   }
                          //   return null;
                          // },
                          controller: controller.txtLojaCEP,
                          autofocus: true,
                          style: TextStyle(color: textColor),
                          decoration: InputDecoration(
                            labelText: "CEP",
                            labelStyle: TextStyle(color: textColor),
                            prefixIcon: Icon(
                              Icons.location_on_outlined,
                              color: textColor,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: textColor),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: textColor),
                            ),
                          ),
                          onEditingComplete: () {
                            print('onEditingComplete');
                            buscaCep();
                          },
                        ),
                        TextFormField(
                          // validator: (value) {
                          //   if (value!.length < 10) {
                          //     return "Digite um nome maior";
                          //   }
                          //   return null;
                          // },
                          controller: controller.txtLojaNome,
                          // keyboardType: TextInputType.streetAddress,
                          autofocus: true,
                          style: TextStyle(color: textColor),
                          decoration: InputDecoration(
                            labelText: "Nome da Loja",
                            labelStyle: TextStyle(color: textColor),
                            prefixIcon: Icon(
                              Icons.storefront_rounded,
                              color: textColor,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: textColor),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: textColor),
                            ),
                          ),
                        ),
                        TextFormField(
                          // validator: (value) {
                          //   if (value!.length != 11) {
                          //     return "CPF inválido";
                          //   }
                          //   return null;
                          // },
                          controller: controller.txtLojaSlogan,
                          // keyboardType: TextInputType.number,
                          autofocus: true,
                          // focusNode: txtEnderecoNroFocus,
                          style: TextStyle(color: textColor),
                          decoration: InputDecoration(
                            labelText: "Slogan",
                            labelStyle: TextStyle(color: textColor),
                            prefixIcon: Icon(
                              Icons.local_offer_outlined,
                              color: textColor,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: textColor),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: textColor),
                            ),
                          ),
                        ),
                        TextFormField(
                          // validator: (value) {
                          //   if (value!.length != 11) {
                          //     return "Por favor digite um telefone válido";
                          //   }
                          //   return null;
                          // },
                          controller: controller.txtLojaCNPJ,
                          autofocus: true,
                          style: TextStyle(color: textColor),
                          decoration: InputDecoration(
                            labelText: "CNPJ",
                            labelStyle: TextStyle(color: textColor),
                            prefixIcon: Icon(
                              Icons.work_outline,
                              color: textColor,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: textColor),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: textColor),
                            ),
                          ),
                        ),

                        TextFormField(
                          // validator: (value) {
                          //   if (value!.length != 11) {
                          //     return "Por favor digite um telefone válido";
                          //   }
                          //   return null;
                          // },
                          controller: controller.txtLojaRazao,
                          autofocus: true,
                          style: TextStyle(color: textColor),
                          decoration: InputDecoration(
                            labelText: "Razão Social",
                            labelStyle: TextStyle(color: textColor),
                            prefixIcon: Icon(
                              Icons.location_city_outlined,
                              color: textColor,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: textColor),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: textColor),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(height: 20),
                    ButtonOffer(
                      onPressed: () {
                        salvar("");

                        final snackBar = SnackBar(
                            backgroundColor: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'textDark').first.coreValor.toString()),
                            content: Container( height: 40, child: Center(child: const Text('Informações salvas 1!'))));
                        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      colorText: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'textLight').first.coreValor.toString()),
                      text: 'Salvar',
                      colorButton: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'iconColor').first.coreValor.toString()),
                    ),

                    // )
                  ])
              // ],
              ),
        );
        // );
      }
    }));
  }

  // FocusNode txtEnderecoNroFocus = new FocusNode();
  // var tipos = ["Casa", "Trabalho", "Estudo", "Outros"];
  // var tipoSel = "Casa";
  //
  // void _dropDownItemSelected(String novoItem){
  //   setState(() {
  //     this.tipoSel = novoItem;
  //   });
  // }

  Future<void> salvar(String storeGuid) async {
    // String enderecoGuid = "xxx";
    // var end = new sqlEndereco(enderecoGuid,
    //     '',
    //     '',
    //     widget._controller.txtCEP.text.trimLeft().trimRight(),
    //     widget._controller.txtEnderecoLogra.text.trimLeft().trimRight(),
    //     widget._controller.txtEnderecoNumero.text.trimLeft().trimRight(),
    //     widget._controller.txtEnderecoCompl!.text.trimLeft().trimRight(),
    //     tipoSel,
    //     0,
    //     null,null,null
    // );//
    // //DateTime.now().toString());
    //
    // await widget._controller.adicionaEndereco(end);
    //
    // if(EnderecoAtual == 1)
    //   await widget._controller.tornarEnderecoAtual(enderecoGuid);
  }

  Future<void> buscaCep() async {
    // CepApiBrasil cepApi = await CepApiBrasilRepository().getCepApiBrasil(widget._controller.txtCEP.text.trimLeft().trimRight());
    //
    // widget._controller.txtEnderecoLogra.text = cepApi.street!;
    // if(widget._controller.txtEnderecoLogra.text.isNotEmpty)
    //   FocusScope.of(context).requestFocus(txtEnderecoNroFocus);
    //
    // //widget._controller.txtEnderecoTipo.text.trimLeft().trimRight(),
  }
}
