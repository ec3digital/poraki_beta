import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/home/widgets/gradient_header_home.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poraki/app/modules/stores/store_controller.dart';
import 'package:poraki/app/routes/app_routes.dart';

class StoreValidation extends StatefulWidget {
  StoreValidation({
    Key? key,
    // required this.controller,
  }) : super(key: key);

  final StoreController _controller = Get.put(StoreController());
  var _imageURLCNPJFocusNode = FocusNode();
  var _imageURLAddressFocusNode = FocusNode();
  var _imageURLControllerCNPJ = TextEditingController();
  var _imageURLControllerAddress = TextEditingController();
  final LoginController _loginController = Get.find();

  @override
  _StoreValidationState createState() => _StoreValidationState();
}

class _StoreValidationState extends State<StoreValidation> {
  // final _form = GlobalKey<FormState>();
  File? imageCNPJ;
  File? imageAddress;

  @override
  void initState() {
    widget._imageURLCNPJFocusNode.addListener(_updateImageUrl);
    widget._imageURLAddressFocusNode.addListener(_updateImageUrl);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    widget._imageURLCNPJFocusNode.removeListener(_updateImageUrl);
    widget._imageURLCNPJFocusNode.dispose();
    widget._imageURLAddressFocusNode.removeListener(_updateImageUrl);
    widget._imageURLAddressFocusNode.dispose();

  }

  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.find();
    Color textDark = _loginController.colorFromHex(_loginController.textDark);

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.maxFinite, 55),
          child: AppBar(
            elevation: 0,
            centerTitle: false,
            backgroundColor: widget._loginController.colorFromHex(widget._loginController.backLight),
            title: Text(
              'Validação de Loja',
              style: TextStyle(fontSize: 25, color: textDark),
            ),
          ),
        ),
        //drawer: DrawerHome(0),
        body: GradientHeaderHome(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text("Para realizar vendas no Poraki, é preciso validar um documento de identificação da empresa, assim podemos manter a nossa comunidade segura ;-)"),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          final foto = await ImagePicker().pickImage(
                              source: ImageSource.gallery,
                              imageQuality: 70,
                              maxHeight: 300);
                          if (foto == null) return;

                          final imageTemp = File(foto.path);

                          setState(() => this.imageCNPJ = imageTemp);
                        } on PlatformException catch (e) {
                          print('erro tentando abrir album de fotos: $e');
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            widget._loginController.colorFromHex(widget._loginController.backDark),
                          )),
                      child: Row(
                        children: [
                          Icon(Icons.photo_album),
                          const SizedBox(
                            width: 16,
                          ),
                          Text('Escolher/Tirar Foto do CNPJ')
                        ],
                      )),
                  const SizedBox(height: 20),
                  if (imageCNPJ != null)
                    Image.file(
                      imageCNPJ!,
                      fit: BoxFit.contain,
                    ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          final fotoAddress = await ImagePicker().pickImage(
                              source: ImageSource.gallery,
                              imageQuality: 70,
                              maxHeight: 300);
                          if (fotoAddress == null) return;

                          final imageTempAddress = File(fotoAddress.path);

                          setState(() => this.imageAddress = imageTempAddress);
                        } on PlatformException catch (e) {
                          print('erro tentando abrir album de fotos: $e');
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            widget._loginController.colorFromHex(widget._loginController.backDark),
                          )),
                      child: Row(
                        children: [
                          Icon(Icons.photo_album),
                          const SizedBox(
                            width: 16,
                          ),
                          Text('Escolher comprovante de endereço')
                        ],
                      )),
                  const SizedBox(height: 20),
                  if (imageAddress != null)
                    Image.file(
                      imageAddress!,
                      fit: BoxFit.contain,
                    ),
                  const SizedBox(height: 20),
                  ButtonOffer(
                      text: 'Enviar',
                      colorText: widget._loginController.colorFromHex(widget._loginController.textLight),
                      colorButton: widget._loginController.colorFromHex(widget._loginController.iconColor),
                      onPressed: () {
                        uploadFoto(imageCNPJ == null ? null : imageCNPJ,
                            widget._loginController.usuGuid.toString(), 1)
                            .then((value) => Get.offAndToNamed(AppRoutes.mOffers));
                      }),
                ],
              ),
            )));
  }

  Future<void> uploadFoto(File? foto, String usuGuid, int seq) async {
    // await _saveForm(usuGuid);

    if (foto != null) {
      await Firebase.initializeApp();

      print('passou no upload');
      Reference ref = FirebaseStorage.instance
          .ref()
          .child("ids")
          .child(usuGuid + '-' + seq.toString() + '.jpg');

      await ref.putFile(imageCNPJ!);
      //var downloadURL = await ref.getDownloadURL();
    }
    //showSnackBar("Oferta salva! - " + widget.offerGuid, Duration(seconds: 3));

    Get.defaultDialog(
        title: "Aviso", middleText: "Informações atualizadas com sucesso!");
  }

  void _updateImageUrl() {
    if (isValidImageUrl(widget._imageURLControllerCNPJ.text)) {
      setState(() {});
    }
  }

  bool isValidImageUrl(String url) {
    bool startWithHttp = url.toLowerCase().startsWith('http://');
    bool startWithHttps = url.toLowerCase().startsWith('https://');
    bool endWithJpg = url.toLowerCase().endsWith('.jpg');
    bool endWithJpeg = url.toLowerCase().endsWith('.jpeg');

    return (startWithHttp || startWithHttps) && (endWithJpg || endWithJpeg);
  }
}
