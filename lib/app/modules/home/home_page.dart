import 'package:flutter/material.dart';
import 'package:poraki/app/modules/home/home_widgets/body_home.dart';

class HomePage extends StatelessWidget {
  // final HomeController controller = Get.put(HomeController());
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyHome(),
    );
  }
}
