import 'dart:io';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poraki/app/data/models/cepApiBrasil.dart';
import 'package:poraki/app/data/repositories/CepApiBrasil_repository.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/home/widgets/gradient_header_home.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'package:poraki/app/routes/app_routes.dart';
import '../store_controller.dart';

class StoreBody extends StatefulWidget {
  StoreBody({Key? key}) : super(key: key);

  @override
  State<StoreBody> createState() => _StoreBodyState();
}

class _StoreBodyState extends State<StoreBody> {
  File? image;
  bool isEditing = false;
  bool imgEdited = false;
  String storeGuid = '';
  String imgcloud = '';
  FocusNode txtLojaNroFocus = new FocusNode();
  StoreController storeController = Get.find();
  LoginController _loginController = Get.find();
  bool valAceitaPoraki10 = false;
  DateTime valDataCupomDe = new DateTime.now();
  DateTime valDataCupomAte = new DateTime.now();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext buildContext) {
    Color textColor = _loginController.colorFromHex(_loginController.listCore
        .where((coreItem) => coreItem.coreChave == 'textDark')
        .first
        .coreValor
        .toString());

    return Container(child: GetBuilder<StoreController>(builder: (context) {
      if (storeController.isLoading) {
        return Center(
          child: Container(),
        );
      } else {
        if (storeController.loja != null) {
          Future.delayed(Duration.zero, () async {
            storeController.bindLoja();
          });
          imgcloud =
              'https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/lojas%2F' +
                  storeController.loja!.LojaGUID.toString() +
                  '.jpg?alt=media';
        }
        return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(double.maxFinite, 55),
              child: AppBar(
                // elevation: 0,
                centerTitle: false,
                backgroundColor: _loginController.colorFromHex(_loginController
                    .listCore
                    .where((coreItem) => coreItem.coreChave == 'backLight')
                    .first
                    .coreValor
                    .toString()),
                title: Text(
                  'Loja',
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
                  // key: controller.formKey,
                  child: ListView(children: [
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
                      controller: storeController.txtLojaNome,
                      // keyboardType: TextInputType.streetAddress,
                      autofocus: true,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Nome da Loja",
                        labelStyle: TextStyle(color: textColor),
                        prefixIcon: Icon(
                          Icons.storefront_rounded,
                          color: textColor,
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
                      controller: storeController.txtLojaSlogan,
                      // keyboardType: TextInputType.number,
                      autofocus: true,
                      // focusNode: txtEnderecoNroFocus,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Slogan",
                        labelStyle: TextStyle(color: textColor),
                        prefixIcon: Icon(
                          Icons.local_offer_outlined,
                          color: textColor,
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
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CnpjInputFormatter(),
                      ],
                      controller: storeController.txtLojaCNPJ,

                      onFieldSubmitted: (cnpj) {
                        if (!CNPJValidator.isValid(cnpj)) {
                          Get.defaultDialog(
                              title: "CNPJ Inválido",
                              middleText: "Por favor informe um CNPJ válido");
                        }
                        {}
                      },
                      autofocus: true,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "CNPJ",
                        labelStyle: TextStyle(color: textColor),
                        prefixIcon: Icon(
                          Icons.work_outline,
                          color: textColor,
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
                      controller: storeController.txtLojaRazao,
                      autofocus: true,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Razão Social",
                        labelStyle: TextStyle(color: textColor),
                        prefixIcon: Icon(
                          Icons.location_city_outlined,
                          color: textColor,
                        ),
                      ),
                    ),
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
                      controller: storeController.txtLojaCEP,
                      autofocus: true,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(),
                        labelText: "CEP",
                        labelStyle: TextStyle(color: textColor),
                        prefixIcon: Icon(
                          Icons.location_on_outlined,
                          color: textColor,
                        ),
                      ),
                      onEditingComplete: () {
                        buscaCep();
                      },
                    ),
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
                      controller: storeController.txtLojaLogra,
                      keyboardType: TextInputType.streetAddress,
                      autofocus: true,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Endereço SEM o número",
                        labelStyle: TextStyle(color: textColor),
                        prefixIcon: Icon(
                          Icons.location_on_outlined,
                          color: textColor,
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
                      controller: storeController.txtLojaNumero,
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      focusNode: txtLojaNroFocus,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Número",
                        labelStyle: TextStyle(color: textColor),
                        prefixIcon: Icon(
                          Icons.format_list_numbered,
                          color: textColor,
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
                      controller: storeController.txtLojaCompl,
                      autofocus: true,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Complemento (apto, bloco, etc...)",
                        labelStyle: TextStyle(color: textColor),
                        prefixIcon: Icon(
                          Icons.location_city_outlined,
                          color: textColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    //   Row(
                    //     children: <Widget>[
                    //       Checkbox(
                    //         value: this.valAceitaPoraki10,
                    //         onChanged: (val) {
                    //           setState(() {
                    //             this.valAceitaPoraki10 = val!;
                    //           });
                    //         },
                    //         activeColor: Colors.blue,
                    //       ),
                    //       const SizedBox(width: 20),
                    //       Text('PORAKI10 - Aceita cupom de 10% na primeira compra'),
                    //       const SizedBox(height: 20)
                    //     ],
                    //   ),
                    //   const SizedBox(height: 20),
                    //   TextFormField(
                    //     // validator: (value) {
                    //     //   if (value!.length != 11) {
                    //     //     return "Por favor digite um telefone válido";
                    //     //   }
                    //     //   return null;
                    //     // },
                    //     controller: storeController.txtLojaCompl,
                    //     autofocus: true,
                    //     style: TextStyle(color: textColor),
                    //     decoration: InputDecoration(
                    //       border: OutlineInputBorder(),
                    //       labelText: "Outro CUPOM",
                    //       labelStyle: TextStyle(color: textColor),
                    //       prefixIcon: Icon(
                    //         Icons.location_city_outlined,
                    //         color: textColor,
                    //       ),
                    //     ),
                    //   ),
                    //   const SizedBox(height: 20),
                    // Column(children: <Widget>[
                    //   const SizedBox(height: 10),
                    //   TextFormField(
                    //     controller:
                    //     storeController.txtPercCupom,
                    //     decoration: InputDecoration(
                    //       labelText: 'Percentual do Cupom',
                    //       border: OutlineInputBorder(),
                    //     ),
                    //     keyboardType: TextInputType.number,
                    //     validator: (value) {
                    //       int xPercCupom =
                    //       int.parse(value.toString());
                    //       if (xPercCupom <= 0 || xPercCupom >= 100)
                    //         return 'Precisa ser maior do que zero e menor do que 100';
                    //       return null;
                    //     },
                    //   )]),
                    //
                    //   const SizedBox(height: 20),
                    //   Row(
                    //     children: <Widget>[
                    //       Text('A partir de: '),
                    //       ElevatedButton(
                    //           onPressed: () {
                    //             showDatePicker(
                    //                 context: buildContext,
                    //                 initialDate: DateTime.now(),
                    //                 firstDate: DateTime.now(),
                    //                 lastDate: DateTime.now()
                    //                     .add(Duration(days: 1000)))
                    //                 .then((value) => setState(() {
                    //               valDataCupomDe =
                    //               value!;
                    //             }));
                    //           },
                    //           style: ButtonStyle(
                    //               backgroundColor:
                    //               MaterialStateProperty.all<Color>(
                    //                 _loginController.colorFromHex(
                    //                     _loginController.listCore
                    //                         .where((coreItem) =>
                    //                     coreItem.coreChave ==
                    //                         'backDark')
                    //                         .first
                    //                         .coreValor
                    //                         .toString()),
                    //               )),
                    //           child: Row(
                    //             children: [
                    //               Icon(Icons.calendar_today_rounded),
                    //               const SizedBox(
                    //                 width: 16,
                    //               ),
                    //               Text(valDataCupomDe.day
                    //                   .toString() +
                    //                   '/' +
                    //                   valDataCupomDe.month
                    //                       .toString() +
                    //                   '/' +
                    //                   valDataCupomDe.year
                    //                       .toString())
                    //             ],
                    //           )),
                    //       const SizedBox(height: 20),
                    //     ],
                    //   ),
                    //   const SizedBox(height: 20),
                    //   Row(
                    //     children: <Widget>[
                    //       Text('Até: '),
                    //       ElevatedButton(
                    //           onPressed: () {
                    //             showDatePicker(
                    //                 context: buildContext,
                    //                 initialDate: DateTime.now(),
                    //                 firstDate: DateTime.now(),
                    //                 lastDate: DateTime.now()
                    //                     .add(Duration(days: 1000)))
                    //                 .then((value) => setState(() {
                    //               valDataCupomAte =
                    //               value!;
                    //             }));
                    //           },
                    //           style: ButtonStyle(
                    //               backgroundColor:
                    //               MaterialStateProperty.all<Color>(
                    //                 _loginController.colorFromHex(
                    //                     _loginController.listCore
                    //                         .where((coreItem) =>
                    //                     coreItem.coreChave ==
                    //                         'backDark')
                    //                         .first
                    //                         .coreValor
                    //                         .toString()),
                    //               )),
                    //           child: Row(
                    //             children: [
                    //               Icon(Icons.calendar_today_rounded),
                    //               const SizedBox(
                    //                 width: 16,
                    //               ),
                    //               Text(valDataCupomAte.day
                    //                   .toString() +
                    //                   '/' +
                    //                   valDataCupomAte.month
                    //                       .toString() +
                    //                   '/' +
                    //                   valDataCupomAte.year
                    //                       .toString())
                    //             ],
                    //           )),
                    //       const SizedBox(height: 20),
                    //     ],
                    //   ),
                    const SizedBox(height: 20),

                    ElevatedButton(
                        onPressed: () => pegarImagemGaleria(),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                          _loginController.colorFromHex(_loginController
                              .listCore
                              .where((coreItem) =>
                                  coreItem.coreChave == 'backDark')
                              .first
                              .coreValor
                              .toString()),
                        )),
                        child: Row(
                          children: [
                            Icon(Icons.photo_album),
                            const SizedBox(
                              width: 16,
                            ),
                            Text('Adicionar Logotipo')
                          ],
                        )),
                    SizedBox(height: 20),

                    if (imgcloud != '')
                      CachedNetworkImage(
                        imageUrl: imgcloud,
                        height: 250,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.local_offer_outlined),
                      ),

                    // FadeInImage.assetNetwork(
                    //   placeholder: 'assets/images/pholder.png',
                    //   image: imgcloud,
                    //   imageErrorBuilder: (context, url, error) =>
                    //       new Icon(Icons.store),
                    //   height: 250,
                    // ),

                    if (image != null)
                      Image.file(
                        image!,
                        fit: BoxFit.contain,
                      ),
                    SizedBox(height: 20),
                    ButtonOffer(
                      onPressed: () {
                        salvar().then(
                            (value) => Get.offAndToNamed(AppRoutes.stores));

                        Get.defaultDialog(
                            title: "Aviso",
                            middleText: "Informações atualizadas com sucesso!");

                        // final snackBar = SnackBar(
                        //     backgroundColor: _loginController.colorFromHex(
                        //         _loginController.listCore
                        //             .where((coreItem) =>
                        //                 coreItem.coreChave == 'textDark')
                        //             .first
                        //             .coreValor
                        //             .toString()),
                        //     content: Container(
                        //         height: 40,
                        //         child: Center(
                        //             child:
                        //                 const Text('Informações salvas 1!'))));
                        //ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      colorText: _loginController.colorFromHex(_loginController
                          .listCore
                          .where(
                              (coreItem) => coreItem.coreChave == 'textLight')
                          .first
                          .coreValor
                          .toString()),
                      text: 'Salvar',
                      colorButton: _loginController.colorFromHex(
                          _loginController.listCore
                              .where((coreItem) =>
                                  coreItem.coreChave == 'iconColor')
                              .first
                              .coreValor
                              .toString()),
                    ),

                    if (storeController.loja != null)
                      ButtonOffer(
                        onPressed: () async {
                          await storeController.apagaLoja(storeController.loja).then((value) => Get.offAndToNamed(AppRoutes.stores));

                          Get.defaultDialog(
                              title: "Aviso",
                              middleText: "Loja removida do Poraki !");

                        },
                        colorText: _loginController.colorFromHex(_loginController
                            .listCore
                            .where((coreItem) => coreItem.coreChave == 'textDark')
                            .first
                            .coreValor
                            .toString()),
                        text: 'Apagar Loja',
                        colorButton: _loginController.colorFromHex(
                            _loginController.listCore
                                .where((coreItem) =>
                                    coreItem.coreChave == 'textLight')
                                .first
                                .coreValor
                                .toString()),
                      ),

                  ])
                  // ],
                  ),
            )));
      }
    }));
  }

  Future<void> salvar() async {
    var storeGuidTemp = await storeController.saveLoja();
    storeGuid = storeGuidTemp.toString();

    await uploadFoto(image == null ? null : image);

    await _loginController.loadStoresData();
  }

  Future<void> buscaCep() async {
    CepApiBrasil cepApi = await CepApiBrasilRepository().getCepApiBrasil(
        storeController.txtLojaCEP.text.trimLeft().trimRight());

    storeController.txtLojaLogra.text = cepApi.street!;
    if (storeController.txtLojaLogra.text.isNotEmpty)
      FocusScope.of(context).requestFocus(txtLojaNroFocus);
  }

  Future pegarImagemGaleria() async {
    try {
      final foto = await ImagePicker().pickImage(
          source: ImageSource.gallery, imageQuality: 70, maxHeight: 300);
      if (foto == null) return;

      final imageTemp = File(foto.path);

      setState(() => this.image = imageTemp);

      imgEdited = true;
    } on PlatformException catch (e) {
      print('erro tentando abrir album de fotos: $e');
    }
  }

  uploadFoto(File? foto) async {
    // await _saveForm();

    if (imgEdited && foto != null) {
      await Firebase.initializeApp();

      print('passou no upload');
      Reference ref = FirebaseStorage.instance
          .ref()
          .child("lojas")
          .child(storeGuid + '.jpg');

      await ref.putFile(image!);
      //var downloadURL = await ref.getDownloadURL();
    }
    // showSnackBar("Oferta salva! - " + widget.offerGuid, Duration(seconds: 3));
  }
}
