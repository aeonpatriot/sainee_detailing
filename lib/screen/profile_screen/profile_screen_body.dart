import 'package:flutter/Material.dart';
import 'package:provider/provider.dart';
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
            Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/images/placeholder-image-400x300.jpg',
                    fit: BoxFit.fill,
                    // height: 200,
                  ),
                )
              ],
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
