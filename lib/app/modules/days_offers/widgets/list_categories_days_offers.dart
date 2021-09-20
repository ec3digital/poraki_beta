import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../theme/custom_colors.dart';
import '../days_offers_controller.dart';

class ListCategoriesDaysOffers extends StatelessWidget {
  final DaysOffersController controller;
  ListCategoriesDaysOffers({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.categories.length,
        itemBuilder: (BuildContext context, int index) {
          String _category = controller.categories[index];
          return InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(top: 10, left: 1, right: 1),
              decoration: BoxDecoration(
                color: CustomColors().getGradientMainColor(),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              width: 120,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FontAwesomeIcons.bookmark, size: 30),
                    const SizedBox(height: 5),
                    AutoSizeText(
                      _category,
                      style: Get.textTheme.headline1!.copyWith(fontSize: 14),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}