import 'package:flutter/material.dart';
import 'package:poraki/app/theme/custom_colors.dart';

import 'home_list_item.dart';
import 'home_list_model.dart';


class HomeBody extends StatelessWidget {
  final List<HomeListModel> listMockedList = [
    HomeListModel(
      title: "Academia - O Club",
      assetIcon: "assets/images/dumbbell.png",
    ),
    HomeListModel(
      title: "Biometa Academia",
      assetIcon: "assets/images/dumbbell.png",
    ),
    HomeListModel(
      title: "Academia Titanium Core",
      assetIcon: "assets/images/dumbbell.png",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            CustomColors().getGradientMainColor(),
            CustomColors().getGradientSecondaryColor(),
          ],
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 40,
        horizontal: 20,
      ),
      child: ListView.builder(
        itemCount: listMockedList.length,
        itemBuilder: (context, index) {
          return HomeListItem(
            homeListModel: listMockedList[index],
          );
        },
      ),
    );
  }
}
