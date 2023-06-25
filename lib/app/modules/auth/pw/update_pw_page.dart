import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/auth/pw/pw_controller.dart';
import 'package:poraki/app/modules/home/widgets/drawer_home.dart';
import 'package:poraki/app/modules/home/widgets/gradient_header_home.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:poraki/app/util/alerta.dart';

class UpdatePwPage extends StatefulWidget {
  // final HomeController controller = Get.find(); // Get.put(HomeController());
  final PwController _pwController = Get.put(PwController());
  final LoginController _loginController = Get.find();
  UpdatePwPage({Key? key}) : super(key: key);

  @override
  State<UpdatePwPage> createState() => _UpdatePwPageState();
}

class _UpdatePwPageState extends State<UpdatePwPage> {
  Future<void> carregaObjUsuario() async {
    widget._pwController.txtEmail.text =
        widget._loginController.usuEmail.toString();
  }

  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.find();

    Color textDark = _loginController.colorFromHex(_loginController.listCore
        .where((coreItem) => coreItem.coreChave == 'textLight')
        .first
        .coreValor
        .toString());

    return FutureBuilder(
        future: carregaObjUsuario(),
        builder: (context, futuro) {

            return Scaffold(
                drawer: DrawerHome(0),
                backgroundColor: _loginController.colorFromHex(_loginController
                    .listCore
                    .where((coreItem) => coreItem.coreChave == 'backDark')
                    .first
                    .coreValor
                    .toString()),
                body: Scaffold(
                    appBar: PreferredSize(
                      preferredSize: Size(double.maxFinite, 55),
                      child: AppBar(
                        // elevation: 0,
                        centerTitle: false,
                        backgroundColor: _loginController.colorFromHex(
                            _loginController.listCore
                                .where((coreItem) =>
                                    coreItem.coreChave == 'backLight')
                                .first
                                .coreValor
                                .toString()),
                        title: Text(
                          'Atualizar senha',
                          style: TextStyle(fontSize: 25, color: _loginController.colorFromHex(_loginController.listCore
                              .where((coreItem) => coreItem.coreChave == 'textDark')
                              .first
                              .coreValor
                              .toString())),
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
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          readOnly: true,
                          controller: widget._pwController.txtEmail,
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
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //     bottom: 15,
                        //   ),
                        // ),
                        GetBuilder<PwController>(builder: (_) {
                          return Column(
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value!.length < 6) {
                                    return "A senha deve ter pelo menos 6 caracteres";
                                  }
                                  return null;
                                },
                                controller: widget._pwController.txtPassword,
                                obscureText: !widget._pwController.showPassword,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Nova senha",
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
                                      widget._pwController.txtPassword.text
                                          .trim()) {
                                    return "As senhas devem ser iguais";
                                  }
                                  return null;
                                },
                                controller:
                                    widget._pwController.txtConfirmPassword,
                                obscureText: !widget._pwController.showPassword,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Confirme a nova senha",
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
                            GetBuilder<PwController>(
                              builder: (_) {
                                return Checkbox(
                                  value: widget._pwController.showPassword,
                                  onChanged: (newValue) {
                                    widget._pwController
                                        .changeShowPassword(newValue!);
                                  },
                                  activeColor: Colors.blue,
                                );
                              },
                            ),
                            Text(
                              "Mostrar senhas",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        ButtonOffer(
                          onPressed: () async {
                            await widget._pwController.atualizaPw();

                            Alerta(context, 'Senha alterada com sucesso!');
                          },
                          colorText: textDark,
                          text: 'Confirmar',
                          colorButton: _loginController.colorFromHex(
                              _loginController.listCore
                                  .where((coreItem) =>
                                      coreItem.coreChave == 'textDark')
                                  .first
                                  .coreValor
                                  .toString()),
                        ),
                      ])
                          // ],
                          ),
                    ))));
          }
        );
  }
}
