import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/common_widgets/container_options.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';

class DetailOffer extends StatelessWidget {
  final String? detailProduct;
  final String? moreDetailProduct;
  final Color? backColor;
  final double? fontSize;

  DetailOffer({
    Key? key,
    required this.detailProduct,
    this.moreDetailProduct,
    this.backColor,
    this.fontSize
  }) : super(key: key);

  final LoginController _loginController = Get.find();
  late Color textColor;
  // late Color backColor;

  @override
  Widget build(BuildContext context) {
    textColor = _loginController.colorFromHex(_loginController.listCore
        .where((coreItem) => coreItem.coreChave == 'textDark')
        .first
        .coreValor
        .toString());
    //
    // return Flex(direction: Axis.vertical,
    //     children: [
    //   Column(
    //           crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
    //         Text(detailProduct!,
    //             style: TextStyle(
    //                 fontSize: fontSize == null ? 18 : fontSize,
    //                 color: textColor))]
    // ,)]);

    return ContainerOptions(
      onTap: () => Get.defaultDialog(title: detailProduct.toString(), middleText: moreDetailProduct.toString(),
      // actions: [
      //   TextButton(
      //     onPressed: () {},// => Navigator.pop(context, false), // passing false
      //     child: Text('Ok'),
      //   ),
      // ],
      ),
      widget: Expanded(
          child:
        Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Text(detailProduct! + " toque para ver",
              style: TextStyle(
                  fontSize: fontSize == null ? 18 : fontSize,
                  color: textColor)),
          // Spacer(),
      ])
      ),
    );
  }
}
