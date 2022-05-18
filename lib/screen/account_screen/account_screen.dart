import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/screen/account_screen/account_screen_body.dart';
import 'package:sainee_detailing/viewmodels/account_viewmodel.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AccountViewModel accountViewModel =
        Provider.of<AccountViewModel>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: AccountScreenBody(accountViewModel: accountViewModel),
      ),
    );
  }
}
