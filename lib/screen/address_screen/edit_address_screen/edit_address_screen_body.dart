import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/screen/address_screen/custom_widget.dart';
import 'package:sainee_detailing/screen/address_screen/full_width_phone_field.dart';
import 'package:sainee_detailing/validation/address_validation.dart';
import 'package:sainee_detailing/viewmodels/address_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/login_viewmodel.dart';

class EditAddressScreenBody extends StatelessWidget {
  const EditAddressScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const CustomTextDivider(title: 'Contact'),
          Consumer2<AddressViewModel, AddressValidation>(
            builder: (_, addressNotifier, validationNotifier, __) =>
                CustomFullWidthTextField(
              isPostcode: false,
              errorText: validationNotifier.name.error,
              labelText: 'Full Name',
              onChanged: (name) {
                validationNotifier.setName(name);
                addressNotifier.editingAddressCopy.name = name;
              },
              editAddressText: addressNotifier.editingAddressCopy.name,
            ),
          ),
          Consumer2<AddressViewModel, AddressValidation>(
            builder: (_, addressNotifier, validationNotifier, __) =>
                CustomFullWidthIntlPhoneField(
              editNumber: addressNotifier.editingAddressCopy.phoneNumber,
              validator: (phoneNumber) {
                if (phoneNumber != null &&
                    (phoneNumber.number.length < 9 ||
                        phoneNumber.number.length > 10)) {
                  validationNotifier.phoneNumber = phoneNumber.completeNumber;
                  validationNotifier.setIsPhoneNumberValid(false);
                  return 'Enter valid phone number';
                } else {
                  validationNotifier.setIsPhoneNumberValid(true);
                  return null;
                }
              },
              onChanged: (phoneNumber) {
                validationNotifier.phoneNumber = phoneNumber.completeNumber;
                addressNotifier.editingAddressCopy.phoneNumber =
                    phoneNumber.completeNumber;
              },
            ),
          ),
          const SizedBox(height: 10),
          const CustomTextDivider(title: 'Address'),
          Consumer2<AddressViewModel, AddressValidation>(
            builder: (_, addressNotifier, validationNotifier, __) =>
                CustomFullWidthTextField(
              isPostcode: false,
              errorText: validationNotifier.state.error,
              labelText: 'State',
              onChanged: (state) {
                validationNotifier.setState(state);
                addressNotifier.editingAddressCopy.state = state;
              },
              editAddressText: addressNotifier.editingAddressCopy.state,
            ),
          ),
          Consumer2<AddressViewModel, AddressValidation>(
            builder: (_, addressNotifier, validationNotifier, __) =>
                CustomFullWidthTextField(
              isPostcode: false,
              errorText: validationNotifier.city.error,
              labelText: 'City',
              onChanged: (city) {
                validationNotifier.setCity(city);
                addressNotifier.editingAddressCopy.city = city;
              },
              editAddressText: addressNotifier.editingAddressCopy.city,
            ),
          ),
          Consumer2<AddressViewModel, AddressValidation>(
            builder: (_, addressNotifier, validationNotifier, __) =>
                CustomFullWidthTextField(
              isPostcode: false,
              errorText: validationNotifier.postcode.error,
              labelText: 'Postal Code',
              onChanged: (postcode) {
                validationNotifier.setPostcode(postcode);
                addressNotifier.editingAddressCopy.postcode = postcode;
              },
              editAddressText: addressNotifier.editingAddressCopy.postcode,
            ),
          ),
          Consumer2<AddressViewModel, AddressValidation>(
            builder: (_, addressNotifier, validationNotifier, __) =>
                CustomFullWidthTextField(
              isPostcode: false,
              errorText: validationNotifier.detailAddress.error,
              labelText: 'Detailed Address',
              onChanged: (detailAddress) {
                validationNotifier.setDetailAddress(detailAddress);
                addressNotifier.editingAddressCopy.addressLine1 = detailAddress;
              },
              maxLine: 3,
              editAddressText: addressNotifier.editingAddressCopy.addressLine1,
            ),
          ),
          const SizedBox(height: 10),
          const CustomTextDivider(title: 'Settings'),
          Consumer2<AddressViewModel, AddressValidation>(
              builder: (_, addressNotifier, validationNotifier, __) =>
                  LabeledSwitch(
                    label: 'Set Default Address?',
                    value: validationNotifier.defaultAddressToggled,
                    onChanged: (bool value) {
                      validationNotifier.setDefaultAddressToggled(value);
                      if (value) {
                        addressNotifier.editingAddressCopy.defaultAddress = 'Y';
                      } else {
                        addressNotifier.editingAddressCopy.defaultAddress = 'N';
                      }
                    },
                    isEdit: true,
                    defaultAddress:
                        addressNotifier.editingAddressCopy.defaultAddress,
                    originalDefaultAddress:
                        addressNotifier.editingAddress.defaultAddress,
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
                        addressNotifier.updateAddress(
                            context: context,
                            address: addressNotifier.editingAddressCopy,
                            resetValidationItem:
                                validationNotifier.resetValidationItem);
                      }
                    : null,
                child: addressNotifier.isSubmitted
                    ? SizedBox(
                        width: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Updating Your Address'.toUpperCase(),
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
