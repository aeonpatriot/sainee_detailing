import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/screen/main_menu_screen/main_menu_screen_body.dart';
import 'package:sainee_detailing/screen/main_menu_screen/main_menu_bottomnav.dart';
import 'package:sainee_detailing/viewmodels/mainmenu_viewmodel.dart';

class MainMenuScreen extends StatelessWidget {
  static Route route() =>
      MaterialPageRoute(builder: (context) => MainMenuScreen());

  @override
  Widget build(BuildContext context) {
    final MainmenuViewModel mainmenuViewModel =
        Provider.of<MainmenuViewModel>(context);

    return Scaffold(
      appBar: (mainmenuViewModel.currentIndex != 0)
          ? null
          : AppBar(
              titleTextStyle:
                  const TextStyle(color: Colors.white, fontSize: 20),
              automaticallyImplyLeading: false,
              iconTheme: const IconThemeData(color: Colors.black),
              backgroundColor: kPrimaryColorDark,
              title: const Text('Home'),
            ),
      body: IndexedStack(
        index: mainmenuViewModel.currentIndex,
        children: mainmenuViewModel.screen,
      ),
      bottomNavigationBar: Consumer<MainmenuViewModel>(
        builder: (context, notifier, child) => MainmenuBottomNav(
          mainmenuViewModel: notifier,
        ),
      ),
    );
  }
}
