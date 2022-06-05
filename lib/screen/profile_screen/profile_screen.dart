import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/screen/profile_screen/profile_screen_body.dart';
import 'package:sainee_detailing/viewmodels/image_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/login_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/profile_viewmodel.dart';
import 'package:sainee_detailing/widget/confirm_discard_alert.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (context) => const ProfileScreen());

  @override
  Widget build(BuildContext context) {
    LoginViewModel loginViewModel = Provider.of<LoginViewModel>(context);
    ImageViewModel imageViewModel = Provider.of<ImageViewModel>(context);
    ProfileViewModel profileViewModel =
        Provider.of<ProfileViewModel>(context, listen: false);

    return WillPopScope(
      onWillPop: () async {
        if (loginViewModel.isGenderSame &&
            (!imageViewModel.isHeaderChanged &&
                !imageViewModel.isProfileChanged)) {
          Navigator.pop(context);
          return false;
        } else {
          ConfirmDiscardAlert.showAlertDialog(
              context: context,
              onDiscardPressed: () {
                imageViewModel.resetImagePicker();
                loginViewModel.onProfileDiscard();
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
                onPressed: (loginViewModel.isGenderSame &&
                        (!imageViewModel.isHeaderChanged &&
                            !imageViewModel.isProfileChanged))
                    ? null
                    : () {
                        // if ((imageViewModel.isHeaderChanged ||
                        //     imageViewModel.isProfileChanged)) {
                        //   imageViewModel.onUpdateImage(
                        //       context: context,
                        //       userId: loginViewModel.userDetails.id,
                        //       setNewUserDetails: loginViewModel
                        //           .setUserDetailsAfterUpdateImage);
                        // }
                        // if (!loginViewModel.isGenderSame) {
                        loginViewModel.onProfileSave(
                            context: context,
                            headerTempFile: imageViewModel.headerTempFile,
                            profileTempFile: imageViewModel.profileTempFile,
                            userId: loginViewModel.userDetails.id,
                            clearCache: imageViewModel.clearCache);
                        loginViewModel.isGenderSame = true;
                        imageViewModel.resetImagePicker();
                        // }
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
                print(imageViewModel.isHeaderChanged);
                (loginViewModel.isGenderSame &&
                        (!imageViewModel.isHeaderChanged &&
                            !imageViewModel.isProfileChanged))
                    ? Navigator.pop(context)
                    : ConfirmDiscardAlert.showAlertDialog(
                        context: context,
                        onDiscardPressed: () {
                          imageViewModel.resetImagePicker();
                          loginViewModel.onProfileDiscard();
                          Navigator.pop(context);
                          Navigator.pop(context);
                          loginViewModel.isGenderSame = true;
                        });
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: const ProfileScreenBody(),
      ),
    );
  }
}
