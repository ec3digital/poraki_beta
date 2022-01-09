import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../sign_up_controller.dart';

class FormSignup extends StatelessWidget {
  const FormSignup({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SignUpController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value!.length < 4) {
                return "Digite um nome maior";
              }
              return null;
            },
            controller: controller.nameInputController,
            keyboardType: TextInputType.name,
            autofocus: true,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: "Nome",
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          TextFormField(
            validator: (value) {
              if (value!.length < 10) {
                return "Digite um nome maior";
              }
              return null;
            },
            controller: controller.surnameInputController,
            autofocus: true,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: "Sobrenome",
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          TextFormField(
            validator: (value) {
              if (value!.length != 11) {
                return "CPF inválido";
              }
              return null;
            },
            controller: controller.cpfInputController,
            autofocus: true,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: "CPF",
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(
                Icons.assignment_ind,
                color: Colors.white,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          TextFormField(
            validator: (value) {
              if (value!.length != 11) {
                return "Por favor digite um telefone válido";
              }
              return null;
            },
            controller: controller.phoneInputController,
            keyboardType: TextInputType.phone,
            autofocus: true,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: "Telefone Celular",
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.white,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          TextFormField(
            validator: (value) {
              if (value!.length < 5) {
                return "Esse e-mail parece curto demais";
              } else if (!value.contains("@")) {
                return "Esse e-mail está meio estranho, não?";
              }
              return null;
            },
            controller: controller.mailInputController,
            autofocus: true,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: "E-mail",
              labelStyle: TextStyle(
                color: Colors.white,
              ),
              prefixIcon: Icon(
                Icons.mail_outline,
                color: Colors.white,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          TextFormField(
            validator: (value) {
              if (value!.length != 8) {
                return "Digite um CEP válido";
              }
              return null;
            },
            controller: controller.cepInputController,
            autofocus: true,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: "CEP",
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(
                Icons.map,
                color: Colors.white,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          TextFormField(
            validator: (value) {
              if (value!.length != 10) {
                return "Digite uma data de nascimento válida";
              }
              return null;
            },
            controller: controller.dtNascInputController,
            autofocus: true,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: "Data de Nascimento",
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(
                Icons.event,
                color: Colors.white,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
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
                  controller: controller.passwordInputController,
                  obscureText: (controller.showPassword == true) ? false : true,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Senha",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    prefixIcon: Icon(
                      Icons.vpn_key_sharp,
                      color: Colors.white,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                (controller.showPassword == false)
                    ? TextFormField(
                        validator: (value) {
                          if (value !=
                              controller.passwordInputController.text) {
                            return "As senhas devem ser iguais";
                          }
                          return null;
                        },
                        controller: controller.confirmInputController,
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: "Confirme a Senha",
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          prefixIcon: Icon(
                            Icons.vpn_key_sharp,
                            color: Colors.white,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            );
          }),
          Row(
            children: [
              GetBuilder<SignUpController>(
                builder: (_) {
                  return Checkbox(
                    value: controller.showPassword,
                    onChanged: (newValue) {
                      controller.changeShowPassword(newValue!);
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
        ],
      ),
    );
  }
}
