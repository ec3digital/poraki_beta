import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/routes/app_routes.dart';
import 'package:poraki/app/shared/porakiprefs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home_page.dart';
import '../../../theme/app_theme.dart';
import 'package:poraki/app/services/hive/hive_poraki_user_service.dart';

class DrawerHome extends StatelessWidget {
  final int index;
  DrawerHome(
    this.index, {
    Key? key,
  }) : super(key: key);

  // late final SharedPreferences _sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              color: Colors.amber,
              height: Get.height * 0.14,
              //margin: EdgeInsets.only(top: 10, left: 1, right: 1),
              child: Column(
                  children: [
                    Center(child: Text('')),
                    Center(child: Text('')),
                FutureBuilder(
                    future: hivePorakiUserService().GetUserName(),
                    initialData: "...",
                    builder: (context, snapshot) {
                      return Center(
                        child: Text(
                          snapshot.data.toString(),
                          style: TextStyle(fontSize: 22.0),
                        ),
                      );
                    }),
                FutureBuilder(
                    future: hivePorakiUserService().GetUserCep(),
                    initialData: "...",
                    builder: (context, snapshot) {
                      return Center(
                        child: Text(
                          'CEP: ' + snapshot.data.toString(),
                          style: TextStyle(fontSize: 18.0),
                        ),
                      );
                    }),
                    // FutureBuilder(
                    //     future: hivePorakiUserService().GetUserEmail(),
                    //     initialData: "...",
                    //     builder: (context, snapshot) {
                    //       return Center(
                    //         child: Text(
                    //           snapshot.data.toString(),
                    //           style: TextStyle(fontSize: 14.0),
                    //         ),
                    //       );
                    //     }),
              ])
          ),


          // child:
          // GestureDetector(
          //     onTap: () {},
          //     child: Row(
          //       children: [
          //         CircleAvatar(
          //           //backgroundImage: AssetImage('assets/images/photodune.png'),
          //         ),
          //         const SizedBox(width: 15),
          //
          //         AutoSizeText(
          //           hivePorakiUserService().GetUserEmail(),
          //           style: Get.textTheme.bodyText1!.copyWith(
          //             fontWeight: FontWeight.normal,
          //             fontSize: 18,
          //           ),
          //         ),
          //         Spacer(),
          //         Icon(
          //           Icons.arrow_forward_ios_sharp,
          //           size: 15,
          //         )
          //       ],
          //     ),
          //   ),

          RowCategoriesDrawerHome(
            text: 'Inicio',
            isSelected: index == 0,
            icon: Icons.home_outlined,
            onTap: () => Get.toNamed(AppRoutes.home),
          ),
          const Divider(),
          RowCategoriesDrawerHome(
            text: 'Carrinho',
            isSelected: index == 1,
            icon: Icons.shopping_bag_outlined,
            onTap: () => Get.toNamed(AppRoutes.shoppingCart),
          ),
          RowCategoriesDrawerHome(
            text: 'Categorias',
            isSelected: index == 1,
            icon: Icons.category,
            onTap: () => Get.toNamed(AppRoutes.categories),
          ),

          RowCategoriesDrawerHome(
            text: 'Minhas Compras',
            isSelected: index == 2,
            icon: Icons.shopping_bag_outlined,
            onTap: () => Get.toNamed(AppRoutes.orders),
          ),
          RowCategoriesDrawerHome(
            text: 'Minhas ofertas',
            isSelected: index == 3,
            icon: Icons.local_offer_rounded,
              onTap: () => Get.toNamed(AppRoutes.mOffers),
          ),
          // RowCategoriesDrawerHome(
          //   text: 'Ofertas do dia',
          //   icon: Icon(
          //     Icons.web_rounded,
          //   ),
          //   onTap: () {},
          // ),
          RowCategoriesDrawerHome(
            text: 'Minha conta',
            isSelected: index == 4,
            icon: Icons.person_outline,
            onTap: () => Get.toNamed(AppRoutes.account),
          ),
          RowCategoriesDrawerHome(
            text: 'Endereços',
            isSelected: index == 5,
            icon: Icons.map,
            onTap: () => Get.toNamed(AppRoutes.addresses),
          ),
          const Divider(),
          RowCategoriesDrawerHome(
            text: 'Vendas',
            isSelected: index == 6,
            icon: Icons.monetization_on_outlined,
             onTap: () => Get.toNamed(AppRoutes.orders),
          ),
          RowCategoriesDrawerHome(
            text: 'Entregas',
            isSelected: index == 7,
            icon: Icons.shopping_cart_outlined,
            onTap: () {},
          ),
          const Divider(),
          RowCategoriesDrawerHome(
            text: 'Sair',
            isSelected: index == 8,
            onTap: () {
              Get.deleteAll(force: true);
              _runSpecialCmds();
              Get.offAllNamed(AppRoutes.signIn);
              },
            icon: Icons.arrow_back,
          )
        ],
      ),
    );
  }

  Future<String?> getUserData() async {
    return PorAkiPrefs().getPrefStr("userEmail");
  }
}
void _runSpecialCmds() {

}

class RowCategoriesDrawerHome extends StatelessWidget {
  final bool isSelected;
  final String text;
  final Function() onTap;
  final IconData icon;

  const RowCategoriesDrawerHome({
    Key? key,
    required this.text,
    required this.onTap,
    required this.icon,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      minLeadingWidth: (Get.width * 0.8) * 0.02,
      title: Text(
        text,
        style: Get.textTheme.bodyText1!.copyWith(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? AppColors.primaryColor : Colors.black,
        ),
      ),
      leading: Icon(
        icon,
        color: isSelected ? AppColors.primaryColor : Colors.black,
      ),
    );
  }
}
