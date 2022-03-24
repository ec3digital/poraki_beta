import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/sql/sqlUsuario.dart';
import 'package:poraki/app/modules/account/account_controller.dart';
import 'package:poraki/app/modules/home/widgets/gradient_header_home.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'package:poraki/app/theme/app_theme.dart';

class AccountBody extends StatefulWidget {
  AccountBody({
    Key? key,
    // required this.controller,
  }) : super(key: key);

  AccountController _controller = Get.put(AccountController());

  @override
  _AccountBodyState createState() => _AccountBodyState();
}

class _AccountBodyState extends State<AccountBody> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget._controller.carregaUsuario(),
        builder: (context, futuro) {
          if (futuro.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); //Text('carrinho vazio'));
            // } else if (futuro.hasError) {
            //   return Center(child: Text(futuro.error.toString()));
          } else {
            return SingleChildScrollView(
              child: GradientHeaderHome(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        "Minha conta",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    Form(
                      // key: controller.formKey,
                      child: Column(children: [
                        TextFormField(
                          // validator: (value) {
                          //   if (value!.length < 4) {
                          //     return "Digite um nome maior";
                          //   }
                          //   return null;
                          // },
                          controller: widget._controller.txtNome,
                          autofocus: true,
                          style: TextStyle(color: Colors.brown),
                          decoration: InputDecoration(
                            labelText: "Nome",
                            labelStyle: TextStyle(color: Colors.brown),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.brown,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown),
                            ),
                          ),
                        ),
                        TextFormField(
                          // validator: (value) {
                          //   if (value!.length < 10) {
                          //     return "Digite um nome maior";
                          //   }
                          //   return null;
                          // },
                          controller: widget._controller.txtSobreNome,
                          autofocus: true,
                          style: TextStyle(color: Colors.brown),
                          decoration: InputDecoration(
                            labelText: "Sobrenome",
                            labelStyle: TextStyle(color: Colors.brown),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.brown,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown),
                            ),
                          ),
                        ),
                        TextFormField(
                          // validator: (value) {
                          //   if (value!.length != 11) {
                          //     return "CPF inválido";
                          //   }
                          //   return null;
                          // },
                          controller: widget._controller.txtCPF,
                          keyboardType: TextInputType.number,
                          autofocus: true,
                          style: TextStyle(color: Colors.brown),
                          decoration: InputDecoration(
                            labelText: "CPF",
                            labelStyle: TextStyle(color: Colors.brown),
                            prefixIcon: Icon(
                              Icons.assignment_ind,
                              color: Colors.brown,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown),
                            ),
                          ),
                        ),
                        TextFormField(
                          // validator: (value) {
                          //   if (value!.length != 11) {
                          //     return "Por favor digite um telefone válido";
                          //   }
                          //   return null;
                          // },
                          controller: widget._controller.txtTelefone,
                          keyboardType: TextInputType.phone,
                          autofocus: true,
                          style: TextStyle(color: Colors.brown),
                          decoration: InputDecoration(
                            labelText: "Telefone Celular",
                            labelStyle: TextStyle(color: Colors.brown),
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.brown,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown),
                            ),
                          ),
                        ),
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
                          style: TextStyle(color: Colors.brown),
                          decoration: InputDecoration(
                            labelText: "E-mail",
                            labelStyle: TextStyle(
                              color: Colors.brown,
                            ),
                            prefixIcon: Icon(
                              Icons.mail_outline,
                              color: Colors.brown,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown),
                            ),
                          ),
                        ),
                        TextFormField(
                          // validator: (value) {
                          //   if (value!.length != 8) {
                          //     return "Digite um CEP válido";
                          //   }
                          //   return null;
                          // },
                          controller: widget._controller.txtCEP,
                          keyboardType: TextInputType.number,
                          autofocus: true,
                          style: TextStyle(color: Colors.brown),
                          decoration: InputDecoration(
                            labelText: "CEP",
                            labelStyle: TextStyle(color: Colors.brown),
                            prefixIcon: Icon(
                              Icons.map,
                              color: Colors.brown,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown),
                            ),
                          ),
                        ),
                        TextFormField(
                          // validator: (value) {
                          //   if (value!.length != 10) {
                          //     return "Digite uma data de nascimento válida";
                          //   }
                          //   return null;
                          // },
                          controller: widget._controller.txtDtNasc,
                          keyboardType: TextInputType.datetime,
                          autofocus: true,
                          style: TextStyle(color: Colors.brown),
                          decoration: InputDecoration(
                            labelText: "Data de Nascimento",
                            labelStyle: TextStyle(color: Colors.brown),
                            prefixIcon: Icon(
                              Icons.event,
                              color: Colors.brown,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown),
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
                      ]),
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
                    ),
                    ButtonOffer(
                      onPressed: () {
                        // salva os dados do usuário
                        widget._controller.atualizaUsuario(new sqlUsuarios(
                            widget
                                ._controller.txtEmail.text.removeAllWhitespace,
                            widget._controller.txtNome.text.trimRight(),
                            widget._controller.txtSobreNome.text.trimRight(),
                            widget._controller.txtCPF.text.removeAllWhitespace,
                            widget._controller.txtTelefone.text
                                .removeAllWhitespace,
                            widget._controller.txtCEP.text.removeAllWhitespace,
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

                        final snackBar = SnackBar(
                            backgroundColor: AppColors.primaryColor,
                            content: Container(
                                height: 40,
                                child: Center(
                                    child: const Text('Informações salvas!'))));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      colorText: AppColors.primaryBackground,
                      text: 'Salvar',
                      colorButton: AppColors.primaryColor,
                    ),
                    ButtonOffer(
                      onPressed: () {
                        // redireciona pra tela de alterar senha
                      },
                      colorText: AppColors.primaryColor,
                      text: 'Mudar senha',
                      colorButton: AppColors.primaryColorButton,
                    ),
                    // )
                  ])
                  // ],
                  ),
            );
            // );
          }
        });
  }
}
