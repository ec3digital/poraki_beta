import 'package:badges/badges.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/offers/offers_controller.dart';
import 'package:poraki/app/routes/app_routes.dart';
import 'package:poraki/app/services/sqlite/sqlporaki_login_service.dart';
import 'package:poraki/app/shared/porakiprefs.dart';

class DrawerHome extends StatefulWidget {
  final int index;
  DrawerHome(
    this.index, {
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerHome> createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {
  final LoginController _login = Get.find();

  // Get.put(LoginController());
  //final OrderController _orderController = Get.find();
  bool load = true;

  @override
  void initState() {
    // _loadLogin();

    super.initState();
  }

  Future<void> _loadLogin() async {
    if (load) {
      load = false;
      print('_loadLogin');
      //await _login.loadUserData();
    }
  }

  @override
  Widget build(BuildContext context) {
    //LoginController _loginController = Get.find();
    Color lightBack = _login.colorFromHex(_login.listCore
        .where((coreItem) => coreItem.coreChave == 'backLight')
        .first
        .coreValor
        .toString());
    Color darkBack = _login.colorFromHex(_login.listCore
        .where((coreItem) => coreItem.coreChave == 'backDark')
        .first
        .coreValor
        .toString());

    // TODO: remover daqui e pegar direto do login Controller
    return FutureBuilder(
        future: _loadLogin(),
        builder: (context, futuro) {
          if (futuro.connectionState == ConnectionState.waiting) {
            return Scaffold();
          } else {
            return Container(
                padding: EdgeInsets.zero,
                width: Get.width * 0.7,
                color: lightBack,
                child: ListView(
                  // Important: Remove any padding from the ListView.
                  padding: EdgeInsets.zero,
                  children: [
                    SizedBox(
                        height: 100.0,
                        child: DrawerHeader(
                            decoration: BoxDecoration(color: darkBack),
                            margin: EdgeInsets.all(0.0),
                            child: Column(children: [
                              Center(child: Text(_login.usuNome.toString())),
                              Center(child: Text(_login.usuCep.toString())),
                            ]))),

                    RowCategoriesDrawerHome(
                      text: 'Inicio',
                      // isSelected: index == 0,
                      icon: Icons.home_outlined,
                      onTap: () => Get.toNamed(AppRoutes.home),
                    ),
                    RowCategoriesDrawerHome(
                        text: 'Mensagens',
                        badgeText: "4",
                        // isSelected: index == 8,
                        icon: Icons.message,
                        onTap:
                            () {} // => Get.offAndToNamed(AppRoutes.orders, arguments: {"tipo": "Entregas"}),
                        ),
                    //Divider(color: lightBack),
                    // RowCategoriesDrawerHome(
                    //   text: 'Carrinho',
                    //   // isSelected: index == 1,
                    //   icon: Icons.shopping_bag_outlined,
                    //   onTap: () => Get.toNamed(AppRoutes.shoppingCart),
                    // ),
                    RowCategoriesDrawerHome(
                      text: 'Notícias da região',
                      // isSelected: index == 1,
                      icon: Icons.near_me_outlined,
                      onTap: () => Get.toNamed(AppRoutes.news),
                    ),
                    RowCategoriesDrawerHome(
                      text: 'Categorias',
                      // isSelected: index == 1,
                      icon: Icons.category,
                      onTap: () => Get.toNamed(AppRoutes.categories),
                    ),
                    RowCategoriesDrawerHome(
                      text: 'Favoritos',
                      // isSelected: index == 1,
                      icon: Icons.favorite_border_outlined,
                      onTap: () async {
                        OffersController _offersController = Get.find(); // Get.put(OffersController());
                        Future.wait(
                            [_offersController.getOffersFavsByUser(24)]);

                        Get.toNamed(AppRoutes.offers, arguments: [
                          {'listName': 'favsoffers'},
                          {'limit': 24},
                          {'category': null},
                          {'title': 'Favoritas'},
                          {'ofertaGuid': null}
                        ]);
                      },
                    ),
                    RowCategoriesDrawerHome(
                      text: 'Meus endereços',
                      // isSelected: index == 6,
                      icon: Icons.map,
                      onTap: () => Get.toNamed(AppRoutes.addresses),
                    ),
                    RowCategoriesDrawerHome(
                        text: 'Minhas compras',
                        // isSelected: index == 2,
                        icon: Icons.shopping_bag_outlined,
                        onTap: () => Get.offAndToNamed(AppRoutes.orders,
                            arguments: ["Compras"])),
                    RowCategoriesDrawerHome(
                      text: 'Minhas lojas',
                      // isSelected: index == 3,
                      icon: Icons.store,
                      onTap: () => Get.toNamed(AppRoutes.stores),
                    ),
                    RowCategoriesDrawerHome(
                      text: 'Minhas ofertas',
                      // isSelected: index == 4,
                      icon: Icons.local_offer_rounded,
                      onTap: () => Get.toNamed(AppRoutes.mOffers),
                    ),
                    RowCategoriesDrawerHome(
                        text: 'Vendas',
                        // isSelected: index == 7,
                        icon: Icons.monetization_on_outlined,
                        onTap: () => Get.offAndToNamed(AppRoutes.orders,
                            arguments: ["Vendas"])),
                    RowCategoriesDrawerHome(
                        text: 'Entregas',
                        // isSelected: index == 8,
                        icon: Icons.shopping_cart_outlined,
                        onTap: () => Get.offAndToNamed(AppRoutes.orders,
                            arguments: ["Entregas"])),
                    RowCategoriesDrawerHome(
                      text: 'Minha conta',
                      // isSelected: index == 5,
                      icon: Icons.person_outline,
                      onTap: () => Get.toNamed(AppRoutes.account),
                    ),
                    Divider(
                      color: darkBack,
                    ),
                    RowCategoriesDrawerHome(
                      text: 'Sair',
                      // isSelected: index == 9,
                      onTap: () {
                        Get.deleteAll(force: true);
                        _runSpecialCmds();
                        Get.offAllNamed(AppRoutes.signIn);
                      },
                      icon: Icons.arrow_back,
                    )
                  ],
                ));
          }
        });
  }

  Future<String?> getUserData() async {
    return PorAkiPrefs().getPrefStr("userEmail");
  }
}

void _runSpecialCmds() {
  //sqlPorakiPedidoService().redefineTabela();
  //sqlPorakiPedidoService().atualizaSellers();
  sqlPorakiLoginService().doSpecial();
}

class RowCategoriesDrawerHome extends StatelessWidget {
  final bool isSelected;
  final String text;
  final Function() onTap;
  final IconData icon;
  final String? badgeText;

  const RowCategoriesDrawerHome(
      {Key? key,
      required this.text,
      required this.onTap,
      required this.icon,
      this.isSelected = false,
      this.badgeText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.find();
    var x = badgeText;

    if (badgeText == null) {
      return ListTile(
        style: ListTileStyle.list,
        onTap: onTap,
        tileColor: _loginController.colorFromHex(_loginController.listCore
            .where((coreItem) => coreItem.coreChave == 'backLight')
            .first
            .coreValor
            .toString()),
        minLeadingWidth: (Get.width * 0.3) * 0.01,
        title: Text(
          text,
          style: TextStyle(
            fontSize: 16, //fontWeight: FontWeight.bold,
            // height: 0.1,
            // fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: _loginController.colorFromHex(_loginController.listCore
                .where((coreItem) => coreItem.coreChave == 'textDark')
                .first
                .coreValor
                .toString()),
          ),
        ),
        leading: Icon(
          icon,
          color: _loginController.colorFromHex(_loginController.listCore
              .where((coreItem) => coreItem.coreChave == 'textDark')
              .first
              .coreValor
              .toString()),
          size: 20,
        ),
      );
    } else {
      return ListTile(
          style: ListTileStyle.list,
          onTap: onTap,
          tileColor: _loginController.colorFromHex(_loginController.listCore
              .where((coreItem) => coreItem.coreChave == 'backLight')
              .first
              .coreValor
              .toString()),
          minLeadingWidth: (Get.width * 0.3) * 0.01,
          title: Text(
            text,
            style: TextStyle(
              fontSize: 16, //fontWeight: FontWeight.bold,
              // height: 0.1,
              // fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: _loginController.colorFromHex(_loginController.listCore
                  .where((coreItem) => coreItem.coreChave == 'textDark')
                  .first
                  .coreValor
                  .toString()),
            ),
          ),
          leading: Badge(
              badgeContent: Text('3'),
              child: Icon(
                icon,
                color: _loginController.colorFromHex(_loginController.listCore
                    .where((coreItem) => coreItem.coreChave == 'textDark')
                    .first
                    .coreValor
                    .toString()),
                size: 20,
              )));
    }
  }
}
