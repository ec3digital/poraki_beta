import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/routes/app_routes.dart';
import 'package:poraki/app/shared/porakiprefs.dart';

class DrawerHome extends StatelessWidget {
  final int index;
  DrawerHome(
    this.index, {
    Key? key,
  }) : super(key: key);

  LoginController _login = Get.put(LoginController());

  Future<void> _loadLogin() async {
    print('_loadLogin');
    await _login.loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.find();
    // Color lightBack = _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backDark').first.coreValor.toString());

    return FutureBuilder(
        future: _loadLogin(),
        builder: (context, futuro) {
          if (futuro.connectionState == ConnectionState.waiting) {
            return Scaffold();
          } else {
            return Drawer(
              backgroundColor: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backLight').first.coreValor.toString()),
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      color: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backDark').first.coreValor.toString()),
                      height: Get.height * 0.13,
                      //margin: EdgeInsets.only(top: 10, left: 1, right: 1),
                      child: Column(children: [
                        Center(child: Text('')),
                        Center(child: Text('')),
                        Center(child: Text(_login.usuNome.toString())),
                        Center(child: Text(_login.usuCep.toString())),
                        // FutureBuilder(
                        //     future: hivePorakiUserService().GetUserName(),
                        //     initialData: "...",
                        //     builder: (context, snapshot) {
                        //       return Center(
                        //         child: Text(
                        //           snapshot.data.toString(),
                        //           style: TextStyle(fontSize: 22.0),
                        //         ),
                        //       );
                        //     }),
                        // FutureBuilder(
                        //     future: hivePorakiUserService().GetUserCep(),
                        //     initialData: "...",
                        //     builder: (context, snapshot) {
                        //       return Center(
                        //         child: Text(
                        //           'CEP: ' + snapshot.data.toString(),
                        //           style: TextStyle(fontSize: 18.0),
                        //         ),
                        //       );
                        //     }),
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
                      ])),

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
                  //Divider(color: lightBack),
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
                    onTap: () => Get.offAndToNamed(AppRoutes.orders, arguments: {"tipo": "Compras"}),
                  ),
                  RowCategoriesDrawerHome(
                    text: 'Minhas Lojas',
                    isSelected: index == 3,
                    icon: Icons.store,
                    onTap: () => Get.toNamed(AppRoutes.stores),
                  ),
                  RowCategoriesDrawerHome(
                    text: 'Minhas ofertas',
                    isSelected: index == 4,
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
                    isSelected: index == 5,
                    icon: Icons.person_outline,
                    onTap: () => Get.toNamed(AppRoutes.account),
                  ),
                  // RowCategoriesDrawerHome(
                  //   text: 'Minhas lojas',
                  //   isSelected: index == 4,
                  //   icon: Icons.store,
                  //   onTap: () => Get.toNamed(AppRoutes.account),
                  // ),
                  RowCategoriesDrawerHome(
                    text: 'Endereços',
                    isSelected: index == 6,
                    icon: Icons.map,
                    onTap: () => Get.toNamed(AppRoutes.addresses),
                  ),
                  // Divider(color: lightBack),
                  RowCategoriesDrawerHome(
                    text: 'Vendas',
                    isSelected: index == 7,
                    icon: Icons.monetization_on_outlined,
                    onTap: () => Get.offAndToNamed(AppRoutes.orders, arguments: {"tipo": "Vendas"}),
                  ),
                  RowCategoriesDrawerHome(
                    text: 'Entregas',
                    isSelected: index == 8,
                    icon: Icons.shopping_cart_outlined,
                    onTap: () => Get.offAndToNamed(AppRoutes.orders, arguments: {"tipo": "Entregas"}),
                  ),
                  // Divider(color: lightBack),
                  RowCategoriesDrawerHome(
                    text: 'Sair',
                    isSelected: index == 9,
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
        });
  }

  Future<String?> getUserData() async {
    return PorAkiPrefs().getPrefStr("userEmail");
  }
}

void _runSpecialCmds() {
  //sqlPorakiAddressService().redefineTabela();
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
    LoginController _loginController = Get.find();

    return ListTile(
      onTap: onTap,
      tileColor: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backLight').first.coreValor.toString()),
      minLeadingWidth: (Get.width * 0.8) * 0.02,
      title: Text(
        text,
        style: Get.textTheme.bodyText1!.copyWith(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'textDark').first.coreValor.toString()),
        ),
      ),
      leading: Icon(
        icon,
        color: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'textDark').first.coreValor.toString()),
      ),
    );
  }
}
