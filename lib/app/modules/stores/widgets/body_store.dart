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
  final FocusNode txtLojaNroFocus = FocusNode();
  final StoreController storeController = Get.find();
  final LoginController _loginController = Get.find();
  bool valAceitaPoraki10 = false;
  DateTime valDataCupomDe = DateTime.now();
  DateTime valDataCupomAte = DateTime.now();
  bool isSalvarLoading = false;
  bool isApagarLoading = false;
  bool isCepLoading = false;
  final _formStoreKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext buildContext) {
    Color textColor = _loginController.colorFromHex(_loginController.textDark);

    return FutureBuilder<void>(
      future: _loadStoreData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro ao carregar dados: ${snapshot.error}'));
        } else {
          return _buildStoreScaffold(textColor);
        }
      },
    );
  }

  Future<void> _loadStoreData() async {
    if (storeController.loja != null) {
      storeController.bindLoja();
      imgcloud = _loginController.imgPathStores + storeController.loja!.LojaGUID.toString() + _loginController.imgPathSuffix;
    }
  }

  Scaffold _buildStoreScaffold(Color textColor) {
    return Scaffold(
      appBar: _buildAppBar(textColor),
      body: GradientHeaderHome(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formStoreKey,
            autovalidateMode: AutovalidateMode.always,
            child: ListView(
              children: [
                _buildTextFormField(
                  labelText: "Nome da Loja",
                  controller: storeController.txtLojaNome,
                  validator: (value) => value != null && value.length < 3 ? "Por favor informe um nome maior" : null,
                  prefixIcon: Icons.storefront_rounded,
                  textColor: textColor,
                ),
                _buildTextFormField(
                  labelText: "Slogan (opcional)",
                  controller: storeController.txtLojaSlogan,
                  prefixIcon: Icons.local_offer_outlined,
                  textColor: textColor,
                ),
                _buildCnpjFormField(textColor),
                _buildPhoneFormField(textColor),
                _buildCepFormField(textColor),
                _buildAddLogoButton(),
                if (imgcloud.isNotEmpty) _buildCachedNetworkImage(),
                if (image != null) _buildSelectedImage(),
                _buildSalvarButton(),
                _buildApagarButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(Color textColor) {
    return AppBar(
      backgroundColor: _loginController.colorFromHex(_loginController.backLight),
      title: Text(
        'Loja',
        style: TextStyle(fontSize: 25, color: textColor),
      ),
    );
  }

  Widget _buildTextFormField({
    required String labelText,
    required TextEditingController controller,
    String? Function(String?)? validator,
    required IconData prefixIcon,
    required Color textColor,
  }) {
    return Column(
      children: [
        const SizedBox(height: 20),
        TextFormField(
          controller: controller,
          validator: validator,
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: labelText,
            labelStyle: TextStyle(color: textColor),
            prefixIcon: Icon(prefixIcon, color: textColor),
          ),
        ),
      ],
    );
  }

  Widget _buildCnpjFormField(Color textColor) {
    return _buildTextFormField(
      labelText: "CNPJ",
      controller: storeController.txtLojaCNPJ,
      validator: (valueCNPJ) {
        if (valueCNPJ != null && valueCNPJ.isNotEmpty && !UtilBrasilFields.isCNPJValido(valueCNPJ)) {
          return "Por favor informe um CNPJ válido";
        }
        return null;
      },
      prefixIcon: Icons.work_outline,
      textColor: textColor,
    );
  }

  Widget _buildPhoneFormField(Color textColor) {
    return _buildTextFormField(
      labelText: "Whatsapp da Loja (obrigatório)",
      controller: storeController.txtLojaWhatsapp,
      validator: (value) => value != null && value.length < 14 ? "Por favor informe um número de celular correto" : null,
      prefixIcon: Icons.phone_enabled_outlined,
      textColor: textColor,
    );
  }

  Widget _buildCepFormField(Color textColor) {
    return _buildTextFormField(
      labelText: "CEP",
      controller: storeController.txtLojaCEP,
      validator: (value) => value != null && value.length < 9 ? "Por favor informe um CEP correto" : null,
      prefixIcon: Icons.location_on_outlined,
      textColor: textColor,
    );
  }

  Widget _buildAddLogoButton() {
    return ElevatedButton(
      onPressed: pegarImagemGaleria,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          _loginController.colorFromHex(_loginController.backDark),
        ),
      ),
      child: Row(
        children: const [
          Icon(Icons.photo_album),
          SizedBox(width: 16),
          Text('Adicionar Logotipo'),
        ],
      ),
    );
  }

  Widget _buildCachedNetworkImage() {
    return CachedNetworkImage(
      imageUrl: imgcloud,
      height: 250,
      progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(
        value: downloadProgress.progress,
      ),
      errorWidget: (context, url, error) => Icon(Icons.local_offer_outlined),
    );
  }

  Widget _buildSelectedImage() {
    return Image.file(
      image!,
      fit: BoxFit.contain,
    );
  }

  Widget _buildSalvarButton() {
    return ElevatedButton(
      onPressed: _saveStore,
      child: isSalvarLoading
          ? const SizedBox(
              height: 50,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 1.5),
            )
          : Text(
              "Salvar",
              style: TextStyle(
                color: _loginController.colorFromHex(_loginController.textLight),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(_loginController.colorFromHex(_loginController.iconColor)),
      ),
    );
  }

  Widget _buildApagarButton() {
    return ElevatedButton(
      onPressed: _deleteStore,
      child: isApagarLoading
          ? const SizedBox(
              height: 50,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 1.5),
            )
          : Text(
              "Apagar Loja",
              style: TextStyle(
                color: _loginController.colorFromHex(_loginController.textLight),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(_loginController.colorFromHex(_loginController.textDark)),
      ),
    );
  }

  Future<void> _saveStore() async {
    if (_formStoreKey.currentState!.validate()) {
      setState(() {
        isSalvarLoading = true;
      });

      storeGuid = (await storeController.saveLoja()).toString();
      await uploadFoto(image == null ? null : image);
      await _loginController.loadStoresData();

      setState(() {
        isSalvarLoading = false;
      });

      Get.defaultDialog(title: "Aviso", middleText: "Informações atualizadas com sucesso!");
      Get.offAndToNamed(AppRoutes.stores);
    }
  }

  Future<void> _deleteStore() async {
    setState(() {
      isApagarLoading = true;
    });

    await storeController.apagaLoja(storeController.loja);

    setState(() {
      isApagarLoading = false;
    });

    Get.defaultDialog(title: "Aviso", middleText: "Loja removida do Poraki !");
    Get.offAndToNamed(AppRoutes.stores);
  }

  Future<void> pegarImagemGaleria() async {
    try {
      final foto = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70, maxHeight: 300);
      if (foto == null) return;

      setState(() {
        image = File(foto.path);
        imgEdited = true;
      });
    } on PlatformException catch (e) {
      print('Erro ao tentar abrir o álbum de fotos: $e');
    }
  }

  Future<void> uploadFoto(File? foto) async {
    if (imgEdited && foto != null) {
      await Firebase.initializeApp();
      Reference ref = FirebaseStorage.instance.ref().child("lojas").child(storeGuid + '.jpg');
      await ref.putFile(foto);
    }
  }
}
