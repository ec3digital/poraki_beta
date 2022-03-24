import 'package:flutter/material.dart';
import '../../../../theme/app_theme.dart';

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
            AppColors.primaryBackground,
            AppColors.secondaryBackground
          ],
        ),
      ),
      child: child,
    );
  }
}
