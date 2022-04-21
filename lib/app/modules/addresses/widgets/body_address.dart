import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/cepApiBrasil.dart';
import 'package:poraki/app/data/models/enderecos.dart';
import 'package:poraki/app/data/models/sql/sqlEndereco.dart';
import 'package:poraki/app/data/repositories/CepApiBrasil_repository.dart';
import 'package:poraki/app/modules/addresses/address_controller.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/home/widgets/gradient_header_home.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'package:poraki/app/routes/app_routes.dart';

class AddressBody extends StatefulWidget {
  AddressBody({
    Key? key,
    // required this.controller,
  }) : super(key: key);

  AddressController _controller = Get.find(); // Get.put(AddressController());

  @override
  _AddressBodyState createState() => _AddressBodyState();
}

class _AddressBodyState extends State<AddressBody> {

  FocusNode txtEnderecoNroFocus = new FocusNode();
  var tipos = ["Casa", "Trabalho", "Estudo", "Outros"];
  var tipoSel = "Casa";

  void _dropDownItemSelected(String novoItem){
    setState(() {
      this.tipoSel = novoItem;
    });
  }

  Future<void> tornarEndAtual (String enderecoGuid) async {
    widget._controller.tornarEnderecoAtual(enderecoGuid);
  }

  Future<void> salvar () async {
    var end = new Enderecos(widget._controller.enderecoSingle.enderecoGuid, widget._controller.enderecoSingle.usuEmail, widget._controller.enderecoSingle.usuGuid,
        widget._controller.txtCEP.text.removeAllWhitespace, widget._controller.txtEnderecoLogra.text.trimRight(), widget._controller.txtEnderecoNumero.text.trimRight(),
        widget._controller.txtEnderecoCompl?.text.trimRight(), tipoSel, widget._controller.enderecoSingle.enderecoAtual, widget._controller.enderecoSingle.enderecoUltData,
        null, widget._controller.enderecoSingle.enderecoLat, widget._controller.enderecoSingle.enderecoLong);

        //DateTime.now().toString());
    await widget._controller.adicionaEndereco(end);
  }

  Future<void> buscaCep() async {
    CepApiBrasil cepApi = await CepApiBrasilRepository().getCepApiBrasil(widget._controller.txtCEP.text.trimLeft().trimRight());

    widget._controller.txtEnderecoLogra.text = cepApi.street!;
    if(widget._controller.txtEnderecoLogra.text.isNotEmpty)
      FocusScope.of(context).requestFocus(txtEnderecoNroFocus);

    //widget._controller.txtEnderecoTipo.text.trimLeft().trimRight(),
  }

  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.find();
    Color textDark = _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'textDark').first.coreValor.toString());

    return FutureBuilder(
        future: widget._controller.bindEndereco(),
        builder: (context, futuro) {
          if (futuro.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); //Text('carrinho vazio'));
            // } else if (futuro.hasError) {
            //   return Center(child: Text(futuro.error.toString()));
          }
          else {
            return SingleChildScrollView(
              child: GradientHeaderHome(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: 20),
                        Center(child: Text("Endereço",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 22),),),
                        Form(
                          // key: controller.formKey,
                          child: Column(
                              children: [
                                TextFormField(
                                  // validator: (value) {
                                  //   if (value!.length < 4) {
                                  //     return "Digite um nome maior";
                                  //   }
                                  //   return null;
                                  // },
                                  controller: widget._controller.txtCEP,
                                  autofocus: true,
                                  style: TextStyle(color: textDark),
                                    decoration: InputDecoration(
                                    labelText: "CEP",
                                    labelStyle: TextStyle(color: textDark),
                                      prefixIcon: Icon(
                                      Icons.map,
                                      color: textDark,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: textDark),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: textDark),
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
                                  controller: widget._controller.txtEnderecoLogra,
                                  keyboardType: TextInputType.streetAddress,
                                  autofocus: true,
                                  style: TextStyle(color: textDark),
                                  decoration: InputDecoration(
                                    labelText: "Endereço SEM o número",
                                    labelStyle: TextStyle(color: textDark),
                                    prefixIcon: Icon(
                                      Icons.location_on_outlined,
                                      color: textDark,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: textDark),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: textDark),
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
                                  controller: widget._controller.txtEnderecoNumero,
                                  keyboardType: TextInputType.number,
                                  autofocus: true,
                                  focusNode: txtEnderecoNroFocus,
                                  style: TextStyle(color: textDark),
                                  decoration: InputDecoration(
                                    labelText: "Número",
                                    labelStyle: TextStyle(color: textDark),
                                    prefixIcon: Icon(
                                      Icons.format_list_numbered,
                                      color: textDark,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: textDark),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: textDark),
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
                                  controller: widget._controller.txtEnderecoCompl,
                                  autofocus: true,
                                  style: TextStyle(color: textDark),
                                  decoration: InputDecoration(
                                    labelText: "Complemento (apto, bloco, etc...)",
                                    labelStyle: TextStyle(color: textDark),
                                    prefixIcon: Icon(
                                      Icons.location_city_outlined,
                                      color: textDark,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: textDark),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: textDark),
                                    ),
                                  ),
                                ),
                                Text('Tipo'),
                                DropdownButton<String>(
                                  items: tipos.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  value: tipoSel,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      tipoSel = newValue!;
                                    });
                                  },

                                  // onChanged: (String value) {
                                  //   setState(() {
                                  //     tipoSel = value;
                                  //   });
                                  // },
                                ),
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
                              ]
                          ),
                        ),
                        SizedBox(height: 20),
                        ButtonOffer(
                          onPressed: () {
                            salvar();

                            final snackBar = SnackBar(
                                backgroundColor: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'textDark').first.coreValor.toString()),
                                content: Container( height: 40, child: Center(child: const Text('Informações salvas 1!'))));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          },
                          colorText: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'textLight').first.coreValor.toString()),
                          text: 'Salvar',
                          colorButton: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'iconColor').first.coreValor.toString()),
                        ),
                        ButtonOffer(
                          onPressed: () {
                            // salva e define como endereço atual
                            salvar();

                            final snackBar = SnackBar(
                                backgroundColor: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'textDark').first.coreValor.toString()),
                                content: Container( height: 40, child: Center(child: const Text('Definido como endereço atual'))));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);

                            Get.toNamed(AppRoutes.addresses);

                          },
                          colorText: textDark,
                          text: 'Definir como endereço atual',
                          colorButton: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backLight').first.coreValor.toString()),
                        ),
                        // )
                      ]
                  )
                // ],
              ),
            );
            // );
          }
        });
  }
}
