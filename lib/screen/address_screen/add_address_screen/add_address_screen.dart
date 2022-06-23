import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/screen/address_screen/add_address_screen/add_address_screen_body.dart';
import 'package:sainee_detailing/validation/address_validation.dart';
import 'package:sainee_detailing/widget/custom_alert_dialog_widget/confirm_discard_alert.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (context) => const AddAddressScreen());

  @override
  Widget build(BuildContext context) {
    final addressValidation =
        Provider.of<AddressValidation>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        if (addressValidation.isDetailsEmpty()) {
          FocusScope.of(context).unfocus();
          addressValidation.resetValidationItem();
          Navigator.of(context).pop();
        } else {
          FocusScope.of(context).unfocus();
          ConfirmDiscardAlert.showAlertDialog(
              context: context,
              onDiscardPressed: () {
                addressValidation.resetValidationItem();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              });
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
            'Add Address',
            style: Theme.of(context).textTheme.headline6,
          ),
          leading: IconButton(
              onPressed: () {
                if (addressValidation.isDetailsEmpty()) {
                  FocusScope.of(context).unfocus();
                  Navigator.of(context).pop();
                  addressValidation.resetValidationItem();
                } else {
                  FocusScope.of(context).unfocus();
                  ConfirmDiscardAlert.showAlertDialog(
                      context: context,
                      onDiscardPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        addressValidation.resetValidationItem();
                      });
                }
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: const AddAddressScreenBody(),
      ),
    );
  }
}
