import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/screen/car_screen/add_car_screen/add_car_screen_body.dart';
import 'package:sainee_detailing/validation/car_validation.dart';
import 'package:sainee_detailing/viewmodels/image_viewmodel.dart';
import 'package:sainee_detailing/widget/confirm_discard_alert.dart';

class AddCarScreen extends StatelessWidget {
  const AddCarScreen({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (context) => const AddCarScreen());

  @override
  Widget build(BuildContext context) {
    CarValidation carValidation = Provider.of<CarValidation>(context);
    ImageViewModel imageViewModel = Provider.of<ImageViewModel>(context);

    return WillPopScope(
      onWillPop: () async {
        if (carValidation.isCarDetailsEmpty() && !imageViewModel.isCarChanged) {
          FocusScope.of(context).unfocus();
          Navigator.of(context).pop();
          carValidation.resetValidationItem();
        } else {
          FocusScope.of(context).unfocus();
          ConfirmDiscardAlert.showAlertDialog(
              context: context,
              onDiscardPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                imageViewModel.resetImagePicker();
                carValidation.resetValidationItem();
              });
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: kColorOffWhite,
        appBar: AppBar(
          shadowColor: kSecondaryColorDark.withOpacity(0.2),
          elevation: 2,
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: kColorWhite,
          title: Text(
            'Add Car',
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: kColorBlack),
          ),
          actions: const [],
          leading: IconButton(
              onPressed: () {
                if (carValidation.isCarDetailsEmpty() &&
                    !imageViewModel.isCarChanged) {
                  FocusScope.of(context).unfocus();
                  Navigator.of(context).pop();
                  carValidation.resetValidationItem();
                } else {
                  FocusScope.of(context).unfocus();
                  ConfirmDiscardAlert.showAlertDialog(
                      context: context,
                      onDiscardPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        imageViewModel.resetImagePicker();
                        carValidation.resetValidationItem();
                      });
                }
                // Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: kPrimaryColorDark,
              )),
        ),
        body: const AddCarScreenBody(),
      ),
    );
  }
}
