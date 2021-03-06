import 'package:flutter/material.dart';
import 'package:sainee_detailing/screen/account_screen/account_screen_body.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: AccountScreenBody(),
      ),
    );
  }
}
