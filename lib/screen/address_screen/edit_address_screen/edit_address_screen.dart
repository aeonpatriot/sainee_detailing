import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/screen/address_screen/edit_address_screen/edit_address_screen_body.dart';
import 'package:sainee_detailing/validation/address_validation.dart';
import 'package:sainee_detailing/viewmodels/address_viewmodel.dart';
import 'package:sainee_detailing/widget/confirm_delete_alert.dart';
import 'package:sainee_detailing/widget/confirm_discard_alert.dart';

class EditAddressScreen extends StatelessWidget {
  const EditAddressScreen({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: ((context) => const EditAddressScreen()));

  @override
  Widget build(BuildContext context) {
    final AddressViewModel addressViewModel =
        Provider.of(context, listen: false);
    final AddressValidation addressValidation =
        Provider.of(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        if (addressValidation.isDetailsChanged(
            editedAddress: addressViewModel.editingAddressCopy,
            originalAddress: addressViewModel.editingAddress)) {
          ConfirmDiscardAlert.showAlertDialog(
              context: context,
              onDiscardPressed: () {
                addressValidation.resetValidationItem();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              });
        } else {
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
                      addressViewModel.deleteAddress(
                          context: context,
                          addressId: addressViewModel.editingAddressCopy.id,
                          resetValidationItem:
                              addressValidation.resetValidationItem);
                    });
              },
            )
          ],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              FocusScope.of(context).unfocus();
              if (addressValidation.isDetailsChanged(
                  editedAddress: addressViewModel.editingAddressCopy,
                  originalAddress: addressViewModel.editingAddress)) {
                ConfirmDiscardAlert.showAlertDialog(
                    context: context,
                    onDiscardPressed: () {
                      FocusScope.of(context).unfocus();
                      addressValidation.resetValidationItem();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    });
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
        ),
        body: const EditAddressScreenBody(),
      ),
    );
  }
}
