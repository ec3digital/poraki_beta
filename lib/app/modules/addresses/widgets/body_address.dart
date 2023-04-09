import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/cepApiBrasil.dart';
import 'package:poraki/app/data/models/enderecos.dart';
import 'package:poraki/app/data/repositories/CepApiBrasil_repository.dart';
import 'package:poraki/app/modules/addresses/address_controller.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/home/widgets/gradient_header_home.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'package:poraki/app/routes/app_routes.dart';
import 'package:poraki/app/util/dialog_helper.dart';
import 'package:uuid/uuid.dart';

enum TiposEnd { Casa, Trabalho, Estudo, Outros }

class AddressBody extends StatefulWidget {
  String enderecoGuid = '';
  AddressBody({Key? key, required this.enderecoGuid}) : super(key: key);

  final AddressController _controller = Get.put(AddressController());
  final LoginController _loginController = Get.find();

  var _endGuid = '';
  bool load = true;

  @override
  _AddressBodyState createState() => _AddressBodyState();
}

class _AddressBodyState extends State<AddressBody> {
  final FocusNode txtEnderecoNroFocus = new FocusNode();
  final _form = GlobalKey<FormState>();
  TiposEnd tiposEnd = TiposEnd.Casa;
  var tipoSel = "Casa";

  Future<void> tornarEndAtual(String enderecoGuid) async {
    await salvar(enderecoGuid);
    await widget._controller.tornarEnderecoAtual(enderecoGuid);
  }

  Future<void> salvar(String enderecoGuid) async {
    final LoginController _loginController = Get.find();

    var end = new Enderecos(
        enderecoGuid == '' ? Uuid().v4() : enderecoGuid,
        _loginController.usuEmail,
        _loginController.usuGuid,
        widget._controller.txtCEP.text.removeAllWhitespace,
        widget._controller.txtEnderecoLogra.text.trimRight(),
        widget._controller.txtEnderecoNumero.text.trimRight(),
        widget._controller.txtEnderecoCompl?.text.trimRight(),
        tipoSel,
        false,
        Timestamp.fromDate(DateTime.now()).toDate(),
        null,
        null,
        null);

    //DateTime.now().toString());
    if (enderecoGuid == '')
      await widget._controller.adicionaEndereco(end);
    else
      await widget._controller.atualizaEndereco(end);

    await _loginController.loadAddressData();
  }

  Future<bool> buscaCep() async {
    CepApiBrasil cepApi = await CepApiBrasilRepository()
        .getCepApiBrasil(widget._controller.txtCEP.text.trimLeft().trimRight());

    //await Future.delayed(const Duration(seconds: 2));

    widget._controller.txtEnderecoLogra.text = cepApi.street!;
    if (widget._controller.txtEnderecoLogra.text.isNotEmpty)
      FocusScope.of(context).requestFocus(txtEnderecoNroFocus);

    return true;
  }

  Color textDark = Colors.black;
  List<DropdownMenuItem<String>> dropDownMenuItems = [];
  var tipos = ["Casa", "Trabalho", "Estudo", "Outros"];

