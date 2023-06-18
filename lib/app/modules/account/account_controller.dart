import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/sql/sqlUsuario.dart';
import 'package:poraki/app/services/sqlite/sqlporaki_login_service.dart';

class AccountController extends GetxController {
  late sqlUsuarios usuario;
  final TextEditingController txtNome = TextEditingController();
  final TextEditingController txtSobreNome = TextEditingController();
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

  // final LoginRepository loginRepository = LoginRepository();
  bool showPassword = false;
  // final formKey = GlobalKey<FormState>();

  @override
  void onInit() async {
    await carregaUsuario();
    super.onInit();
  }

  Future<void> carregaUsuario() async {
    print('carregaUsuario');

    var buscaUsuario = await sqlPorakiLoginService().buscaUsuDados();
    buscaUsuario.forEach((usu) {
      usuario = new sqlUsuarios(usu['usuEmail'].toString(),
          usu['usuNome'].toString(),
          usu['usuSobreNome'].toString(),
          usu['usuCPF'].toString(),
          usu['usuTelefone'].toString(),
          usu['usuCEP'].toString(),
          usu['usuEndereco'].toString(),
          usu['usuNumero'].toString(),
          usu['usuCompl'].toString(),
          usu['usuLastLogin'].toString(),
          usu['usuTermosEm'].toString(),
          usu['usuVersao'].toString(),
      );
    });

    txtEmail.text = usuario.usuEmail;
    txtNome.text = usuario.usuNome;
    txtSobreNome.text = usuario.usuSobreNome!;
    txtCPF.text = usuario.usuCPF!;
    txtTelefone.text = usuario.usuTelefone!;
    txtCEP.text = usuario.usuCEP!;
    txtEndereco.text = usuario.usuEndereco!;
    txtNumero.text = usuario.usuNumero!;
    txtCompl.text = usuario.usuCompl!;
  }

  Future<void> atualizaUsuario(sqlUsuarios usuario) async {
    await sqlPorakiLoginService().updateUsuario(usuario);
    await carregaUsuario();
  }

}
