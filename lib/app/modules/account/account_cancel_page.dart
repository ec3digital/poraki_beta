import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/repositories/offer_repository.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/auth/pw/pw_controller.dart';
import 'package:poraki/app/modules/home/widgets/drawer_home.dart';
import 'package:poraki/app/modules/home/widgets/gradient_header_home.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:poraki/app/routes/app_routes.dart';

class AccountCancelPage extends StatefulWidget {
  // final PwController _pwController = Get.put(PwController());
  AccountCancelPage({Key? key}) : super(key: key);

  @override
  State<AccountCancelPage> createState() => _AccountCancelPageState();
}

class _AccountCancelPageState extends State<AccountCancelPage> {
  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.find();
    final FirebaseAuth? auth = FirebaseAuth.instance;

    Color textDark = _loginController.colorFromHex(_loginController.textLight);

    return Scaffold(
        drawer: DrawerHome(0),
        backgroundColor: _loginController.colorFromHex(_loginController.backDark),
        body: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(double.maxFinite, 55),
              child: AppBar(
                // elevation: 0,
                centerTitle: false,
                backgroundColor: _loginController.colorFromHex(_loginController.backLight),
                title: Text(
                  'Cancelamento de conta',
                  style: TextStyle(
                      fontSize: 25,
                      color: _loginController.colorFromHex(_loginController.textDark)),
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
                    // desativa as ofertas do Vendedor
                    var offerRepo = new OfferRepository();
                    await offerRepo.deleteOfferByStore(auth.currentUser!.uid.toString());

                    // remove o usuário da base do Firebase
                    await auth.currentUser!.delete();
                    Get.toNamed(AppRoutes.accountBye);
                  },
                  colorText: textDark,
                  text: 'Sim',
                  colorButton: _loginController.colorFromHex(_loginController.textDark),
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
                  colorButton: _loginController.colorFromHex(_loginController.textDark),
                ),
              ])
                  // ],
                  ),
            ))));
  }
}
