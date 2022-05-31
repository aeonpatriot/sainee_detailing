import 'package:flutter/Material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/screen/address_screen/custom_widget.dart';
import 'package:sainee_detailing/screen/address_screen/full_width_phone_field.dart';
import 'package:sainee_detailing/validation/address_validation.dart';
import 'package:sainee_detailing/viewmodels/address_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/login_viewmodel.dart';

class AddAddressScreenBody extends StatelessWidget {
  const AddAddressScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const CustomTextDivider(title: 'Contact'),
          Consumer<AddressValidation>(
            builder: (_, notifier, __) => CustomFullWidthTextField(
              isPostcode: false,
              errorText: notifier.name.error,
              labelText: 'Full Name',
              onChanged: (name) {
                notifier.setName(name);
              },
            ),
          ),
          Consumer<AddressValidation>(
              builder: (_, notifier, __) => CustomFullWidthIntlPhoneField(
                    validator: (phoneNumber) {
                      if (phoneNumber != null &&
                          (phoneNumber.number.length < 9 ||
                              phoneNumber.number.length > 10)) {
                        notifier.phoneNumber = phoneNumber.completeNumber;
                        notifier.setIsPhoneNumberValid(false);
                        return 'Enter valid phone number';
                      } else {
                        notifier.setIsPhoneNumberValid(true);
                        return null;
                      }
                    },
                    onChanged: (phoneNumber) {
                      print(phoneNumber.completeNumber);
                      notifier.phoneNumber = phoneNumber.completeNumber;
                    },
                  )),
          const SizedBox(height: 10),
          const CustomTextDivider(title: 'Address'),
          Consumer<AddressValidation>(
            builder: (_, notifier, __) => CustomFullWidthTextField(
              isPostcode: false,
              errorText: notifier.state.error,
              labelText: 'State',
              onChanged: (state) {
                notifier.setState(state);
              },
            ),
          ),
          Consumer<AddressValidation>(
            builder: (_, notifier, __) => CustomFullWidthTextField(
              isPostcode: false,
              errorText: notifier.city.error,
              labelText: 'City',
              onChanged: (city) {
                notifier.setCity(city);
              },
            ),
          ),
          Consumer<AddressValidation>(
            builder: (_, notifier, __) => CustomFullWidthTextField(
              isPostcode: false,
              errorText: notifier.postcode.error,
              labelText: 'Postal Code',
              onChanged: (postcode) {
                notifier.setPostcode(postcode);
              },
            ),
          ),
          Consumer<AddressValidation>(
            builder: (_, notifier, __) => CustomFullWidthTextField(
              isPostcode: false,
              errorText: notifier.detailAddress.error,
              labelText: 'Detailed Address',
              onChanged: (detailAddress) {
                notifier.setDetailAddress(detailAddress);
              },
              maxLine: 3,
            ),
          ),
          const SizedBox(height: 10),
          const CustomTextDivider(title: 'Settings'),
          Consumer<AddressValidation>(
              builder: (_, notifier, __) => LabeledSwitch(
                    label: 'Set Default Address?',
                    value: notifier.defaultAddressToggled,
                    onChanged: (bool value) {
                      notifier.setDefaultAddressToggled(value);
                    },
                  )),
          const SizedBox(height: 40),
          Container(
            color: Colors.transparent,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child:
                Consumer3<AddressValidation, AddressViewModel, LoginViewModel>(
              builder:
                  (_, validationNotifier, addressNotifier, loginNotifier, __) =>
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
                onPressed: validationNotifier.isDetailsValid()
                    ? () {
                        FocusScope.of(context).unfocus();
                        addressNotifier.submitAddressDetails(context,
                            address: validationNotifier.getValidatedAddress(
                                loginNotifier.userDetails.id),
                            resetValidationItem:
                                validationNotifier.resetValidationItem);

                        //TODO need to pop and refresh the my address screen whether here or in the viewmodel
                        //TODO set the validation item to null again so that the button will be disabled again when open the add address screen again
                      }
                    : null,
                child: addressNotifier.isSubmitted
                    ? SizedBox(
                        width: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Creating Your Address'.toUpperCase(),
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
