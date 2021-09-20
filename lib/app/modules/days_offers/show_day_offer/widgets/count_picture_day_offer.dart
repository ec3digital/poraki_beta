import 'package:flutter/material.dart';

class CountPictureDayOffer extends StatelessWidget {

  final String countCurrent;
  final int countLenght;

  const CountPictureDayOffer({Key? key, required this.countCurrent, required this.countLenght}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(08),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.grey,
      ),
      child: Text('${countCurrent.toString()}/${countLenght.toString()}'),
    );
  }
}
