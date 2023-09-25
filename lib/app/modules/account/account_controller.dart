import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/sql/sqlUsuario.dart';
import 'package:poraki/app/data/models/usuario.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/services/sqlite/sqlporaki_login_service.dart';

class AccountController extends GetxController {
  late sqlUsuarios usuario;
  final TextEditingController txtNome = TextEditingController();
  // final TextEditingController txtSobreNome = TextEditingController();
  final TextEditingController txtApelido = TextEditingController();
  final TextEditingController txtEndereco = TextEditingController();
  final TextEditingController txtNumero = TextEditingController();
  final TextEditingController txtCompl = TextEditingController();
  final TextEditingController txtEmail = TextEditingController();
  // final TextEditingController txtSenha = TextEditingController();
  // final TextEditingController txtConfSenha = TextEditingController();

  // final MaskedTextController txtCPF = MaskedTextController(mask: '000.000.000-00');
  // final MaskedTextController txtDtNasc = MaskedTextController(mask: '00/00/0000');
  // final MaskedTextController txtCEP = MaskedTextController(mask: '00000-000');
  // final MaskedTextController txtTelefone = MaskedTextController(mask: '(00)00000-0000)');

  TextEditingController txtCPF = TextEditingController();
  TextEditingController txtDtNasc = TextEditingController();
  TextEditingController txtCEP = TextEditingController();
  TextEditingController txtTelefone = TextEditingController();

  late FirebaseFirestore? fbInstance;
  final FirebaseAuth? auth = FirebaseAuth.instance;
  final LoginController _loginController = Get.find();

  // final LoginRepository loginRepository = LoginRepository();
  bool showPassword = false;
  // final formKey = GlobalKey<FormState>();

  @override
  void onInit() async {
    super.onInit();

    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }

    fbInstance = FirebaseFirestore.instance;

  }

  Future<void> carregaUsuario() async {
    print('carregaUsuario');
    // txtEmail.text = _loginController.usuEmail.toString(); //  usuario.usuEmail;
    txtEmail.text = auth!.currentUser!.email.toString(); //  usuario.usuEmail;
    // txtNome.text = _loginController.usuNome.toString(); // usuario.usuNome;

    await fbInstance!
        .collection("akiusuarios")
        .doc(auth!.currentUser!.uid)
        .get()
        .then((value) {
      txtNome.text = value['Nome'].toString();
      txtCEP.text = value['CEP'].toString();
      txtCPF.text = value['CPF'].toString();
      txtTelefone.text = value['Whatsapp'].toString();
      txtApelido.text = auth!.currentUser!.displayName.toString();
      _loginController.cloudId = value['CEP'].toString().substring(0,3);
    });
  }

  Future<void> atualizaUsuario() async {
    print('atualizaUsuario');
    // await sqlPorakiLoginService().updateUsuarioCEP(
    //     txtCEP.text.trim(), auth!.currentUser!.email.toString());
    // _loginController.usuNome = txtApelido.text.trim();
    // _loginController.usuCep = txtCEP.text.trim();

    await auth!.currentUser!.updateDisplayName(txtApelido.text.trim());

    var user = new Usuario(
        nome: txtNome.text.trim(),
        apelido: txtApelido.text.trim(),
        cep: txtCEP.text.trim(),
        cpf: txtCPF.text.trim(),
        email: auth!.currentUser!.email.toString(),
        whatsapp: txtTelefone.text.trim(),
        cpfValidado: false,
        regiao: _loginController.cloudId,
        dataNascimento: DateTime.now());

    await _loginController.fbInstance!
        .collection("akiusuarios")
        .doc(auth!.currentUser!.uid.toString())
        .update(user.toJsonAdd());

    // await carregaUsuario();
  }
}
