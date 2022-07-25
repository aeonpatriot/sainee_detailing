import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/viewmodels/booking_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/bookinglist_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/login_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/mainmenu_viewmodel.dart';
import 'package:sainee_detailing/widget/custom_carousel_slider.dart';
import 'package:sainee_detailing/widget/custom_icon.dart';

class MainMenuScreenBody extends StatelessWidget {
  const MainMenuScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainmenuViewModel mainmenuViewModel =
        Provider.of<MainmenuViewModel>(context);
    final BookingViewModel bookingViewModel =
        Provider.of<BookingViewModel>(context, listen: false);
    final BookingListViewModel bookingListViewModel =
        Provider.of<BookingListViewModel>(context, listen: false);
    final LoginViewModel loginViewModel =
        Provider.of<LoginViewModel>(context, listen: false);

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Latest Promotion',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 15),
                CustomCarouselSlider(
                    imageList: mainmenuViewModel.imageList,
                    activeIndex: mainmenuViewModel.topImageCurrentIndex,
                    onPageChanged: (index, reason) {
                      mainmenuViewModel.topImageCurrentIndex = index;
                    }),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            // decoration: BoxDecoration(
            //     border: Border.all(color: kSecondaryColorDark, width: 5)),
            child: Column(children: [
              Container(
                color: kColorWhite,
                padding: const EdgeInsets.only(top: 10),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomIcon(
                      label: 'Services',
                      onTap: () {
                        Navigator.of(context).pushNamed('/services');
                        bookingViewModel
                            .getUserAddresses(loginViewModel.userDetails.id);
                        bookingViewModel
                            .getUserCars(loginViewModel.userDetails.id);
                      },
                      imageUrl: 'assets/icons/icons8-car-cleaning-48.png',
                      circleIcon: true,
                    ),
                    CustomIcon(
                      label: 'My Car',
                      onTap: () {
                        mainmenuViewModel.onTapBottomNav(2);
                      },
                      imageUrl: 'assets/icons/icons8-car-theft-48.png',
                      circleIcon: true,
                    ),
                    CustomIcon(
                      label: 'My Address',
                      onTap: () {
                        Navigator.of(context).pushNamed('/address');
                      },
                      imageUrl: 'assets/icons/icons8-address-64.png',
                      circleIcon: true,
                    ),
                    CustomIcon(
                      label: 'My Booking',
                      onTap: () {
                        bookingListViewModel.setFutureCustomerBookingList(
                            loginViewModel.userDetails.id);
                        mainmenuViewModel.onTapBottomNav(1);
                      },
                      imageUrl: 'assets/icons/icons8-booking-64.png',
                      circleIcon: true,
                    ),
                  ],
                ),
                // decoration: BoxDecoration(
                //     border: Border.all(color: kTertiaryColorDark, width: 5)),
              ),
            ]),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Our Gears',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 15),
                CustomCarouselSlider(
                    // width: 50,
                    height: 270,
                    isGear: true,
                    imageList: mainmenuViewModel.gearImageList,
                    activeIndex: mainmenuViewModel.bottomImageCurrentIndex,
                    onPageChanged: (index, reason) {
                      mainmenuViewModel.bottomImageCurrentIndex = index;
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
