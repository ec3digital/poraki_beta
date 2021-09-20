import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/container_options.dart';

class DetailOfferDay extends StatelessWidget {
  final String detailProduct;

  const DetailOfferDay({
    Key? key,
    required this.detailProduct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContainerOptions(
      onTap: () {},
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detalhes:',
            style: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w400, fontSize: 15),
          ),
          Text(detailProduct),
        ],
      ),
    );
  }
}
