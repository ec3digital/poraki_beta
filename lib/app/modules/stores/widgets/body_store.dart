import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/lojas.dart';
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

    //String _storeGuid = ModalRoute.of(context)!.settings.arguments.toString();

    // var args = ModalRoute.of(context)?.settings.arguments as String;
    return Container(child: GetBuilder<StoreController>(builder: (context) {
      if (controller.isLoading) {
        return Center(
          child: Container(),
        );
      } else {

        if(controller.loja != null) {
          Future.delayed(Duration.zero, () async {
            controller.bindLoja();
          });
        }

        return SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
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
                      style: TextStyle(color: Colors.brown),
                      decoration: InputDecoration(
                        labelText: "CEP",
                        labelStyle: TextStyle(color: Colors.brown),
                        prefixIcon: Icon(
                          Icons.location_on_outlined,
                          color: Colors.brown,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown),
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
                      style: TextStyle(color: Colors.brown),
                      decoration: InputDecoration(
                        labelText: "Nome da Loja",
                        labelStyle: TextStyle(color: Colors.brown),
                        prefixIcon: Icon(
                          Icons.storefront_rounded,
                          color: Colors.brown,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown),
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
                      style: TextStyle(color: Colors.brown),
                      decoration: InputDecoration(
                        labelText: "Slogan",
                        labelStyle: TextStyle(color: Colors.brown),
                        prefixIcon: Icon(
                          Icons.local_offer_outlined,
                          color: Colors.brown,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown),
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
                      style: TextStyle(color: Colors.brown),
                      decoration: InputDecoration(
                        labelText: "CNPJ",
                        labelStyle: TextStyle(color: Colors.brown),
                        prefixIcon: Icon(
                          Icons.work_outline,
                          color: Colors.brown,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown),
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
                      style: TextStyle(color: Colors.brown),
                      decoration: InputDecoration(
                        labelText: "Razão Social",
                        labelStyle: TextStyle(color: Colors.brown),
                        prefixIcon: Icon(
                          Icons.location_city_outlined,
                          color: Colors.brown,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown),
                        ),
                      ),
                    ),

                    // Text('Tipo'),
                    // DropdownButton<String>(
                    //   items: tipos.map((String value) {
                    //     return DropdownMenuItem<String>(
                    //       value: value,
                    //       child: Text(value),
                    //     );
                    //   }).toList(),
                    //   value: tipoSel,
                    //   onChanged: (String? newValue) {
                    //     setState(() {
                    //       tipoSel = newValue!;
                    //     });
                    //   },

                    // onChanged: (String value) {
                    //   setState(() {
                    //     tipoSel = value;
                    //   });
                    // },
                    //),
                    // TextFormField(
                    //   // validator: (value) {
                    //   //   if (value!.length < 5) {
                    //   //     return "Esse e-mail parece curto demais";
                    //   //   } else if (!value.contains("@")) {
                    //   //     return "Esse e-mail está meio estranho, não?";
                    //   //   }
                    //   //   return null;
                    //   // },
                    //   controller: widget._controller.txtEnderecoTipo,
                    //   autofocus: true,
                    //   style: TextStyle(color: Colors.brown),
                    //   decoration: InputDecoration(
                    //     labelText: "Tipo: Casa, Trabalho, Estudo, Outros",
                    //     labelStyle: TextStyle(
                    //       color: Colors.brown,
                    //     ),
                    //     prefixIcon: Icon(
                    //       Icons.house_outlined,
                    //       color: Colors.brown,
                    //     ),
                    //     focusedBorder: UnderlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.brown),
                    //     ),
                    //     enabledBorder: UnderlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.brown),
                    //     ),
                    //   ),
                    // ),
                  ]),
                ),
                SizedBox(height: 20),
                ButtonOffer(
                  onPressed: () {
                    salvar("");

                    final snackBar = SnackBar(
                        backgroundColor: AppColors.primaryColor,
                        content: Container(
                            height: 40,
                            child: Center(
                                child: const Text('Informações salvas !'))));
                    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  colorText: AppColors.primaryBackground,
                  text: 'Salvar',
                  colorButton: AppColors.primaryColor,
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
