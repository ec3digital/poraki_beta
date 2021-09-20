import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/container_options.dart';
import '../show_day_offer_controller.dart';

class ContainerAmountProductDayOffer extends StatelessWidget {
  const ContainerAmountProductDayOffer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShowDayOfferController>(builder: (_) {
      return ContainerOptions(
        onTap: _.openBottomSheet,
        widget: Text('Quantidade: ${_.amountProduct.toString()}'),
      );
    });
  }
}
