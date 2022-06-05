import 'package:flutter/Material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/screen/profile_screen/custom_profile_container.dart';
import 'package:sainee_detailing/viewmodels/image_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/login_viewmodel.dart';
import 'package:sainee_detailing/widget/custom_placeholder_image.dart';

class ProfileScreenBody extends StatelessWidget {
  final Icon rightArrowIcon = const Icon(Icons.keyboard_arrow_right);

  const ProfileScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginViewModel loginViewModel = Provider.of<LoginViewModel>(context);
    ImageViewModel imageViewModel = Provider.of<ImageViewModel>(context);
    // ProfileViewModel profileViewModel =
    //     Provider.of<ProfileViewModel>(context, listen: false);

    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                imageViewModel.headerImagePicker();
              },
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                height: 250,
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    FutureBuilder<void>(
                      future: imageViewModel.retrieveLostData(
                          imageType: 'headerImage'),
                      builder:
                          (BuildContext context, AsyncSnapshot<void> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const CustomPlaceholderImage();
                          case ConnectionState.done:
                            return imageViewModel.previewHeaderImage(
                                loginViewModel.userDetailsCopy.headerImagePath);
                          default:
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text(
                                    'Some error I guess from snapshot.haserror'),
                              );
                            } else {
                              return const CustomPlaceholderImage();
                            }
                        }
                        // height: 200,
                      },
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
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          imageViewModel.profileImagePicker();
                        },
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                          ),
                          child: FutureBuilder<void>(
                              future: imageViewModel.retrieveLostData(
                                  imageType: 'profileImage'),
                              builder: (BuildContext context,
                                  AsyncSnapshot<void> snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return const CustomPlaceholderImage(
                                        isCircle: true);
                                  case ConnectionState.done:
                                    return imageViewModel.previewProfileImage(
                                        loginViewModel
                                            .userDetailsCopy.profileImagePath);
                                  default:
                                    if (snapshot.hasError) {
                                      return const Center(
                                        child: Text(
                                            'Some error I guess from snapshot.haserror from profile'),
                                      );
                                    } else {
                                      return const CustomPlaceholderImage(
                                          isCircle: true);
                                    }
                                }
                              }),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 171,
                      right: 171,
                      bottom: 95,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        width: 25,
                        height: 15,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(100),
                                bottomRight: Radius.circular(100)),
                            color: Colors.black.withOpacity(0.4)),
                        child: Text('Edit',
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
