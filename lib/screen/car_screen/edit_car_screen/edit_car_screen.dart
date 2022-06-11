import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/screen/car_screen/edit_car_screen/edit_car_screen_body.dart';
import 'package:sainee_detailing/validation/car_validation.dart';
import 'package:sainee_detailing/viewmodels/car_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/image_viewmodel.dart';
import 'package:sainee_detailing/widget/confirm_delete_alert.dart';
import 'package:sainee_detailing/widget/confirm_discard_alert.dart';

class EditCarScreen extends StatelessWidget {
  const EditCarScreen({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (context) => const EditCarScreen());

  @override
  Widget build(BuildContext context) {
    CarViewModel carViewModel =
        Provider.of<CarViewModel>(context, listen: false);
    ImageViewModel imageViewModel =
        Provider.of<ImageViewModel>(context, listen: false);
    CarValidation carValidation =
        Provider.of<CarValidation>(context, listen: false);

    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        if (carViewModel.isCarDetailsChanged() || imageViewModel.isCarChanged) {
          ConfirmDiscardAlert.showAlertDialog(
              context: context,
              onDiscardPressed: () {
                FocusScope.of(context).unfocus();
                imageViewModel.resetImagePicker();
                carValidation.resetValidationItem();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              });
        } else {
          carValidation.resetValidationItem();
          Navigator.of(context).pop();
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: kColorOffWhite,
        appBar: AppBar(
          shadowColor: kSecondaryColorDark.withOpacity(0.2),
          elevation: 2,
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
          iconTheme: const IconThemeData(color: kPrimaryColorDarker),
          backgroundColor: Colors.white,
          title: Text(
            'Edit Address',
            style: Theme.of(context).textTheme.headline6,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                FocusScope.of(context).unfocus();
                ConfirmDeleteAlert.showAlertDialog(
                    context: context,
                    onDeletePressed: () {
                      FocusScope.of(context).unfocus();
                      carViewModel.deleteCar(
                          context: context,
                          carId: carViewModel.editingCarCopy.id!,
                          resetValidationItem:
                              carValidation.resetValidationItem);
                    });
              },
            )
          ],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              FocusScope.of(context).unfocus();
              if (carViewModel.isCarDetailsChanged() ||
                  imageViewModel.isCarChanged) {
                ConfirmDiscardAlert.showAlertDialog(
                    context: context,
                    onDiscardPressed: () {
                      FocusScope.of(context).unfocus();
                      imageViewModel.resetImagePicker();
                      carValidation.resetValidationItem();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    });
              } else {
                carValidation.resetValidationItem();
                Navigator.of(context).pop();
              }
            },
          ),
        ),
        body: const EditCarScreenBody(),
      ),
    );
  }
}
