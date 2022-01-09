import 'package:flutter/material.dart';
import 'package:poraki/app/modules/checkout/widgets/app_checkout.dart';
import '../../theme/app_theme.dart';
import 'widgets/body_checkout.dart';

class CheckoutPage extends StatelessWidget {
  CheckoutPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayLightContainer,
      appBar: appBarCheckout(),
      body: BodyCheckOut(),
    );
  }
}
