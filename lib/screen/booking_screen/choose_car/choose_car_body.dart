import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/models/car.dart';
import 'package:sainee_detailing/viewmodels/booking_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/car_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/login_viewmodel.dart';
import 'package:sainee_detailing/widget/custom_card_list.dart';
import 'package:sainee_detailing/widget/custom_placeholder_empty_list.dart';

class ChooseCarScreenBody extends StatelessWidget {
  const ChooseCarScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginViewModel loginViewModel =
        Provider.of<LoginViewModel>(context, listen: false);
    CarViewModel carViewModel = Provider.of<CarViewModel>(context);
    BookingViewModel bookingViewModel = Provider.of<BookingViewModel>(context);

    return FutureBuilder(
      future: carViewModel.getUserCars(loginViewModel.userDetails.id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
                child: SpinKitCubeGrid(
              color: kSecondaryColor,
              size: 50.0,
            ));
          case ConnectionState.done:
          default:
            if (snapshot.hasError) {
              final error = snapshot.error;
              return Center(child: Text('Error: $error'));
            } else if (snapshot.hasData) {
              List<Car> data = snapshot.data as List<Car>;
              if (data.isEmpty) {
                return const CustomPlaceholderEmptyList(
                  iconUrl: 'assets/icons/icons8-car-wash-64.png',
                  firstText: 'Its empty here...',
                  thirdText: 'Click the ADD + button at the top',
                );
              }
              return ListView.builder(
                  padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    Car car = data[index];
                    return CustomCardList(
                      onTap: () {
                        bookingViewModel.selectedCarIndex = index;
                        bookingViewModel.setChosenCar(car: car);
                        Navigator.of(context).pop();
                      },
                      hasImage: true,
                      imageName: car.carImageName,
                      imageUrl: car.carImagePath,
                      isDefault: 'N',
                      isSelected: bookingViewModel.selectedCarIndex == index,
                      textList: <Widget>[
                        CustomCardListText(
                            type: 'Car',
                            isDefault: car.defaultCar!,
                            isHeading: true,
                            text: car.model!),
                        const SizedBox(height: 10),
                        CustomCardListText(text: car.type!),
                        const SizedBox(height: 5),
                        CustomCardListText(text: car.plateNumber!),
                      ],
                    );
                  });
            } else {
              return const Center(
                  child: Text('Having some problem to load data'));
            }
        }
      },
    );
  }
}
