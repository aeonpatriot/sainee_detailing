import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/screen/dashboard_screen/dashboard_screen_bottomnav.dart';
import 'package:sainee_detailing/viewmodels/dashboard_viewmodel.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (context) => const DashboardScreen());

  @override
  Widget build(BuildContext context) {
    final DashboardViewModel dashboardViewModel =
        Provider.of<DashboardViewModel>(context);

    return Scaffold(
      backgroundColor: kColorOffWhite,
      // appBar: (dashboardViewModel.currentIndex != 0)
      //     ? null
      //     : AppBar(
      //         shadowColor: kSecondaryColorDark.withOpacity(0.2),
      //         elevation: 0,
      //         titleTextStyle:
      //             const TextStyle(color: Colors.white, fontSize: 20),
      //         automaticallyImplyLeading: false,
      //         iconTheme: const IconThemeData(color: Colors.black),
      //         flexibleSpace: Container(
      //           decoration: const BoxDecoration(
      //             gradient: LinearGradient(
      //                 begin: Alignment.bottomRight,
      //                 end: Alignment.bottomLeft,
      //                 colors: <Color>[kPrimaryColor, kPrimaryColorDark]),
      //           ),
      //         ),
      //         backgroundColor: kPrimaryColor,
      //         title: Text(
      //           'Dashboard',
      //           style: Theme.of(context)
      //               .textTheme
      //               .headline6
      //               ?.copyWith(color: kColorWhite),
      //         ),
      //       ),
      body: IndexedStack(
        index: dashboardViewModel.currentIndex,
        children: dashboardViewModel.staffScreenList,
      ),
      bottomNavigationBar: const DashboardBottomNav(),
    );
  }
}
