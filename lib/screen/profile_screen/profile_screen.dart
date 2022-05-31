import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/screen/profile_screen/profile_screen_body.dart';
import 'package:sainee_detailing/viewmodels/login_viewmodel.dart';
import 'package:sainee_detailing/widget/confirm_discard_alert.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (context) => const ProfileScreen());

  @override
  Widget build(BuildContext context) {
    LoginViewModel loginViewModel = Provider.of<LoginViewModel>(context);

    return WillPopScope(
      onWillPop: () async {
        if (loginViewModel.isGenderSame) {
          Navigator.pop(context);
          loginViewModel.isGenderSame = true;
          return false;
        } else {
          ConfirmDiscardAlert.showAlertDialog(
              context: context,
              onDiscardPressed: () {
                loginViewModel.onProfileDiscard(context);
                Navigator.pop(context);
                Navigator.pop(context);
                loginViewModel.isGenderSame = true;
              });
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 250, 250, 250),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: loginViewModel.isGenderSame
                    ? null
                    : () {
                        loginViewModel.onProfileSave(context);
                        loginViewModel.isGenderSame = true;
                      },
                icon: const Icon(Icons.done)),
          ],
          titleTextStyle: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: kColorWhite),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: kPrimaryColor,
          title: const Text('My Profile'),
          leading: IconButton(
              onPressed: () {
                loginViewModel.isGenderSame
                    ? Navigator.pop(context)
                    : ConfirmDiscardAlert.showAlertDialog(
                        context: context,
                        onDiscardPressed: () {
                          loginViewModel.onProfileDiscard(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          loginViewModel.isGenderSame = true;
                        });
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: ProfileScreenBody(),
      ),
    );
  }
}
