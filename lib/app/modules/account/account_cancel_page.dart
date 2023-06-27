import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/auth/pw/pw_controller.dart';
import 'package:poraki/app/modules/home/widgets/drawer_home.dart';
import 'package:poraki/app/modules/home/widgets/gradient_header_home.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:poraki/app/routes/app_routes.dart';

class AccountCancelPage extends StatefulWidget {
  final PwController _pwController = Get.put(PwController());
  AccountCancelPage({Key? key}) : super(key: key);

  @override
  State<AccountCancelPage> createState() => _AccountCancelPageState();
}

class _AccountCancelPageState extends State<AccountCancelPage> {
  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.find();
    final FirebaseAuth? auth = FirebaseAuth.instance;

    Color textDark = _loginController.colorFromHex(_loginController.listCore
        .where((coreItem) => coreItem.coreChave == 'textLight')
        .first
        .coreValor
        .toString());

    return Scaffold(
        drawer: DrawerHome(0),
        backgroundColor: _loginController.colorFromHex(_loginController.listCore
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
                backgroundColor: _loginController.colorFromHex(_loginController
                    .listCore
                    .where((coreItem) => coreItem.coreChave == 'backLight')
                    .first
                    .coreValor
                    .toString()),
                title: Text(
                  'Cancelamento de conta',
                  style: TextStyle(
                      fontSize: 25,
                      color: _loginController.colorFromHex(_loginController
                          .listCore
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
                Center(
                    child: Text(
                        'Atenção: tem certeza que voce deseja cancelar a sua conta ${auth!.currentUser!.displayName.toString()} neste aplicativo ?', textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, color: textDark))),
                const SizedBox(
                  height: 30,
                ),
                ButtonOffer(
                  onPressed: () async {
                    await auth.currentUser!.delete();
                    Get.toNamed(AppRoutes.accountBye);
                  },
                  colorText: textDark,
                  text: 'Sim',
                  colorButton: _loginController.colorFromHex(_loginController
                      .listCore
                      .where((coreItem) => coreItem.coreChave == 'textDark')
                      .first
                      .coreValor
                      .toString()),
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonOffer(
                  onPressed: () async {
                    Get.toNamed(AppRoutes.home);
                  },
                  colorText: textDark,
                  text: 'Não',
                  colorButton: _loginController.colorFromHex(_loginController
                      .listCore
                      .where((coreItem) => coreItem.coreChave == 'textDark')
                      .first
                      .coreValor
                      .toString()),
                ),
              ])
                  // ],
                  ),
            ))));
  }
}
