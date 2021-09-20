import 'package:flutter/material.dart';
import '../../../../theme/custom_colors.dart';

class GradientTopLogin extends StatelessWidget {
  final Widget child;
  GradientTopLogin({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
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
      child: child,
    );
  }
}
