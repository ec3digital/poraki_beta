import 'package:flutter/material.dart';

import 'home_widgets/home_appbar.dart';
import 'home_widgets/home_body.dart';
import 'home_widgets/home_drawer.dart';
import 'home_widgets/home_fab.dart';

class HomePageOld extends StatelessWidget {
  HomePageOld({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getHomeAppBar(),
      drawer: getHomeDrawer(),
      floatingActionButton: getHomeFab(),
      body: HomeBody(),
    );
  }
}
