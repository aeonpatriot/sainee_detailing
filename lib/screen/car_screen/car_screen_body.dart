import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/models/car.dart';
import 'package:sainee_detailing/validation/car_validation.dart';
import 'package:sainee_detailing/viewmodels/car_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/login_viewmodel.dart';
import 'package:sainee_detailing/widget/custom_card_list.dart';
import 'package:sainee_detailing/widget/custom_placeholder_empty_list.dart';

class CarScreenBody extends StatelessWidget {
  const CarScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginViewModel loginViewModel =
        Provider.of<LoginViewModel>(context, listen: false);
    CarViewModel carViewModel = Provider.of<CarViewModel>(context);
    CarValidation carValidation =
        Provider.of<CarValidation>(context, listen: false);

    return FutureBuilder(
      future: carViewModel.getUserCars(loginViewModel.userDetails.id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
                child: CircularProgressIndicator(color: kSecondaryColorDark));
          case ConnectionState.done:
          default:
            if (snapshot.hasError) {
              final error = snapshot.error;
              return Center(child: Text('Error: $error'));
            } else if (snapshot.hasData) {
              print('from car body list');
              List<Car> data = snapshot.data as List<Car>;
              if (data.isEmpty) {
                return const CustomPlaceholderEmptyList(
                  firstText: 'Its empty here...',
                  secondText: 'Add new address now.',
                  thirdText: 'Click the ADD + button at the top.',
                );
              }
              return ListView.builder(
                  padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    Car car = data[index];
                    return CustomCardList(
                      onTap: () async {
                        carValidation.setValidationItemEdit(car: car);
                        await carViewModel.setCarForEdit(car);
                        Navigator.of(context).pushNamed('/editCar');
                      },
                      hasImage: true,
                      imageName: car.carImageName,
                      imageUrl: car.carImagePath,
                      isDefault: car.defaultCar!,
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
