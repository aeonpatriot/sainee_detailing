import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/viewmodels/mainmenu_viewmodel.dart';
import 'package:sainee_detailing/widget/custom_carousel_slider.dart';

class MainMenuScreenBody extends StatelessWidget {
  const MainMenuScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainmenuViewModel mainmenuViewModel =
        Provider.of<MainmenuViewModel>(context);

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
                    CustomIconMenu(
                        label: 'Services',
                        onTap: () {
                          Navigator.of(context).pushNamed('/services');
                        },
                        imageUrl: 'assets/icons/icons8-car-cleaning-48.png'),
                    CustomIconMenu(
                        label: 'My Car',
                        onTap: () {
                          print('My Car');
                        },
                        imageUrl: 'assets/icons/icons8-car-theft-48.png'),
                    CustomIconMenu(
                        label: 'My Address',
                        onTap: () {
                          print('My Address');
                        },
                        imageUrl: 'assets/icons/icons8-address-64.png'),
                    CustomIconMenu(
                        label: 'My Booking',
                        onTap: () {
                          print('My Booking');
                        },
                        imageUrl: 'assets/icons/icons8-booking-64.png'),
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

class CustomIconMenu extends StatelessWidget {
  const CustomIconMenu({
    Key? key,
    this.onTap,
    required this.imageUrl,
    required this.label,
  }) : super(key: key);

  final void Function()? onTap;
  final String imageUrl;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: kSecondaryColorDark.withOpacity(0.1), //shadow
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 2))
                ],
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(image: AssetImage(imageUrl))),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
