import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/sql/sqlUsuario.dart';
import 'package:poraki/app/modules/account/account_controller.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/home/widgets/gradient_header_home.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';

class AccountBody extends StatefulWidget {
  AccountBody({
    Key? key,
    // required this.controller,
  }) : super(key: key);

  final AccountController _controller = Get.put(AccountController());

  @override
  _AccountBodyState createState() => _AccountBodyState();
}

class _AccountBodyState extends State<AccountBody> {
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.find();
    Color textDark = _loginController.colorFromHex(_loginController.listCore
        .where((coreItem) => coreItem.coreChave == 'textDark')
        .first
        .coreValor
        .toString());

    return FutureBuilder(
        future: widget._controller.carregaUsuario(),
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
                      key: _form,
                      // key: controller.formKey,
                      child: ListView(children: [
                        TextFormField(
                          // validator: (value) {
                          //   if (value!.length < 4) {
                          //     return "Digite um nome maior";
                          //   }
                          //   return null;
                          // },
                          controller: widget._controller.txtNome,
                          autofocus: true,
                          style: TextStyle(color: textDark),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Nome",
                            labelStyle: TextStyle(color: textDark),
                            prefixIcon: Icon(
                              Icons.person,
                              color: textDark,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        TextFormField(
                          // validator: (value) {
                          //   if (value!.length < 10) {
                          //     return "Digite um nome maior";
                          //   }
                          //   return null;
                          // },
                          controller: widget._controller.txtSobreNome,
                          autofocus: true,
                          style: TextStyle(color: textDark),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Sobrenome",
                            labelStyle: TextStyle(color: textDark),
                            prefixIcon: Icon(
                              Icons.person,
                              color: textDark,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        TextFormField(
                          // validator: (value) {
                          //   if (value!.length != 11) {
                          //     return "CPF inválido";
                          //   }
                          //   return null;
                          // },

                          inputFormatters: [FilteringTextInputFormatter.digitsOnly,CpfInputFormatter(), ],
                          controller: widget._controller.txtCPF,
                          keyboardType: TextInputType.number,
                          autofocus: true,
                          onChanged: (cpf) { if (!CNPJValidator.isValid(cpf)) { Get.defaultDialog(title: "CPF Inválido", middleText: "Por favor informe um CPF válido" ); }  {} } ,
                          style: TextStyle(color: textDark),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "CPF",
                            labelStyle: TextStyle(color: textDark),
                            prefixIcon: Icon(
                              Icons.assignment_ind,
                              color: textDark,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        TextFormField(
                          // validator: (value) {
                          //   if (value!.length != 11) {
                          //     return "Por favor digite um telefone válido";
                          //   }
                          //   return null;
                          // },

                          inputFormatters: [FilteringTextInputFormatter.digitsOnly,TelefoneInputFormatter(), ],
                          controller: widget._controller.txtTelefone,
                          keyboardType: TextInputType.phone,
                          autofocus: true,
                          style: TextStyle(color: textDark),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Telefone Celular",
                            labelStyle: TextStyle(color: textDark),
                            prefixIcon: Icon(
                              Icons.phone,
                              color: textDark,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        TextFormField(
                          // validator: (value) {
                          //   if (value!.length < 5) {
                          //     return "Esse e-mail parece curto demais";
                          //   } else if (!value.contains("@")) {
                          //     return "Esse e-mail está meio estranho, não?";
                          //   }
                          //   return null;
                          // },
                          controller: widget._controller.txtEmail,
                          keyboardType: TextInputType.emailAddress,
                          autofocus: true,
                          style: TextStyle(color: textDark),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "E-mail",
                            labelStyle: TextStyle(
                              color: textDark,
                            ),
                            prefixIcon: Icon(
                              Icons.mail_outline,
                              color: textDark,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        TextFormField(
                          validator: (value) {
                            if (value!.length != 8) {
                              return "Digite um CEP válido";
                            }
                            return null;
                          },
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly,CepInputFormatter(), ],
                          controller: widget._controller.txtCEP,
                          keyboardType: TextInputType.number,
                          autofocus: true,
                          style: TextStyle(color: textDark),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "CEP",
                            labelStyle: TextStyle(color: textDark),
                            prefixIcon: Icon(
                              Icons.map,
                              color: Colors.brown,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        TextFormField(
                          validator: (value) {
                            if (value!.length != 10) {
                              return "Digite uma data de nascimento válida";
                            }
                            return null;
                          },

                          inputFormatters: [FilteringTextInputFormatter.digitsOnly,DataInputFormatter(), ],
                          controller: widget._controller.txtDtNasc,
                          keyboardType: TextInputType.datetime,
                          autofocus: true,
                          style: TextStyle(color: textDark),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Data de Nascimento",
                            labelStyle: TextStyle(color: textDark),
                            prefixIcon: Icon(
                              Icons.event,
                              color: textDark,
                            ),
                          ),
                        ),
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
                          onPressed: () {
                            // salva os dados do usuário
                            widget._controller.atualizaUsuario(new sqlUsuarios(
                                widget._controller.txtEmail.text
                                    .removeAllWhitespace,
                                widget._controller.txtNome.text.trimRight(),
                                widget._controller.txtSobreNome.text
                                    .trimRight(),
                                widget._controller.txtCPF.text
                                    .removeAllWhitespace,
                                widget._controller.txtTelefone.text
                                    .removeAllWhitespace,
                                widget._controller.txtCEP.text
                                    .removeAllWhitespace,
                                widget._controller.txtEndereco.text
                                    .trimRight()
                                    .trimLeft(),
                                widget._controller.txtNumero.text
                                  ..trimRight().trimLeft(),
                                widget._controller.txtCompl.text
                                    .trimRight()
                                    .trimLeft(),
                                null,
                                null,
                                null));

                            Get.defaultDialog(title: "Aviso", middleText: "Informações atualizadas com sucesso!");

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
                            // redireciona pra tela de alterar senha
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
