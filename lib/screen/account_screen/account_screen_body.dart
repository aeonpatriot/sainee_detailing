import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/viewmodels/account_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/bookinglist_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/login_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/mainmenu_viewmodel.dart';
import 'package:sainee_detailing/widget/custom_cached_network_image.dart';
import 'package:sainee_detailing/widget/custom_placeholder_image.dart';

class AccountScreenBody extends StatelessWidget {
  const AccountScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainmenuViewModel mainmenuViewModel =
        Provider.of<MainmenuViewModel>(context, listen: false);
    final AccountViewModel accountViewModel =
        Provider.of<AccountViewModel>(context, listen: false);
    final LoginViewModel loginViewModel = Provider.of<LoginViewModel>(context);
    final BookingListViewModel bookingListViewModel =
        Provider.of<BookingListViewModel>(context, listen: false);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/profile');
          },
          child: Stack(
            children: [
              SizedBox(
                height: 280,
                width: double.infinity,
                child: loginViewModel.userDetailsCopy.headerImagePath != null
                    ? Hero(
                        tag: 'headerImage',
                        child: CustomCachedNetworkImage(
                          key: UniqueKey(),
                          imageUrl:
                              loginViewModel.userDetailsCopy.headerImagePath!,
                        ),
                      )
                    : const CustomPlaceholderImage(normalHeight: 280),
              ),
              Positioned(
                left: 20,
                bottom: 20,
                child: Container(
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    child:
                        loginViewModel.userDetailsCopy.profileImagePath != null
                            ? Hero(
                                tag: 'profileImage',
                                child: CustomCachedNetworkImage(
                                  key: UniqueKey(),
                                  imageUrl: loginViewModel
                                      .userDetailsCopy.profileImagePath!,
                                  isCircle: true,
                                ),
                              )
                            : const CustomPlaceholderImage(
                                isCircle: true,
                              )),
              ),
              Positioned(
                bottom: 35,
                left: 90,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.3)),
                  child: Text(
                    loginViewModel.userDetails.name,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: kColorWhite),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SizedBox(
            child: ListView.builder(
              itemCount: accountViewModel.items.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  onTap: () {
                    switch (index) {
                      case 0:
                        accountViewModel.onTapProfile(context);
                        break;
                      case 1:
                        accountViewModel.onTapAddress(context);
                        break;
                      case 2:
                        mainmenuViewModel.onTapBottomNav(2);
                        break;
                      case 3:
                        accountViewModel.onTapLogout(context);
                        mainmenuViewModel.currentIndex = 0;
                        bookingListViewModel.customerBookingTab = 0;
                        break;
                      default:
                    }
                  },
                  title: Text(
                    accountViewModel.items[index],
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  trailing: (index == 3)
                      ? const Icon(
                          Icons.logout,
                          color: Colors.redAccent,
                        )
                      : const Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
