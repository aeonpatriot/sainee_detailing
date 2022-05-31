import 'package:flutter/Material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/screen/profile_screen/custom_profile_container.dart';
import 'package:sainee_detailing/viewmodels/login_viewmodel.dart';

class ProfileScreenBody extends StatelessWidget {
  final Icon rightArrowIcon = const Icon(Icons.keyboard_arrow_right);

  @override
  Widget build(BuildContext context) {
    LoginViewModel loginViewModel = Provider.of<LoginViewModel>(context);
    // ProfileViewModel profileViewModel =
    //     Provider.of<ProfileViewModel>(context, listen: false);

    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                print('test tap');
              },
              child: Container(
                color: Colors.red,
                width: double.infinity,
                height: 250,
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/placeholder-image-400x300.jpg',
                      fit: BoxFit.fitWidth,
                      width: double.infinity,
                      height: 250,
                      // height: 200,
                    ),
                    Positioned(
                      right: 0,
                      left: 0,
                      bottom: 0,
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 20,
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.4)),
                        child: Text('Tap to change',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(color: kColorWhite)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomProfileContainer(
              preText: 'Name',
              suffixText: '${loginViewModel.userDetailsCopy.name}',
              suffixIcon: rightArrowIcon,
              navigator: true,
              editType: 'name',
              onGoBack: loginViewModel.onGoBack,
              loginViewModel: loginViewModel,
            ),
            CustomProfileContainer(
              preText: 'Email',
              suffixText: '${loginViewModel.userDetailsCopy.email}',
              suffixIcon: rightArrowIcon,
              navigator: true,
              editType: 'email',
              onGoBack: loginViewModel.onGoBack,
              loginViewModel: loginViewModel,
            ),
            CustomProfileContainer(
              preText: 'Phone',
              suffixText: '${loginViewModel.userDetailsCopy.phoneNumber}',
              suffixIcon: rightArrowIcon,
              navigator: true,
              editType: 'phone',
              onGoBack: loginViewModel.onGoBack,
              loginViewModel: loginViewModel,
            ),
            CustomProfileContainer(
              preText: 'Gender',
              suffixText: loginViewModel.userDetailsCopy.gender == null
                  ? 'Not Set'
                  : '${loginViewModel.userDetailsCopy.gender}',
              suffixIcon: rightArrowIcon,
              navigator: false,
              loginViewModel: loginViewModel,
            ),
          ]),
    );
  }
}
