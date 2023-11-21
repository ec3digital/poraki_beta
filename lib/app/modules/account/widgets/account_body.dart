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
  final _formAccountKey = GlobalKey<FormState>();
  final AccountController _accountController = Get.put(AccountController());
  bool _missingFields = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.find();
    Color textDark = _loginController.colorFromHex(_loginController.textDark);

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
                    backgroundColor: _loginController.colorFromHex(_loginController.backLight),
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
                      autovalidateMode: AutovalidateMode.always,
                      key: _formAccountKey,
                      child: ListView(children: [
                        Text(_missingFields
                            ? "Ops, existem informações faltantes na sua conta"
                            : ""),

                        TextFormField(
                          validator: (value) {
                            if (value!.length < 3) {
                              return "Digite um nome correto";
                            }
                            return null;
                          },
                          controller: _accountController.txtNome,
                          keyboardType: TextInputType.name,
                          autofocus: false,
                          style: TextStyle(color: Colors.white),
                          autofillHints: [AutofillHints.name],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Nome Completo (obrigatório)",
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
                          autofocus: false, // true,
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.name,
                          autofillHints: [AutofillHints.nickname],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Apelido (obrigatório)",
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
                          readOnly: true,
                          controller: _accountController.txtCPF,
                          keyboardType: TextInputType.number,
                          autofocus: false, // true,
                          onChanged: (cpf) => !UtilBrasilFields.isCPFValido(cpf)
                              ? Get.defaultDialog(
                                  title: "CPF Inválido",
                                  middleText: "Por favor informe um CPF válido")
                              : null,
                          style: TextStyle(
                              color: Colors.black, fontStyle: FontStyle.italic),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "CPF (obrigatório)",
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontStyle: FontStyle.italic),
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
                          validator: (valueZap) => valueZap.toString().length < 14
                              ? "Por favor informe um número de celular correto"
                              : null,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            TelefoneInputFormatter(),
                          ],
                          controller: _accountController.txtTelefone,
                          keyboardType: TextInputType.phone,
                          autofillHints: [AutofillHints.telephoneNumber],
                          autofocus: false, // true,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Telefone Celular / Whatsapp (obrigatório)",
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
                          autofocus: false, // true,
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: [AutofillHints.email],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "E-mail (obrigatório)",
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
                          validator: (valueCEP) => valueCEP.toString().length < 9
                              ? "Por favor informe um CEP correto"
                              : null,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CepInputFormatter(),
                          ],
                          controller: _accountController.txtCEP,
                          keyboardType: TextInputType.number,
                          autofillHints: [AutofillHints.postalCode],
                          autofocus: false, // true,
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
                            if (_formAccountKey.currentState!.validate()) {
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
                            }
                          },
                          colorText: _loginController.colorFromHex(_loginController.textLight),
                          text: 'Salvar',
                          colorButton: _loginController.colorFromHex(_loginController.iconColor),
                        ),
                        ButtonOffer(
                          onPressed: () {
                            Get.toNamed(AppRoutes.updatePw);
                          },
                          colorText: textDark,
                          text: 'Mudar senha',
                          colorButton: _loginController.colorFromHex(_loginController.backLight),
                        ),
                        ButtonOffer(
                            colorText: _loginController.colorFromHex(_loginController.textLight),
                            text: 'Cancelar conta',
                            colorButton: _loginController.colorFromHex(_loginController.iconColor),
                            onPressed: () =>
                                Get.toNamed(AppRoutes.accountCancel)),
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
