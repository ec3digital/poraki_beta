import 'package:flutter/material.dart';

class GradientHeaderHome extends StatelessWidget {
  final Widget child;
  const GradientHeaderHome({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.brown,
            Colors.amberAccent,
            Color(0xff8700),
            Color(0xffafafa),
            Color(0xffafafa),
            Color(0xffafafa),
          ],
        ),
      ),
      child: child,
    );
  }
}
