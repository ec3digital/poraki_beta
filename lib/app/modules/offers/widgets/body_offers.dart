import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'list_offers.dart';

class BodyOffers extends StatelessWidget {
  BodyOffers({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(height: 20),
    ListOffers(),
      ],
    );
  }
}
