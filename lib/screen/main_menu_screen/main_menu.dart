import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/screen/main_menu_screen/main_menu_bottomnav.dart';
import 'package:sainee_detailing/viewmodels/mainmenu_viewmodel.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (context) => const MainMenuScreen());

  @override
  Widget build(BuildContext context) {
    final MainmenuViewModel mainmenuViewModel =
        Provider.of<MainmenuViewModel>(context);

    return Scaffold(
      backgroundColor: kColorOffWhite,
      appBar: (mainmenuViewModel.currentIndex != 0)
          ? null
          : AppBar(
              shadowColor: kSecondaryColorDark.withOpacity(0.2),
              elevation: 2,
              titleTextStyle:
                  const TextStyle(color: Colors.white, fontSize: 20),
              automaticallyImplyLeading: false,
              iconTheme: const IconThemeData(color: Colors.black),
              backgroundColor: kPrimaryColor,
              title: Text(
                'Home',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: kColorWhite),
              ),
            ),
      body: IndexedStack(
        index: mainmenuViewModel.currentIndex,
        children: mainmenuViewModel.screenList,
      ),
      bottomNavigationBar: Consumer<MainmenuViewModel>(
        builder: (context, notifier, child) => MainmenuBottomNav(
          mainmenuViewModel: notifier,
        ),
      ),
    );
  }
}
