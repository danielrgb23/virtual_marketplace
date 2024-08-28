import 'package:flutter/material.dart';
import 'package:virtual_marketplace/common/custom_drawer/custom_drawer.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen({super.key});

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          drawer: CustomDrawer(),
          appBar: AppBar(
            title: const Text('Home'),
          ),
        ),
        Container(
          color: Colors.red,
        ),
        Container(
          color: Colors.yellow,
        ),
        Container(
          color: Colors.green,
        )
      ],
    );
  }
}
