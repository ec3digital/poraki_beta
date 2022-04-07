import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';

class GradientHeaderHome extends StatelessWidget {
  final Widget child;
  const GradientHeaderHome({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.find();
    print(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'primaryBackground').first.coreValor.toString());
    print(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'secondaryBackground').first.coreValor.toString());

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [


            Color(0xffC3D99E),
            // Color(0x99C3D99E),
            // Color(0x999A9A9A),
            // Color(0x999A9A9A),
            Color(0xffFFFFFF),
            // Color(0xffd9d9d9),
            // _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'primaryBackground').first.coreValor.toString()),
            // _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'primaryBackground').first.coreValor.toString()),
            // _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'primaryBackground').first.coreValor.toString()),
            // _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'secondaryBackground').first.coreValor.toString())

            // Colors.amber,
            // Colors.amberAccent,
            // Colors.white,
            // Colors.white,
            // Colors.white,
            // Color(0xff8700),
            // Color(0xffafafa),
            // Color(0xffafafa),
            // Color(0xffafafa),
          ],
        ),
      ),
      child: child,
    );
  }
}
