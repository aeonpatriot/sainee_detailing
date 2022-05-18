import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/screen/profile_screen/profile_screen_body.dart';
import 'package:sainee_detailing/viewmodels/login_viewmodel.dart';
import 'package:sainee_detailing/widget/confirm_discard_alert.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (context) => ProfileScreen());

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
          ConfirmDiscardalert.showAlertDialog(
              context: context,
              loginViewModel: loginViewModel,
              isEditScreen: false);
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
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: kPrimaryColorDark,
          title: const Text('My Profile'),
          leading: IconButton(
              onPressed: () {
                loginViewModel.isGenderSame
                    ? Navigator.pop(context)
                    : ConfirmDiscardalert.showAlertDialog(
                        context: context,
                        loginViewModel: loginViewModel,
                        isEditScreen: false);
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: ProfileScreenBody(),
      ),
    );
  }
}
