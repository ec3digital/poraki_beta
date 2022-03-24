import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../show_day_offer_controller.dart';
import '../../../../theme/app_theme.dart';

class BottomSheetProductDayOffer extends StatelessWidget {
  const BottomSheetProductDayOffer(
    this._controller, {
    Key? key,
  }) : super(key: key);

  final ShowDayOfferController _controller;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        borderSide: BorderSide.none,
      ),
      builder: (BuildContext bc) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: AutoSizeText(
                    'Escolha quantidade',
                    style: Get.textTheme.bodyText1!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              GetBuilder<ShowDayOfferController>(builder: (_) {
                return Visibility(
                  visible: !_controller.changeBottomSheet,
                  child: Column(
                    children: [
                      Container(
                        height: 1,
                        color: AppColors.containerLightColor,
                      ),
                      ColumnOptionsAmount(
                        text: '1 unidade',
                        onTap: () => _controller.changeAmount(1),
                      ),
                      ColumnOptionsAmount(
                        text: '2 unidades',
                        onTap: () => _controller.changeAmount(2),
                      ),
                      ColumnOptionsAmount(
                        text: '3 unidades',
                        onTap: () => _controller.changeAmount(3),
                      ),
                      ColumnOptionsAmount(
                        text: '4 unidades',
                        onTap: () => _controller.changeAmount(4),
                      ),
                      ColumnOptionsAmount(
                        text: '5 unidades',
                        onTap: () => _controller.changeAmount(5),
                      ),
                      ColumnOptionsAmount(
                        text: '6 unidades',
                        onTap: () => _controller.changeAmount(6),
                      ),
                      ColumnOptionsAmount(
                        text: 'mais de 6 unidades',
                        onTap: _controller.bottomSheetSixMore,
                      ),
                    ],
                  ),
                );
              }),
              GetBuilder<ShowDayOfferController>(builder: (_) {
                return Visibility(
                  visible: _controller.changeBottomSheet,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: _controller.amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(hintText: 'Digite a quantidade'),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        width: Get.width,
                        child: ElevatedButton(
                          onPressed: _controller.multipleAmounts,
                          child: Text(
                            'Aplicar',
                            style: Get.textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              })
            ],
          ),
        );
      },
      onClosing: () {},
    );
  }
}

class ColumnOptionsAmount extends StatelessWidget {
  final String text;
  final Function() onTap;

  ColumnOptionsAmount({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: AutoSizeText(
              text,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey[200],
          )
          //Divider(thickness: 1),
        ],
      ),
    );
  }
}
