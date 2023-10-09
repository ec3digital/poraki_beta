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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, futuro) {
      return Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formSignupKey,
        child: Column(
          children: [
            TextFormField(
              validator: (valueNome) => valueNome.toString().length < 3
                  ? "Por favor informe um nome correto"
                  : null,
              controller: widget.controller.nameInputController,
              keyboardType: TextInputType.name,
              autofocus: false,
              // true,
              style: TextStyle(color: Colors.white),
              autofillHints: [AutofillHints.name],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Nome Completo",
                labelStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (valueNick) => valueNick.toString().length < 3
                  ? "Por favor informe um apelido correto"
                  : null,
              controller: widget.controller.nickInputController,
              autofocus: false,
              // true,
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.name,
              autofillHints: [AutofillHints.nickname],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Apelido",
                labelStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (valueCPF) {
                if (valueCPF.toString().length > 0) if (!UtilBrasilFields.isCPFValido(valueCPF))
                  return "Por favor informe um CPF válido";
                else
                  return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CpfInputFormatter(),
              ],
              controller: widget.controller.cpfInputController,
              keyboardType: TextInputType.number,
              autofocus: false,
              // true,
              // onChanged: (cpf) { if (!CNPJValidator.isValid(cpf)) { Get.defaultDialog(title: "CPF Inválido", middleText: "Por favor informe um CPF válido" ); }  {} } ,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "CPF",
                labelStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(
                  Icons.assignment_ind,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (valueZap) => valueZap.toString().length < 14
                  ? "Por favor informe um número de celular correto"
                  : null,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                TelefoneInputFormatter(),
              ],
              controller: widget.controller.phoneInputController,
              keyboardType: TextInputType.phone,
              autofillHints: [AutofillHints.telephoneNumber],
              autofocus: false,
              // true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Telefone Celular / Whatsapp",
                labelStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (valueEmail) {
                RegExp regex = new RegExp(
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                if (valueEmail!.isEmpty || !regex.hasMatch(valueEmail))
                  return 'Favor informar um endereço de e-mail correto';
                else
                  return null;
              },
              controller: widget.controller.mailInputController,
              autofocus: false,
              // true,
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.emailAddress,
              autofillHints: [AutofillHints.email],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "E-mail",
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                prefixIcon: Icon(
                  Icons.mail_outline,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                if (value!.length < 8) {
                  return "Digite um CEP válido";
                }
                return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CepInputFormatter(),
              ],
              controller: widget.controller.cepInputController,
              keyboardType: TextInputType.number,
              autofillHints: [AutofillHints.postalCode],
              autofocus: false,
              // true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(),
                labelText: "CEP",
                labelStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(
                  Icons.map,
                  color: Colors.white,
                ),
              ),
            ),

            // const SizedBox(
            //   height: 20,
            // ),
            // TextFormField(
            //   validator: (value) {
            //     if (value!.length != 10) {
            //       return "Digite uma data de nascimento válida";
            //     }
            //     return null;
            //   },
            //
            //   inputFormatters: [
            //     FilteringTextInputFormatter.digitsOnly,
            //     DataInputFormatter(),
            //   ],
            //   //onChanged: (data) { if (!Validat.isValid(cnpj)) { Get.defaultDialog(title: "CNPJ Inválido", middleText: "Por favor informe um CNPJ válido" ); }  {} } ,
            //   controller: controller.dtNascInputController,
            //   keyboardType: TextInputType.datetime,
            //   autofocus: true,
            //   autofillHints: [AutofillHints.birthday],
            //   style: TextStyle(color: Colors.white),
            //   decoration: InputDecoration(
            //     border: OutlineInputBorder(),
            //     labelText: "Data de Nascimento",
            //     labelStyle: TextStyle(color: Colors.white),
            //     prefixIcon: Icon(
            //       Icons.event,
            //       color: Colors.white,
            //     ),
            //   ),
            // ),

            Padding(
              padding: EdgeInsets.only(
                bottom: 15,
              ),
            ),
            GetBuilder<SignUpController>(builder: (_) {
              return Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value!.length < 6) {
                        return "A senha deve ter pelo menos 6 caracteres";
                      }
                      return null;
                    },
                    controller: widget.controller.passwordInputController,
                    obscureText: !widget.controller.showPassword,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Senha",
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      prefixIcon: Icon(
                        Icons.vpn_key_sharp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value !=
                          widget.controller.passwordInputController.text) {
                        return "As senhas devem ser iguais";
                      }
                      return null;
                    },
                    controller: widget.controller.confirmInputController,
                    obscureText: !widget.controller.showPassword,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Confirme a Senha",
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      prefixIcon: Icon(
                        Icons.vpn_key_sharp,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              );
            }),
            Row(
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
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
            MaterialButton(
              onPressed: () async {
                if (_formSignupKey.currentState!.validate()) {
                  setState(() {
                    isLoading = true;
                  });

                  var ret = await widget.controller
                      .signUp(
                          widget.controller.mailInputController.text.trim(),
                          widget.controller.passwordInputController.text.trim(),
                          widget.controller.nickInputController.text.trim(),
                          widget.controller.nameInputController.text.trim(),
                          widget.controller.cepInputController.text.trim(),
                          widget.controller.cpfInputController.text.trim(),
                          widget.controller.phoneInputController.text.trim())
                      .then((value) {
                    setState(() {
                      isLoading = false;
                    });
                  });

                  if (ret == 'OK') {
                    Get.toNamed(AppRoutes.login);
                    Alerta(context,
                        'Conta criada com sucesso! Por favor confirme seu acesso clicando no link do e-mail que acabamos de enviar pra você');
                  } else {
                    Alerta(context, ret.toString());
                  }
                }
              },
              child: Text("     Cadastrar     "),
              color: AppColors.secondaryColorButton,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      );
    });
  }
}
