import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';

class NumericStepButton extends StatefulWidget {
  final int minValue;
  final int maxValue;
  late int num;

  final ValueChanged<int> onChanged;

  NumericStepButton(
      {Key? key, this.minValue = 0, this.maxValue = 10, this.num = 0, required this.onChanged})
      : super(key: key);

  @override
  State<NumericStepButton> createState() {
    return _NumericStepButtonState();
  }
}

class _NumericStepButtonState extends State<NumericStepButton> {
  LoginController _loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(
              Icons.remove,
              color: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backDark').first.coreValor.toString()),
            ),
            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
            iconSize: 32.0,
            color: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backDark').first.coreValor.toString()),
            onPressed: () {
              setState(() {
                if (widget.num > widget.minValue) {
                  widget.num--;
                }
                widget.onChanged(widget.num);
              });
            },
          ),
          Text(
            '${widget.num}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backDark').first.coreValor.toString()),
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              color: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backDark').first.coreValor.toString()),
            ),
            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
            iconSize: 32.0,
            color: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backDark').first.coreValor.toString()),
            onPressed: () {
              setState(() {
                if (widget.num < widget.maxValue) {
                  widget.num++;
                }
                widget.onChanged(widget.num);
              });
            },
          ),
        ],
      ),
    );
  }
}