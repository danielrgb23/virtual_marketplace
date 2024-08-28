import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_marketplace/common/custom_drawer/custom_drawer.dart';
import 'package:virtual_marketplace/models/page_manager.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen({super.key});

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) => PageManager(pageController),
        child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            Scaffold(
              drawer: CustomDrawer(),
              appBar: AppBar(
                title: const Text('Home'),
              ),
            ),
            Scaffold(
              drawer: CustomDrawer(),
              appBar: AppBar(
                title: const Text('Home2'),
              ),
            ),
            Scaffold(
              drawer: CustomDrawer(),
              appBar: AppBar(
                title: const Text('Home3'),
              ),
            ),
            Scaffold(
              drawer: CustomDrawer(),
              appBar: AppBar(
                title: const Text('Home4'),
              ),
            ),
          ],
        ));
  }
}
