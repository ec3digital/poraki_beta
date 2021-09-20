import 'package:flutter/material.dart';

class HeaderLogin extends StatelessWidget {
  const HeaderLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 7),
          child: Image.asset(
            "assets/icons/poraki250.png",
            height: 250,
          ),
        ),
        Text(
          "Entrar",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
