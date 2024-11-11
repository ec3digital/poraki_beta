import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:poraki/app/routes/app_routes.dart';
import 'package:poraki/app/theme/app_theme.dart';
import 'package:poraki/app/util/alerta.dart';
import '../sign_up_controller.dart';

class FormSignup extends StatefulWidget {
  const FormSignup({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SignUpController controller;

  @override
  State<FormSignup> createState() => _FormSignupState();
}

class _FormSignupState extends State<FormSignup> {
  bool isLoading = false;
  final _formSignupKey = GlobalKey<FormState>();

  Future<void> _signUp() async {
    if (_formSignupKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      var ret = await widget.controller.signUp(
        widget.controller.mailInputController.text.trim(),
        widget.controller.passwordInputController.text.trim(),
        widget.controller.nickInputController.text.trim(),
        widget.controller.nameInputController.text.trim(),
        widget.controller.cepInputController.text.trim(),
        widget.controller.cpfInputController.text.trim(),
        widget.controller.phoneInputController.text.trim(),
      );

      setState(() {
        isLoading = false;
      });

      if (ret == 'OK') {
        Get.toNamed(AppRoutes.termos);
        Alerta(context,
            'Conta criada com sucesso! Por favor confirme seu acesso clicando no link do e-mail que acabamos de enviar pra você');
      } else {
        Alerta(context, ret.toString());
      }
    }
  }

  String? _validateFieldLength(String? value, int minLength, String errorMessage) {
    if (value != null && value.length < minLength) {
      return errorMessage;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      key: _formSignupKey,
      child: Column(
        children: [
          _buildTextFormField(
            controller: widget.controller.nameInputController,
            labelText: "Nome Completo",
            validator: (value) => _validateFieldLength(value, 3, "Por favor informe um nome correto"),
            prefixIcon: Icons.person,
          ),
          const SizedBox(height: 20),
          _buildTextFormField(
            controller: widget.controller.nickInputController,
            labelText: "Apelido",
            validator: (value) => _validateFieldLength(value, 3, "Por favor informe um apelido correto"),
            prefixIcon: Icons.person,
          ),
          const SizedBox(height: 20),
          _buildCpfFormField(),
          const SizedBox(height: 20),
          _buildPhoneFormField(),
          const SizedBox(height: 20),
          _buildEmailFormField(),
          const SizedBox(height: 20),
          _buildCepFormField(),
          const SizedBox(height: 20),
          _buildPasswordFields(),
          _buildShowPasswordCheckbox(),
          _buildSignUpButton(),
        ],
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required String? Function(String?) validator,
    required IconData prefixIcon,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(prefixIcon, color: Colors.white),
      ),
    );
  }

  Widget _buildCpfFormField() {
    return _buildTextFormField(
      controller: widget.controller.cpfInputController,
      labelText: "CPF",
      validator: (value) {
        if (value != null && value.isNotEmpty && !UtilBrasilFields.isCPFValido(value)) {
          return "Por favor informe um CPF válido";
        }
        return null;
      },
      prefixIcon: Icons.assignment_ind,
    );
  }

  Widget _buildPhoneFormField() {
    return _buildTextFormField(
      controller: widget.controller.phoneInputController,
      labelText: "Telefone Celular / Whatsapp",
      validator: (value) => _validateFieldLength(value, 14, "Por favor informe um número de celular correto"),
      prefixIcon: Icons.phone,
    );
  }

  Widget _buildEmailFormField() {
    return _buildTextFormField(
      controller: widget.controller.mailInputController,
      labelText: "E-mail",
      validator: (value) {
        RegExp regex = RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
        );
        if (value == null || !regex.hasMatch(value)) {
          return 'Favor informar um endereço de e-mail correto';
        }
        return null;
      },
      prefixIcon: Icons.mail_outline,
    );
  }

  Widget _buildCepFormField() {
    return _buildTextFormField(
      controller: widget.controller.cepInputController,
      labelText: "CEP",
      validator: (value) => _validateFieldLength(value, 8, "Digite um CEP válido"),
      prefixIcon: Icons.map,
    );
  }

  Widget _buildPasswordFields() {
    return GetBuilder<SignUpController>(
      builder: (_) {
        return Column(
          children: [
            _buildTextFormField(
              controller: widget.controller.passwordInputController,
              labelText: "Senha",
              validator: (value) => _validateFieldLength(value, 6, "A senha deve ter pelo menos 6 caracteres"),
              prefixIcon: Icons.vpn_key_sharp,
              obscureText: !widget.controller.showPassword, 
            ),
            const SizedBox(height: 20),
            _buildTextFormField(
              controller: widget.controller.confirmInputController,
              labelText: "Confirme a Senha",
              validator: (value) {
                if (value != widget.controller.passwordInputController.text) {
                  return "As senhas devem ser iguais";
                }
                return null;
              },
              prefixIcon: Icons.vpn_key_sharp,
              obscureText: !widget.controller.showPassword,
            ),
          ],
        );
      },
    );
  }

  Widget _buildShowPasswordCheckbox() {
    return Row(
      children: [
        GetBuilder<SignUpController>(
          builder: (_) {
            return Checkbox(
              value: widget.controller.showPassword,
              onChanged: (newValue) {
                widget.controller.changeShowPassword(newValue!);
              },
              activeColor: Colors.blue,
            );
          },
        ),
        Text(
          "Mostrar senha",
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildSignUpButton() {
    return MaterialButton(
      onPressed: _signUp,
      child: Text("     Cadastrar     "),
      color: AppColors.secondaryColorButton,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
