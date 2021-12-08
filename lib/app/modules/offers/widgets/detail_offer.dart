import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/common_widgets/container_options.dart';

class DetailOffer extends StatelessWidget {
  final String? detailProduct;

  const DetailOffer({
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
            style: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w400, fontSize: 18),
          ),
          Text(detailProduct!, style: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w700, fontSize: 12)),
        ],
      ),
    );
  }
}
