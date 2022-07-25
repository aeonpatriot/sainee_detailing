import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/screen/services_screen/staff/add_services/add_service_screen_body.dart';
import 'package:sainee_detailing/validation/service_validation.dart';
import 'package:sainee_detailing/widget/custom_alert_dialog_widget/confirm_discard_alert.dart';

class AddServiceScreen extends StatelessWidget {
  const AddServiceScreen({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (context) => const AddServiceScreen());

  @override
  Widget build(BuildContext context) {
    final ServiceValidation serviceValidation =
        Provider.of<ServiceValidation>(context, listen: false);

    return WillPopScope(
      onWillPop: () async {
        if (serviceValidation.isDetailsEmpty()) {
          FocusScope.of(context).unfocus();
          Navigator.of(context).pop();
          serviceValidation.resetValidationItem();
        } else {
          FocusScope.of(context).unfocus();
          ConfirmDiscardAlert.showAlertDialog(
              context: context,
              onDiscardPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                serviceValidation.resetValidationItem();
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
            'Add Service',
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: kColorBlack),
          ),
          actions: const [],
          leading: IconButton(
              onPressed: () {
                if (serviceValidation.isDetailsEmpty()) {
                  FocusScope.of(context).unfocus();
                  Navigator.of(context).pop();
                  serviceValidation.resetValidationItem();
                } else {
                  FocusScope.of(context).unfocus();
                  ConfirmDiscardAlert.showAlertDialog(
                      context: context,
                      onDiscardPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        serviceValidation.resetValidationItem();
                      });
                }
              },
              icon: const Icon(
                Icons.arrow_back,
                color: kPrimaryColorDark,
              )),
        ),
        body: const AddServiceScreenBody(),
      ),
    );
  }
}