  Future<void> bind() async {
    if (widget.load) {
      print('bind()');

      dropDownMenuItems = tipos
          .map(
            (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
          )
          .toList();

      textDark = widget._loginController.colorFromHex(widget
          ._loginController.listCore
          .where((coreItem) => coreItem.coreChave == 'textDark')
          .first
          .coreValor
          .toString());

      try {
        var args = ModalRoute.of(context)?.settings.arguments
            as List<Map<String, String?>>;
        widget._endGuid =
            args[0].values.first.toString(); // .first.values.first.toString();
        print('_endGuid: ' + widget._endGuid);
      } catch (e) { print (e.toString()); }

      await widget._controller.bindEndereco(widget._endGuid);
      tipoSel = (widget._endGuid == ''
          ? 'Casa'
          : widget._loginController.listaEnderecos.where((end) => end.EnderecoGuid == widget._endGuid).first.EnderecoTipo)!;
      widget.load = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // bool isLoading = false;
    Color textColor = widget._loginController.colorFromHex(widget._loginController.listCore
        .where((coreItem) => coreItem.coreChave == 'textDark')
        .first
        .coreValor
        .toString());

    return FutureBuilder(
        future: widget.load ? bind() : null,
        builder: (context, futuro) {
          if (futuro.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); //Text('carrinho vazio'));
            // } else if (futuro.hasError) {
            //   return Center(child: Text(futuro.error.toString()));
          } else {
            return Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size(double.maxFinite, 55),
                  child: AppBar(
                    // elevation: 0,
                    centerTitle: false,
                    backgroundColor: widget._loginController.colorFromHex(
                        widget._loginController
                            .listCore
                            .where(
                                (coreItem) => coreItem.coreChave == 'backLight')
                            .first
                            .coreValor
                            .toString()),
                    title: Text(
                      'Endereço',
                      style: TextStyle(fontSize: 25, color: textColor),
                    ),
                  ),
                ),
                body:
                    // SingleChildScrollView(
                    //     child:
                    GradientHeaderHome(
                        child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                      key: _form,
                      child: ListView(children: [
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          // validator: (value) {
                          //   if (value!.length < 4) {
                          //     return "Digite um nome maior";
                          //   }
                          //   return null;
                          // },
                          controller: widget._controller.txtCEP,
                          //autofocus: true,
                          style: TextStyle(color: textDark),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            labelText: "CEP",
                            labelStyle: TextStyle(color: textDark),
                            prefixIcon: Icon(
                              Icons.map,
                              color: textDark,
                            ),
                          ),
                          onEditingComplete: () async {
                            await buscaCep();
                          },
                        ),

                        // TODO: colocar o progress na busca do CEP

                        const SizedBox(
                          height: 20,
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
                          // autofocus: true,
                          style: TextStyle(color: textDark),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Endereço SEM o número",
                            labelStyle: TextStyle(color: textDark),
                            prefixIcon: Icon(
                              Icons.location_on_outlined,
                              color: textDark,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
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
                          // autofocus: true,
                          // focusNode: txtEnderecoNroFocus,
                          style: TextStyle(color: textDark),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Número",
                            labelStyle: TextStyle(color: textDark),
                            prefixIcon: Icon(
                              Icons.format_list_numbered,
                              color: textDark,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          // validator: (value) {
                          //   if (value!.length != 11) {
                          //     return "Por favor digite um telefone válido";
                          //   }
                          //   return null;
                          // },
                          controller: widget._controller.txtEnderecoCompl,
                          // autofocus: true,
                          style: TextStyle(color: textDark),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Complemento (apto, bloco, etc...)",
                            labelStyle: TextStyle(color: textDark),
                            prefixIcon: Icon(
                              Icons.location_city_outlined,
                              color: textDark,
                            ),
                          ),
                        ),
                        ListTile(
                          title: const Text('Tipo:'),
                          trailing: DropdownButton<String>(
                            // Must be one of items.value.
                            value: tipoSel,
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() => tipoSel = newValue);
                              }
                            },
                            items: dropDownMenuItems,
                          ),
                        ),
                        SizedBox(height: 20),
                        ButtonOffer(
                          onPressed: () {
                            salvar(widget._endGuid).then((value) =>
                                Get.offAndToNamed(AppRoutes.addresses));

                            Get.defaultDialog(
                                title: "Aviso",
                                middleText:
                                    "Informações atualizadas com sucesso!");

                            // final snackBar = SnackBar(
                            //     backgroundColor: widget._loginController
                            //         .colorFromHex(widget
                            //             ._loginController.listCore
                            //             .where((coreItem) =>
                            //                 coreItem.coreChave == 'textDark')
                            //             .first
                            //             .coreValor
                            //             .toString()),
                            //     content: Container(
                            //         height: 40,
                            //         child: Center(
                            //             child: const Text(
                            //                 'Informações salvas 1!'))));
                            // ScaffoldMessenger.of(context)
                            //     .showSnackBar(snackBar);
                          },
                          colorText: widget._loginController.colorFromHex(widget
                              ._loginController.listCore
                              .where((coreItem) =>
                                  coreItem.coreChave == 'textLight')
                              .first
                              .coreValor
                              .toString()),
                          text: 'Salvar',
                          colorButton: widget._loginController.colorFromHex(
                              widget._loginController.listCore
                                  .where((coreItem) =>
                                      coreItem.coreChave == 'iconColor')
                                  .first
                                  .coreValor
                                  .toString()),
                        ),
                        ButtonOffer(
                          onPressed: () {
                            // salva e define como endereço atual
                            //salvar(widget._endGuid);
                            tornarEndAtual(widget._endGuid).then((value) =>
                                Get.offAndToNamed(AppRoutes.addresses));

                            Get.defaultDialog(
                                title: "Aviso",
                                middleText: "Definido como endereço atual");

                            // final snackBar = SnackBar(
                            //     backgroundColor: widget._loginController
                            //         .colorFromHex(widget
                            //             ._loginController.listCore
                            //             .where((coreItem) =>
                            //                 coreItem.coreChave == 'textDark')
                            //             .first
                            //             .coreValor
                            //             .toString()),
                            //     content: Container(
                            //         height: 40,
                            //         child: Center(
                            //             child: const Text(
                            //                 'Definido como endereço atual'))));
                            // ScaffoldMessenger.of(context)
                            //     .showSnackBar(snackBar);

                            //Get.toNamed(AppRoutes.addresses);
                          },
                          colorText: textDark,
                          text: 'Definir como endereço atual',
                          colorButton: widget._loginController.colorFromHex(
                              widget._loginController.listCore
                                  .where((coreItem) =>
                                      coreItem.coreChave == 'backLight')
                                  .first
                                  .coreValor
                                  .toString()),
                        ),
                      ])
                      // ],
                      ),
                )));
          }
        });
  }
}
