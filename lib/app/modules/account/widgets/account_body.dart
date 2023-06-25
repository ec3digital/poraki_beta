import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/account/account_controller.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/home/widgets/gradient_header_home.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import '../../../routes/app_routes.dart';

class AccountBody extends StatefulWidget {
  AccountBody({
    Key? key,
    // required this.controller,
  }) : super(key: key);

  @override
  _AccountBodyState createState() => _AccountBodyState();
}

class _AccountBodyState extends State<AccountBody> {
  // final _form = GlobalKey<FormState>();
  bool _missingFields = false;
  final AccountController _accountController = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.find();
    Color textDark = _loginController.colorFromHex(_loginController.listCore
        .where((coreItem) => coreItem.coreChave == 'textDark')
        .first
        .coreValor
        .toString());

    return FutureBuilder(
        future: _accountController.carregaUsuario(),
        builder: (context, futuro) {
          if (futuro.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); //Text('carrinho vazio'));
            // } else if (futuro.hasError) {
            //   return Center(child: Text(futuro.error.toString()));
          } else {
            return Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size(double.maxFinite, 55),
                  child: AppBar(
                    // elevation: 0,
                    centerTitle: false,
                    backgroundColor: _loginController.colorFromHex(
                        _loginController
                            .listCore
                            .where(
                                (coreItem) => coreItem.coreChave == 'backLight')
                            .first
                            .coreValor
                            .toString()),
                    title: Text(
                      'Minha conta',
                      style: TextStyle(fontSize: 25, color: textDark),
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
                      // key: _form,
                      // key: controller.formKey,
                      child: ListView(children: [
                        Text(_missingFields ? "Ops, existem informações faltantes na sua conta": ""),

                        TextFormField(
                          validator: (value) {
                            if (value!.length < 3) {
                              return "Digite um nome correto";
                            }
                            return null;
                          },
                          controller: _accountController.txtNome,
                          keyboardType: TextInputType.name,
                          autofocus: true,
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
                          validator: (value) {
                            if (value!.length < 3) {
                              return "Digite um apelido maior";
                            }
                            return null;
                          },
                          controller: _accountController.txtApelido,
                          autofocus: true,
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
                          // validator: (value) {
                          //   if (value!.length != 11) {
                          //     return "CPF inválido";
                          //   }
                          //   return null;
                          // },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CpfInputFormatter(),
                          ],
                          readOnly: true,
                          controller: _accountController.txtCPF,
                          keyboardType: TextInputType.number,
                          autofocus: true,
                          // onChanged: (cpf) { if (!CNPJValidator.isValid(cpf)) { Get.defaultDialog(title: "CPF Inválido", middleText: "Por favor informe um CPF válido" ); }  {} } ,
                          style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "CPF",
                            labelStyle: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
                            prefixIcon: Icon(
                              Icons.assignment_ind,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          // validator: (value) {
                          //   if (value!.length != 11) {
                          //     return "Por favor digite um telefone válido";
                          //   }
                          //   return null;
                          // },

                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            TelefoneInputFormatter(),
                          ],
                          controller: _accountController.txtTelefone,
                          keyboardType: TextInputType.phone,
                          autofillHints: [AutofillHints.telephoneNumber],
                          autofocus: true,
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
                          validator: (value) {
                            RegExp regex = new RegExp(
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                            if (value!.isEmpty || !regex.hasMatch(value))
                              return 'Favor informar um endereço de e-mail correto';
                            else
                              return null;
                          },
                          readOnly: true,
                          controller: _accountController.txtEmail,
                          autofocus: true,
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
                          controller: _accountController.txtCEP,
                          keyboardType: TextInputType.number,
                          autofillHints: [AutofillHints.postalCode],
                          autofocus: true,
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
                        //   inputFormatters: [
                        //     FilteringTextInputFormatter.digitsOnly,
                        //     DataInputFormatter(),
                        //   ],
                        //   controller: widget._controller.txtDtNasc,
                        //   keyboardType: TextInputType.datetime,
                        //   autofocus: true,
                        //   style: TextStyle(color: textDark),
                        //   decoration: InputDecoration(
                        //     border: OutlineInputBorder(),
                        //     labelText: "Data de Nascimento",
                        //     labelStyle: TextStyle(color: textDark),
                        //     prefixIcon: Icon(
                        //       Icons.event,
                        //       color: textDark,
                        //     ),
                        //   ),
                        // ),

                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 15,
                          ),
                        ),

                        // TextFormField(
                        //   // validator: (value) {
                        //   //   if (value!.length < 6) {
                        //   //     return "A senha deve ter pelo menos 6 caracteres";
                        //   //   }
                        //   //   return null;
                        //   // },
                        //   // controller: controller.passwordInputController,
                        //   // obscureText: (controller.showPassword == true) ? false : true,
                        //   style: TextStyle(color: Colors.brown),
                        //   decoration: InputDecoration(
                        //     labelText: "Senha",
                        //     labelStyle: TextStyle(
                        //       color: Colors.brown,
                        //     ),
                        //     prefixIcon: Icon(
                        //       Icons.vpn_key_sharp,
                        //       color: Colors.brown,
                        //     ),
                        //     focusedBorder: UnderlineInputBorder(
                        //       borderSide: BorderSide(
                        //           color: Colors.brown),
                        //     ),
                        //     enabledBorder: UnderlineInputBorder(
                        //       borderSide: BorderSide(
                        //           color: Colors.brown),
                        //     ),
                        //   ),
                        // ),
                        // (controller.showPassword == false)
                        //     ? TextFormField(
                        //   validator: (value) {
                        //     if (value !=
                        //         controller.passwordInputController.text) {
                        //       return "As senhas devem ser iguais";
                        //     }
                        //     return null;
                        //   },
                        //   controller: controller.confirmInputController,
                        //   obscureText: true,
                        //   style: TextStyle(color: Colors.white),
                        //   decoration: InputDecoration(
                        //     labelText: "Confirme a Senha",
                        //     labelStyle: TextStyle(
                        //       color: Colors.white,
                        //     ),
                        //     prefixIcon: Icon(
                        //       Icons.vpn_key_sharp,
                        //       color: Colors.white,
                        //     ),
                        //     focusedBorder: UnderlineInputBorder(
                        //       borderSide: BorderSide(
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //     enabledBorder: UnderlineInputBorder(
                        //       borderSide: BorderSide(
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //   ),
                        // )
                        //     : Container(),
                        // ],
                        // );
                        // }

                        // Row(
                        //   children: [
                        //     GetBuilder<SignUpController>(
                        //       builder: (_) {
                        //         return Checkbox(
                        //           value: true, // controller.showPassword,
                        //           // onChanged: (newValue) {
                        //           //   controller.changeShowPassword(newValue!);
                        //           // },
                        //           activeColor: Colors.blue,
                        //           onChanged: (bool? value) {  },
                        //         );
                        //       },
                        //     ),
                        //     Text(
                        //       "Mostrar senha",
                        //       style: TextStyle(
                        //         color: Colors.brown,
                        //       ),
                        //     )
                        //   ],
                        // ),
                        // ],

                        ButtonOffer(
                          onPressed: () async {
                            await _accountController.atualizaUsuario();

                            // salva os dados do usuário
                            // widget._controller.atualizaUsuario(
                            //     new sqlUsuarios(
                            //     widget._controller.txtEmail.text
                            //         .removeAllWhitespace,
                            //     widget._controller.txtNome.text.trimRight(),
                            //     widget._controller.txtSobreNome.text
                            //         .trimRight(),
                            //     widget._controller.txtCPF.text
                            //         .removeAllWhitespace,
                            //     widget._controller.txtTelefone.text
                            //         .removeAllWhitespace,
                            //     widget._controller.txtCEP.text
                            //         .removeAllWhitespace,
                            //     widget._controller.txtEndereco.text
                            //         .trimRight()
                            //         .trimLeft(),
                            //     widget._controller.txtNumero.text
                            //       ..trimRight().trimLeft(),
                            //     widget._controller.txtCompl.text
                            //         .trimRight()
                            //         .trimLeft(),
                            //     null,
                            //     null,
                            //     null
                            //     ));

                            Get.defaultDialog(
                                title: "Aviso",
                                middleText:
                                    "Informações atualizadas com sucesso!");

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
                            //             child: const Text(
                            //                 'Informações salvas!'))));
                            // ScaffoldMessenger.of(context)
                            //     .showSnackBar(snackBar);
                          },
                          colorText: _loginController.colorFromHex(
                              _loginController.listCore
                                  .where((coreItem) =>
                                      coreItem.coreChave == 'textLight')
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
                        ButtonOffer(
                          onPressed: () {
                            Get.toNamed(AppRoutes.updatePw);
                          },
                          colorText: textDark,
                          text: 'Mudar senha',
                          colorButton: _loginController.colorFromHex(
                              _loginController.listCore
                                  .where((coreItem) =>
                                      coreItem.coreChave == 'backLight')
                                  .first
                                  .coreValor
                                  .toString()),
                        ),
                        ButtonOffer(
                            colorText: _loginController.colorFromHex(
                                _loginController.listCore
                                    .where((coreItem) =>
                                coreItem.coreChave == 'textLight')
                                    .first
                                    .coreValor
                                    .toString()),
                            text: 'Cancelar conta',
                            colorButton: _loginController.colorFromHex(
                                _loginController.listCore
                                    .where((coreItem) =>
                                coreItem.coreChave == 'iconColor')
                                    .first
                                    .coreValor
                                    .toString()),
                            onPressed: () =>
                                Get.toNamed(AppRoutes.accountValidation)),
                        // )
                      ])
                      // ],
                      ),
                )));
            // );
          }
        });
  }
}
