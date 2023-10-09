import 'dart:io';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/events/event_controller.dart';
import 'package:poraki/app/modules/home/widgets/gradient_header_home.dart';
import 'package:poraki/app/routes/app_routes.dart';

class NewEventPage extends StatefulWidget {
  NewEventPage({Key? key}) : super(key: key);

  @override
  State<NewEventPage> createState() => _NewEventPage();
}

class _NewEventPage extends State<NewEventPage> {
  File? image;
  bool isEditing = false;
  bool isLoading = false;
  bool imgEdited = false;
  String eventGuid = '';
  String imgcloud = '';
  FocusNode txtLojaNroFocus = new FocusNode();
  EventController _eventController = Get.find();
  LoginController _loginController = Get.find();
  final _formEvtKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext buildContext) {
    Color textColor = _loginController.colorFromHex(_loginController.listCore
        .where((coreItem) => coreItem.coreChave == 'textDark')
        .first
        .coreValor
        .toString());

    return FutureBuilder<EventController>(builder: (context, futuro) {
      // if (isLoading) {
      //   return Center(
      //     child: Container(),
      //   );
      // } else {
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
                'Evento',
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
                autovalidateMode: AutovalidateMode.always,
                // key: _loginController.formKey,
                key: _formEvtKey,
                child: ListView(children: [
                  const SizedBox(
                    height: 20,
                  ),

                  ElevatedButton(
                      onPressed: () => pegarImagemGaleria(),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                        _loginController.colorFromHex(_loginController.listCore
                            .where(
                                (coreItem) => coreItem.coreChave == 'backDark')
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
                          Text('Adicionar foto')
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

                  TextFormField(
                    validator: (valueNome) => valueNome.toString().length < 3
                        ? "Por favor informe um nome maior"
                        : null,
                    controller: _eventController.txtEventoNome,
                    keyboardType: TextInputType.text,
                    autofocus: false, // true,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nome do Evento",
                      labelStyle: TextStyle(color: textColor),
                      // prefixIcon: Icon(
                      //   Icons.storefront_rounded,
                      //   color: textColor,
                      // ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (valueLocal) => valueLocal.toString().length < 3
                        ? "Por favor informe o Local correto"
                        : null,
                    controller: _eventController.txtEventoLocal,
                    keyboardType: TextInputType.text,
                    autofocus: false, // true,
                    // focusNode: txtEnderecoNroFocus,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nome do Local",
                      labelStyle: TextStyle(color: textColor),
                      prefixIcon: Icon(
                        Icons.near_me_outlined,
                        color: textColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _eventController.txtEventoEndereco,
                    keyboardType: TextInputType.streetAddress,
                    autofocus: false, // true,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Endereço (opcional) ",
                      labelStyle: TextStyle(color: textColor),
                      prefixIcon: Icon(
                        Icons.place_outlined,
                        color: textColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (valueData) => valueData.toString().length < 10
                        ? "Por favor informe a data do evento"
                        : null,
                    keyboardType: TextInputType.datetime,
                    controller: _eventController.txtEventoData,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      DataInputFormatter(),
                    ],
                    //keyboardAppearance: Brightness.dark,
                    autofocus: false, // true,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Data do Evento",
                      labelStyle: TextStyle(color: textColor),
                      prefixIcon: Icon(
                        Icons.calendar_today_outlined,
                        color: textColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // TextFormField(
                  //   // validator: (value) {
                  //   //   if (value!.length != 11) {
                  //   //     return "Por favor digite um telefone válido";
                  //   //   }
                  //   //   return null;
                  //   // },
                  //   controller: _eventController.txtEventoHora,
                  //   autofocus: false, // true,
                  //   style: TextStyle(color: textColor),
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     labelText: "Horário do evento",
                  //     labelStyle: TextStyle(color: textColor),
                  //     prefixIcon: Icon(
                  //       Icons.phone_enabled_outlined,
                  //       color: textColor,
                  //     ),
                  //   ),
                  // ),

                  Row(
                    children: <Widget>[
                      const SizedBox(height: 5, width: 5),
                      Text(
                        'Horário do evento: ',
                        style: TextStyle(fontSize: 16, color: textColor),
                      ),
                      const SizedBox(width: 5),
                      ElevatedButton(
                          onPressed: () {
                            showTimePicker(
                                    initialEntryMode: TimePickerEntryMode.input,
                                    context: this.context,
                                    initialTime:
                                        TimeOfDay(hour: 08, minute: 00))
                                .then((value) => setState(() {
                                      _eventController.valEventoHora = value!
                                              .hour
                                              .toString()
                                              .padLeft(2, '0') +
                                          ':' +
                                          value.minute
                                              .toString()
                                              .padLeft(2, '0');
                                    }));
                          },
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
                              Icon(Icons.access_time_outlined),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(_eventController.valEventoHora.toString())
                            ],
                          )),
                      const SizedBox(width: 5),
                    ],
                  ),
                  //
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // TextFormField(
                  //   // validator: (value) {
                  //   //   if (value!.length < 4) {
                  //   //     return "Digite um nome maior";
                  //   //   }
                  //   //   return null;
                  //   // },
                  //   keyboardType: TextInputType.streetAddress,
                  //   controller: _eventController.txtEventoEndereco,
                  //   autofocus: false, // true,
                  //   style: TextStyle(color: textColor),
                  //   decoration: InputDecoration(
                  //     filled: true,
                  //     border: OutlineInputBorder(),
                  //     labelText: "Endereço (opcional) ",
                  //     labelStyle: TextStyle(color: textColor),
                  //     // prefixIcon: Icon(
                  //     //   Icons.location_on_outlined,
                  //     //   color: textColor,
                  //     // ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _eventController.txtEventoDetalhes,
                    keyboardType: TextInputType.text,
                    // autofocus: true,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Detalhes do Evento (opcional)",
                      labelStyle: TextStyle(color: textColor),
                    ),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () async {
                      if (_formEvtKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });

                        await salvar().then((value) {
                          setState(() {
                            isLoading = false;
                          });

                          Get.offAndToNamed(AppRoutes.events);
                        });

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
                      }
                    },
                    child: (isLoading)
                        ? const SizedBox(
                            // width: 16,
                            height: 50,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 1.5,
                            ))
                        : Text(
                            "Salvar",
                            style: TextStyle(
                                color: _loginController.colorFromHex(
                                    _loginController.listCore
                                        .where((coreItem) =>
                                            coreItem.coreChave == 'textLight')
                                        .first
                                        .coreValor
                                        .toString()),
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        _loginController.colorFromHex(_loginController.listCore
                            .where(
                                (coreItem) => coreItem.coreChave == 'iconColor')
                            .first
                            .coreValor
                            .toString()),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ])
                // ],
                ),
          )));
      //}
    });
  }

  Future<void> salvar() async {
    eventGuid = await _eventController.novoEvento();

    await uploadFoto(image == null ? null : image);

    // await _loginController.loadStoresData();
  }

  Future pegarImagemGaleria() async {
    try {
      final foto = await ImagePicker().pickImage(
          source: ImageSource.gallery, imageQuality: 70, maxHeight: 800);
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
          .child("eventos")
          .child(eventGuid + '.jpg');

      await ref.putFile(image!);
      //var downloadURL = await ref.getDownloadURL();
    }
    // showSnackBar("Oferta salva! - " + widget.offerGuid, Duration(seconds: 3));
  }
}
