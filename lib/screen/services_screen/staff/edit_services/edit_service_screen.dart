import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/screen/services_screen/staff/edit_services/edit_service_screen_body.dart';
import 'package:sainee_detailing/validation/service_validation.dart';
import 'package:sainee_detailing/viewmodels/service_viewmodel.dart';
import 'package:sainee_detailing/widget/custom_alert_dialog_widget/confirm_delete_alert.dart';
import 'package:sainee_detailing/widget/custom_alert_dialog_widget/confirm_discard_alert.dart';

class EditServiceScreen extends StatelessWidget {
  const EditServiceScreen({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (context) => const EditServiceScreen());

  @override
  Widget build(BuildContext context) {
    final ServiceViewModel serviceViewModel =
        Provider.of<ServiceViewModel>(context);
    final ServiceValidation serviceValidation =
        Provider.of<ServiceValidation>(context);

    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        if (serviceValidation.isDetailsChanged(
            editedService: serviceViewModel.serviceDetailsCopy,
            originalService: serviceViewModel.serviceDetails)) {
          ConfirmDiscardAlert.showAlertDialog(
              context: context,
              onDiscardPressed: () {
                FocusScope.of(context).unfocus();
                serviceValidation.resetValidationItem();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              });
        } else {
          serviceValidation.resetValidationItem();
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
            'Edit Service',
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
                      serviceViewModel.deleteService(
                          context: context,
                          serviceId: serviceViewModel.serviceDetailsCopy.id!,
                          resetValidationItem:
                              serviceValidation.resetValidationItem);
                    });
              },
            )
          ],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              FocusScope.of(context).unfocus();
              if (serviceValidation.isDetailsChanged(
                  editedService: serviceViewModel.serviceDetailsCopy,
                  originalService: serviceViewModel.serviceDetails)) {
                ConfirmDiscardAlert.showAlertDialog(
                    context: context,
                    onDiscardPressed: () {
                      FocusScope.of(context).unfocus();
                      serviceValidation.resetValidationItem();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    });
              } else {
                serviceValidation.resetValidationItem();
                Navigator.of(context).pop();
              }
            },
          ),
        ),
        body: const EditServiceScreenBody(),
      ),
    );
  }
}
