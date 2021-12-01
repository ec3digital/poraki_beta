import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/routes/app_routes.dart';
import '../../../../theme/app_theme.dart';

class AppBarShowDayOffer extends StatelessWidget {
  final String? adressUser;

  const AppBarShowDayOffer({
    Key? key,
    this.adressUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.amber,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Produto',
            style: Get.textTheme.bodyText1!.copyWith(
              color: AppColors.black54Text,
              fontWeight: FontWeight.w400,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite_border),
              ),
              IconButton(
                onPressed: () => Get.toNamed(AppRoutes.viewSearchProduct),
                icon: Icon(Icons.search),
              ),
              IconButton(
                onPressed: () => Get.toNamed(AppRoutes.shoppingCart),
                icon: Icon(Icons.shopping_cart_outlined),
              ),
            ],
          ),
        ],
      ),
      flexibleSpace: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          margin: const EdgeInsets.all(10),
          child: InkWell(
            onTap: () {},
            child: Row(
              children: [
                Icon(
                  Icons.location_on_rounded,
                  size: 15,
                ),
                const SizedBox(width: 08),
                Text(
                  adressUser!,
                  style: Get.textTheme.bodyText1!.copyWith(
                    fontSize: 12,
                    color: AppColors.black54Text,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 12,
                  color: AppColors.black54Text,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
