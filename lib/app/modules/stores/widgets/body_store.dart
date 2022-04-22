import 'dart:io';
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
import 'package:poraki/app/modules/stores/widgets/app_bar_store.dart';
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

  @override
  Widget build(BuildContext context) {
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
            appBar: appBarStore(),
            body: SingleChildScrollView(
              child: GradientHeaderHome(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    // SizedBox(height: 20),
                    // Center(
                    //   child: Text(
                    //     "Loja",
                    //     textAlign: TextAlign.center,
                    //     style: TextStyle(fontSize: 22),
                    //   ),
                    // ),
                    Form(
                      // key: controller.formKey,
                      child: Column(children: [
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
                          controller: storeController.txtLojaSlogan,
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
                          controller: storeController.txtLojaCNPJ,
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
                          controller: storeController.txtLojaRazao,
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
                          controller: storeController.txtLojaLogra,
                          keyboardType: TextInputType.streetAddress,
                          autofocus: true,
                          style: TextStyle(color: textColor),
                          decoration: InputDecoration(
                            labelText: "Endereço SEM o número",
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
                            labelText: "Número",
                            labelStyle: TextStyle(color: textColor),
                            prefixIcon: Icon(
                              Icons.format_list_numbered,
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
                          controller: storeController.txtLojaCompl,
                          autofocus: true,
                          style: TextStyle(color: textColor),
                          decoration: InputDecoration(
                            labelText: "Complemento (apto, bloco, etc...)",
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
                    SizedBox(height: 20),
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
                      FadeInImage.assetNetwork(
                        placeholder: 'assets/images/pholder.png',
                        image: imgcloud,
                        imageErrorBuilder: (context, url, error) =>
                            new Icon(Icons.store),
                        height: 250,
                      ),
                    if (image != null)
                      Image.file(
                        image!,
                        fit: BoxFit.contain,
                      ),
                    SizedBox(height: 20),
                    ButtonOffer(
                      onPressed: () {
                        salvar();

                        final snackBar = SnackBar(
                            backgroundColor: _loginController.colorFromHex(
                                _loginController.listCore
                                    .where((coreItem) =>
                                        coreItem.coreChave == 'textDark')
                                    .first
                                    .coreValor
                                    .toString()),
                            content: Container(
                                height: 40,
                                child: Center(
                                    child:
                                        const Text('Informações salvas 1!'))));
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
                  ])
                  ),
            ));
      }
    }));
  }

  Future<void> salvar() async {
    var storeGuidTemp = await storeController.saveLoja();
    storeGuid = storeGuidTemp.toString();

    uploadFoto(
        image == null ? null : image);

    Get.offAndToNamed(AppRoutes.stores);
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
