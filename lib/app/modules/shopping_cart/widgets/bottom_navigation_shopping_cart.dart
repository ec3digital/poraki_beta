import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/app_theme.dart';

class BottomNavigationShoppingCart extends StatelessWidget {
  const BottomNavigationShoppingCart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      elevation: 4,
      child: Container(
        width: Get.width,
        height: Get.height * 0.20,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Row(
                children: [
                  Text(
                    'Envio: ',
                    style: Get.textTheme.bodyText1!.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'Rua tal com tal coisa 85, São Paulo',
                    style: Get.textTheme.bodyText1!.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total com o frete'),
                  Text('R\$ 2.158.00'),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: Get.width,
              child: ElevatedButton(
                onPressed: (){},
                child: Text('Continuar a compra'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
