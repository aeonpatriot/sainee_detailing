import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/validation/car_validation.dart';
import 'package:sainee_detailing/viewmodels/car_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/image_viewmodel.dart';
import 'package:sainee_detailing/widget/custom_dropdown_field.dart';
import 'package:sainee_detailing/widget/custom_full_width_text_field.dart';
import 'package:sainee_detailing/widget/custom_labeled_switch.dart';
import 'package:sainee_detailing/widget/custom_placeholder_image.dart';

class EditCarScreenBody extends StatelessWidget {
  const EditCarScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // LoginViewModel loginViewModel =
    //     Provider.of<LoginViewModel>(context, listen: false);
    ImageViewModel imageViewModel = Provider.of<ImageViewModel>(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              imageViewModel.carImagePicker();
            },
            child: Consumer<CarViewModel>(builder: (_, carNotifier, __) {
              return Container(
                color: Colors.transparent,
                width: double.infinity,
                height: 250,
                alignment: Alignment.center,
                child: Stack(children: [
                  FutureBuilder<void>(
                    future:
                        imageViewModel.retrieveLostData(imageType: 'carImage'),
                    builder:
                        (BuildContext context, AsyncSnapshot<void> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const CustomPlaceholderImage();
                        case ConnectionState.done:
                          return imageViewModel.previewCarImage(
                              carNotifier.editingCar.carImagePath,
                              carNotifier.editingCar.carImageName);
                        default:
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text(
                                  'Having some problem retrieveing your image'),
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
                ]),
              );
            }),
          ),
          const CustomTextDivider(title: 'Car Details'),
          Consumer2<CarViewModel, CarValidation>(
            builder: (_, carNotifier, validationNotifier, __) =>
                CustomFullWidthTextField(
              errorText: validationNotifier.model.error,
              labelText: 'Model',
              onChanged: (model) {
                validationNotifier.setModel(model);
                carNotifier.editingCarCopy.model = model;
              },
              isEdit: true,
              editext: carNotifier.editingCarCopy.model,
            ),
          ),
          Consumer2<CarViewModel, CarValidation>(
            builder: (_, carNotifier, validationNotifier, __) =>
                CustomFullWidthTextField(
              isNumber: false,
              errorText: validationNotifier.brand.error,
              labelText: 'Brand',
              onChanged: (brand) {
                validationNotifier.setBrand(brand);
                carNotifier.editingCarCopy.brand = brand;
              },
              isEdit: true,
              editext: carNotifier.editingCarCopy.brand,
            ),
          ),
          Consumer2<CarViewModel, CarValidation>(
            builder: (_, carNotifier, validationNotifier, __) =>
                CustomFullWidthTextField(
              isNumber: false,
              errorText: validationNotifier.plateNumber.error,
              labelText: 'Plate Number',
              onChanged: (plateNumber) {
                validationNotifier.setPlateNumber(plateNumber);
                carNotifier.editingCarCopy.plateNumber = plateNumber;
              },
              isEdit: true,
              editext: carNotifier.editingCarCopy.plateNumber,
            ),
          ),
          Consumer2<CarViewModel, CarValidation>(
            builder: (_, carNotifier, validationNotifier, __) =>
                CustomFullWidthTextField(
              isNumber: false,
              errorText: validationNotifier.description.error,
              labelText: 'Description',
              onChanged: (description) {
                validationNotifier.setDescription(description);
                carNotifier.editingCarCopy.description = description;
              },
              isEdit: true,
              editext: carNotifier.editingCarCopy.description,
              maxLine: 3,
            ),
          ),
          const SizedBox(height: 10),
          const CustomTextDivider(title: 'Car Type'),
          //TODO bug updating type only
          Consumer2<CarViewModel, CarValidation>(
              builder: (_, carNotifier, validationNotifier, __) =>
                  CustomDropdownField(
                    value: validationNotifier.type.value,
                    items: const [
                      'Small',
                      'Medium',
                      'Large',
                      'MPV',
                      'SUV',
                    ],
                    onChanged: (value) {
                      validationNotifier.setType(value);
                    },
                  )),
          const SizedBox(height: 10),
          const CustomTextDivider(title: 'Settings'),
          Consumer2<CarViewModel, CarValidation>(
              builder: (_, carNotifier, validationNotifier, __) =>
                  LabeledSwitch(
                    label: 'Set Default Car?',
                    value: validationNotifier.defaultCarToggled,
                    onChanged: (bool value) {
                      validationNotifier.setDefaultCarToggled(value);
                      if (value) {
                        carNotifier.editingCarCopy.defaultCar = 'Y';
                      } else {
                        carNotifier.editingCarCopy.defaultCar = 'N';
                      }
                    },
                    isEdit: true,
                    defaultValue: carNotifier.editingCarCopy.defaultCar,
                    originalDefaultValue: carNotifier.editingCar.defaultCar,
                  )),
          const SizedBox(height: 40),
          Container(
            color: Colors.transparent,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Consumer2<CarValidation, CarViewModel>(
              builder: (_, validationNotifier, carNotifier, __) =>
                  ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: kPrimaryColorDarker,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 10.0,
                    ),
                    minimumSize: const Size(310.0, 35.0),
                    textStyle: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    )),
                onPressed: () {
                  carNotifier.updateCarDetails(
                      resetImage: imageViewModel.resetImagePicker,
                      clearCache: imageViewModel.clearCache,
                      context: context,
                      imageFile: imageViewModel.carTempFile,
                      resetValidationItem:
                          validationNotifier.resetValidationItem);
                },
                // (validationNotifier.isCarDetailsValid() ||
                //         imageViewModel.isCarChanged)
                //     ? () {
                //         FocusScope.of(context).unfocus();
                //         carNotifier.submitCarDetails(
                //             imageFile: imageViewModel.carTempFile,
                //             context: context,
                //             newCar: validationNotifier
                //                 .getValidatedCar(loginViewModel.userDetails.id),
                //             resetValidationItem:
                //                 validationNotifier.resetValidationItem);
                //       }
                //     : null,
                child: carNotifier.isSubmitted
                    ? SizedBox(
                        width: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Updating Your Car'.toUpperCase(),
                              style: Theme.of(context).textTheme.button,
                            ),
                            const SizedBox(width: 10),
                            const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                  color: kPrimaryColorDark,
                                  backgroundColor: kPrimaryColor),
                            ),
                          ],
                        ),
                      )
                    : Text(
                        'SUBMIT',
                        style: Theme.of(context).textTheme.button,
                      ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
