import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ContainerOptions extends StatelessWidget {

  final Widget widget;
  final Function() onTap;

  const ContainerOptions({Key? key, required this.widget, required this.onTap,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.grayLightContainer,
          borderRadius: BorderRadius.circular(08),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget,
            Icon(
              Icons.arrow_forward_ios_sharp,
              color: AppColors.primaryColor,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
