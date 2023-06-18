import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/account/account_controller.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/home/widgets/gradient_header_home.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poraki/app/routes/app_routes.dart';

class AccountValidation extends StatefulWidget {
  AccountValidation({
    Key? key,
    // required this.controller,
  }) : super(key: key);

  final AccountController _controller = Get.put(AccountController());
  var _imageURLFocusNode = FocusNode();
  var _imageURLController = TextEditingController();
  final LoginController _loginController = Get.find();

  @override
  _AccountValidationState createState() => _AccountValidationState();
}

class _AccountValidationState extends State<AccountValidation> {
  // final _form = GlobalKey<FormState>();
  File? image;

  @override
  void initState() {
    widget._imageURLFocusNode.addListener(_updateImageUrl);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    widget._imageURLFocusNode.removeListener(_updateImageUrl);
    widget._imageURLFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.find();
    Color textDark = _loginController.colorFromHex(_loginController.listCore
        .where((coreItem) => coreItem.coreChave == 'textDark')
        .first
        .coreValor
        .toString());

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.maxFinite, 55),
          child: AppBar(
            elevation: 0,
            centerTitle: false,
            backgroundColor: widget._loginController.colorFromHex(widget
                ._loginController.listCore
                .where((coreItem) => coreItem.coreChave == 'backLight')
                .first
                .coreValor
                .toString()),
            title: Text(
              'Validação de conta',
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
              Text("Para realizar compras no Poraki, é preciso validar um documento de identificação, assim podemos manter a nossa comunidade segura ;-)"),
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

                      setState(() => this.image = imageTemp);
                    } on PlatformException catch (e) {
                      print('erro tentando abrir album de fotos: $e');
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                    widget._loginController.colorFromHex(widget
                        ._loginController.listCore
                        .where((coreItem) => coreItem.coreChave == 'backDark')
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
                      Text('Escolher/Tirar Foto')
                    ],
                  )),
              const SizedBox(height: 20),
              if (image != null)
                Image.file(
                  image!,
                  fit: BoxFit.contain,
                ),
              const SizedBox(height: 20),
              ButtonOffer(
                  text: 'Enviar',
                  colorText: widget._loginController.colorFromHex(widget
                      ._loginController.listCore
                      .where((coreItem) => coreItem.coreChave == 'textLight')
                      .first
                      .coreValor
                      .toString()),
                  colorButton: widget._loginController.colorFromHex(widget
                      ._loginController.listCore
                      .where((coreItem) => coreItem.coreChave == 'iconColor')
                      .first
                      .coreValor
                      .toString()),
                  onPressed: () {
                    uploadFoto(image == null ? null : image,
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

      await ref.putFile(image!);
      //var downloadURL = await ref.getDownloadURL();
    }
    //showSnackBar("Oferta salva! - " + widget.offerGuid, Duration(seconds: 3));

    Get.defaultDialog(
        title: "Aviso", middleText: "Informações atualizadas com sucesso!");
  }

  void _updateImageUrl() {
    if (isValidImageUrl(widget._imageURLController.text)) {
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
