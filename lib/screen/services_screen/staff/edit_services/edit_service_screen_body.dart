import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/validation/service_validation.dart';
import 'package:sainee_detailing/viewmodels/service_viewmodel.dart';
import 'package:sainee_detailing/widget/custom_full_width_text_field.dart';

class EditServiceScreenBody extends StatelessWidget {
  const EditServiceScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextDivider(title: 'Service Name'),
          Consumer2<ServiceViewModel, ServiceValidation>(
            builder: (_, serviceNotifier, validationNotifier, __) =>
                CustomFullWidthTextField(
              errorText: validationNotifier.name.error,
              labelText: 'Service Name',
              onChanged: (name) {
                validationNotifier.setName(name);
                serviceNotifier.serviceDetailsCopy.name = name;
              },
              isEdit: true,
              editext: serviceNotifier.serviceDetailsCopy.name,
            ),
          ),
          const CustomTextDivider(title: 'Service Details'),
          Consumer2<ServiceViewModel, ServiceValidation>(
            builder: (_, serviceNotifier, validationNotifier, __) =>
                CustomFullWidthTextField(
              errorText: validationNotifier.details.error,
              labelText:
                  'Service Details *ex: Wash|Clay|Nanomist|Glass Cleaning',
              maxLine: 3,
              onChanged: (details) {
                validationNotifier.setDetails(details);
                serviceNotifier.serviceDetailsCopy.details = [
                  ...(validationNotifier.convertStringtoList(details))
                ];
                // validationNotifier.convertStringtoList(details);
              },
              isEdit: true,
              editext: validationNotifier.convertListtoString(
                  serviceNotifier.serviceDetailsCopy.details!),
            ),
          ),
          const CustomTextDivider(title: 'Small price RM'),
          Consumer2<ServiceViewModel, ServiceValidation>(
            builder: (_, serviceNotifier, validationNotifier, __) => SizedBox(
              // height: 70,
              // width: MediaQuery.of(context).size.width / 2,
              child: CustomFullWidthTextField(
                isRinggit: true,
                isNumber: true,
                errorText: validationNotifier.smallPrice.error,
                labelText: 'Small price',
                onChanged: (smallPrice) {
                  validationNotifier.setSmallPrice(smallPrice);
                  serviceNotifier.serviceDetailsCopy.smallPrice = smallPrice;
                },
                isEdit: true,
                editext: serviceNotifier.serviceDetailsCopy.smallPrice,
              ),
            ),
          ),
          const CustomTextDivider(title: 'Medium price RM'),
          Consumer2<ServiceViewModel, ServiceValidation>(
            builder: (_, serviceNotifier, validationNotifier, __) => SizedBox(
              // height: 70,
              // width: MediaQuery.of(context).size.width / 2,
              child: CustomFullWidthTextField(
                isRinggit: true,
                isNumber: true,
                errorText: validationNotifier.mediumPrice.error,
                labelText: 'Medium price',
                onChanged: (mediumPrice) {
                  validationNotifier.setMediumPrice(mediumPrice);
                  serviceNotifier.serviceDetailsCopy.mediumPrice = mediumPrice;
                },
                isEdit: true,
                editext: serviceNotifier.serviceDetailsCopy.mediumPrice,
              ),
            ),
          ),
          const CustomTextDivider(title: 'Large price RM'),
          Consumer2<ServiceViewModel, ServiceValidation>(
            builder: (_, serviceNotifier, validationNotifier, __) => SizedBox(
              // height: 70,
              // width: MediaQuery.of(context).size.width / 2,
              child: CustomFullWidthTextField(
                isRinggit: true,
                isNumber: true,
                errorText: validationNotifier.largePrice.error,
                labelText: 'Large price',
                onChanged: (largePrice) {
                  validationNotifier.setLargePrice(largePrice);
                  serviceNotifier.serviceDetailsCopy.largePrice = largePrice;
                },
                isEdit: true,
                editext: serviceNotifier.serviceDetailsCopy.largePrice,
              ),
            ),
          ),
          const CustomTextDivider(title: 'SUV price RM'),
          Consumer2<ServiceViewModel, ServiceValidation>(
            builder: (_, serviceNotifier, validationNotifier, __) => SizedBox(
              // height: 70,
              // width: MediaQuery.of(context).size.width / 2,
              child: CustomFullWidthTextField(
                isRinggit: true,
                isNumber: true,
                errorText: validationNotifier.suvPrice.error,
                labelText: 'SUV price',
                onChanged: (suvPrice) {
                  validationNotifier.setSUVPrice(suvPrice);
                  serviceNotifier.serviceDetailsCopy.suvPrice = suvPrice;
                },
                isEdit: true,
                editext: serviceNotifier.serviceDetailsCopy.suvPrice,
              ),
            ),
          ),
          const CustomTextDivider(title: 'MPV price RM'),
          Consumer2<ServiceViewModel, ServiceValidation>(
            builder: (_, serviceNotifier, validationNotifier, __) => SizedBox(
              // height: 70,
              // width: MediaQuery.of(context).size.width / 2,
              child: CustomFullWidthTextField(
                isRinggit: true,
                isNumber: true,
                errorText: validationNotifier.mpvPrice.error,
                labelText: 'MPV price',
                onChanged: (mpvPrice) {
                  validationNotifier.setMPVPrice(mpvPrice);
                  serviceNotifier.serviceDetailsCopy.mpvPrice = mpvPrice;
                },
                isEdit: true,
                editext: serviceNotifier.serviceDetailsCopy.mpvPrice,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            color: Colors.transparent,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Consumer2<ServiceViewModel, ServiceValidation>(
              builder: (_, serviceNotifier, validationNotifier, __) =>
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
                  // print(serviceNotifier.serviceDetailsCopy);
                  // print(serviceNotifier.serviceDetails);
                  serviceNotifier.updateService(
                      context: context,
                      service: serviceNotifier.serviceDetailsCopy,
                      resetValidationItem:
                          validationNotifier.resetValidationItem);
                },
                child: serviceNotifier.isSubmitted
                    ? SizedBox(
                        width: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Adding Your Service'.toUpperCase(),
                              style: Theme.of(context).textTheme.button,
                            ),
                            const SizedBox(width: 10),
                            const SizedBox(
                              height: 20,
                              width: 20,
                              child: SpinKitWave(
                                color: Colors.white,
                                size: 20.0,
                              ),
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
