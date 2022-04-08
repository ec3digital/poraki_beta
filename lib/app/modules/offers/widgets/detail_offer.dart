import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/common_widgets/container_options.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';

class DetailOffer extends StatelessWidget {
  final String? detailProduct;

  const DetailOffer({
    Key? key,
    required this.detailProduct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.find();

    return ContainerOptions(
      onTap: () {},
      widget: Expanded(
          child:
        Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[

          Text(detailProduct!,
              style: TextStyle(
                  fontSize: 16,

                  color: _loginController.colorFromHex(_loginController.listCore
                      .where((coreItem) => coreItem.coreChave == 'textDark')
                      .first
                      .coreValor
                      .toString()))),
      ])),
    );
  }
}
