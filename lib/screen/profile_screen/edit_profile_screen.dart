import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/validation/registration_validation.dart';
import 'package:sainee_detailing/viewmodels/login_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/profile_viewmodel.dart';
import 'package:sainee_detailing/widget/custom_alert_dialog_widget/confirm_discard_alert.dart';
import 'package:sainee_detailing/widget/custom_full_width_text_field.dart';
import 'package:sainee_detailing/screen/address_screen/full_width_phone_field.dart';

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
    final RegistrationValidation registrationValidation =
        Provider.of<RegistrationValidation>(context);

    final bool isEditName = _editType == 'name' ? true : false;
    final bool isEditEmail = _editType == 'email' ? true : false;
    final bool isEditPhone = _editType == 'phone' ? true : false;

    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        if (loginViewModel.isProfileSame) {
          Future.delayed(const Duration(milliseconds: 100), () {
            Navigator.pop(context);
          });
          loginViewModel.isProfileSame = true;
          registrationValidation.resetValidationItem();
          return false;
        } else {
          ConfirmDiscardAlert.showAlertDialog(
              context: context,
              onDiscardPressed: () {
                registrationValidation.resetValidationItem();
                loginViewModel.onEditProfileDiscard();
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
                  registrationValidation.resetValidationItem();
                } else {
                  ConfirmDiscardAlert.showAlertDialog(
                      context: context,
                      onDiscardPressed: () {
                        loginViewModel.onEditProfileDiscard();
                        registrationValidation.resetValidationItem();
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
          isEditName
              ? CustomFullWidthTextField(
                  isAutoFocus: true,
                  errorText: registrationValidation.name.error,
                  labelText: 'Name',
                  onChanged: (value) {
                    setnewProfile(value, loginViewModel, _editType);
                    loginViewModel.checkProfile(_editType);
                    registrationValidation.setName(value);
                  },
                  isEdit: true,
                  editext: getInitialProfile(_editType, loginViewModel),
                )
              : isEditEmail
                  ? CustomFullWidthTextField(
                      isAutoFocus: true,
                      errorText: registrationValidation.email.error,
                      labelText: 'Email',
                      onChanged: (value) {
                        setnewProfile(value, loginViewModel, _editType);
                        loginViewModel.checkProfile(_editType);
                        registrationValidation.setEmail(value);
                      },
                      isEdit: true,
                      editext: getInitialProfile(_editType, loginViewModel),
                    )
                  : CustomFullWidthIntlPhoneField(
                      editNumber: getInitialProfile(_editType, loginViewModel),
                      validator: (phoneNumber) {
                        if (phoneNumber != null &&
                            (phoneNumber.number.length < 9 ||
                                phoneNumber.number.length > 10)) {
                          profileViewModel.phoneNumber =
                              phoneNumber.completeNumber;
                          profileViewModel.setIsPhoneNumberValid(false);
                          return 'Enter valid phone number';
                        } else {
                          profileViewModel.setIsPhoneNumberValid(true);
                          return null;
                        }
                      },
                      onChanged: (phoneNumber) {
                        print(phoneNumber.completeNumber);
                        profileViewModel.phoneNumber =
                            phoneNumber.completeNumber;
                        setnewProfile(phoneNumber.completeNumber,
                            loginViewModel, _editType);
                        loginViewModel.checkProfile(_editType);
                      },
                    ),
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
