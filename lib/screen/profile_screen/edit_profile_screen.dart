import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/viewmodels/login_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/profile_viewmodel.dart';
import 'package:sainee_detailing/widget/confirm_discard_alert.dart';

class EditProfileScreen extends StatelessWidget {
  final String _editType;

  const EditProfileScreen({Key? key, editType})
      : _editType = editType,
        super(key: key);

  static Route route({editType}) => MaterialPageRoute(
      builder: (context) => EditProfileScreen(editType: editType));

  @override
  Widget build(BuildContext context) {
    final ProfileViewModel profileViewModel =
        Provider.of<ProfileViewModel>(context, listen: false);
    final LoginViewModel loginViewModel =
        Provider.of<LoginViewModel>(context, listen: false);

    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        if (loginViewModel.isProfileSame) {
          Future.delayed(const Duration(milliseconds: 100), () {
            Navigator.pop(context);
          });
          loginViewModel.isProfileSame = true;
          return false;
        } else {
          ConfirmDiscardAlert.showAlertDialog(
              context: context,
              onDiscardPressed: () {
                loginViewModel.onEditProfileDiscard(context);
                Navigator.pop(context);
                Navigator.pop(context);
                loginViewModel.isProfileSame = true;
              });
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: kColorOffWhite,
        appBar: AppBar(
          shadowColor: kSecondaryColorDark.withOpacity(0.2),
          elevation: 2,
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
          iconTheme: const IconThemeData(color: kPrimaryColorDarker),
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                if (loginViewModel.isProfileSame) {
                  Future.delayed(const Duration(milliseconds: 100), () {
                    Navigator.pop(context);
                  });
                  loginViewModel.isProfileSame = true;
                } else {
                  ConfirmDiscardAlert.showAlertDialog(
                      context: context,
                      onDiscardPressed: () {
                        loginViewModel.onEditProfileDiscard(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        loginViewModel.isProfileSame = true;
                      });
                }
              },
              icon: const Icon(Icons.arrow_back)),
          actions: <Widget>[
            Consumer<LoginViewModel>(
                builder: (context, notifier, child) => TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 17),
                      primary: kPrimaryColorDarker,
                    ),
                    onPressed: loginViewModel.isProfileSame
                        ? null
                        : () {
                            FocusScope.of(context).unfocus();
                            Future.delayed(const Duration(milliseconds: 200),
                                () {
                              loginViewModel.onEditProfileScreenSave(context);
                            });
                            loginViewModel.isProfileSame = true;
                          },
                    child: Text(
                      'Save'.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .button
                          ?.copyWith(color: kPrimaryColorDarker),
                    )))
          ],
          actionsIconTheme: const IconThemeData(color: kPrimaryColorDarker),
          title: Text(
            getAppBarTitle(_editType, profileViewModel) ?? '',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        body: Column(children: [
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: TextEditingController(
                text: getInitialProfile(_editType, loginViewModel)),
            autofocus: true,
            onChanged: (value) {
              setnewProfile(value, loginViewModel, _editType);
              loginViewModel.checkProfile(_editType);
            },
            style: Theme.of(context).textTheme.bodyText1,
            decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                focusColor: Colors.transparent,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 17, horizontal: 15),
                filled: true,
                fillColor: Colors.white,
                // errorText: '_errorText',
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 100, color: Colors.red),
                )),
          )
        ]),
      ),
    );
  }

  String? getAppBarTitle(String editType, ProfileViewModel profileViewModel) {
    if (editType == 'name') {
      return profileViewModel.editList['name']!.appBarTitle;
    } else if (editType == 'email') {
      return profileViewModel.editList['email']!.appBarTitle;
    } else if (editType == 'phone') {
      return profileViewModel.editList['phone']!.appBarTitle;
    }
    return null;
  }

  String getInitialProfile(String editType, LoginViewModel loginViewModel) {
    if (editType == 'name') {
      return loginViewModel.userDetailsCopy.name;
    } else if (editType == 'email') {
      return loginViewModel.userDetailsCopy.email;
    } else if (editType == 'phone') {
      return loginViewModel.userDetailsCopy.phoneNumber;
    }
    return '';
  }

  void setnewProfile(
      String value, LoginViewModel loginViewModel, String editType) {
    if (editType == 'name') {
      loginViewModel.userDetailsCopy.name = value;
    } else if (editType == 'email') {
      loginViewModel.userDetailsCopy.email = value;
    } else if (editType == 'phone') {
      loginViewModel.userDetailsCopy.phoneNumber = value;
    }
  }
}
