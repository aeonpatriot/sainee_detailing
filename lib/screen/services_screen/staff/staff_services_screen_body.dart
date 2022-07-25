import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/models/service.dart';
import 'package:sainee_detailing/validation/service_validation.dart';
import 'package:sainee_detailing/viewmodels/service_viewmodel.dart';

class StaffServicesScreenBody extends StatelessWidget {
  const StaffServicesScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ServiceViewModel serviceViewModel =
        Provider.of<ServiceViewModel>(context);
    final ServiceValidation serviceValidation =
        Provider.of<ServiceValidation>(context);

    return FutureBuilder(
      future: serviceViewModel.getServices(),
      // initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
                child: SpinKitCubeGrid(
              color: kSecondaryColor,
              size: 50.0,
            ));
          case ConnectionState.done:
          default:
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              List<Service> data = snapshot.data as List<Service>;
              print('refresh service data');
              return ListView.builder(
                  padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    Service service = data[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color:
                                kSecondaryColorDark.withOpacity(0.1), //shadow
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Material(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: kColorWhite,
                        child: InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          onTap: () {
                            serviceViewModel.setServiceForEdit(service);
                            serviceValidation.setValidationItemEdit(
                                service: service);
                            Navigator.of(context).pushNamed('/editService');
                          },
                          child: Container(
                            padding: const EdgeInsets.all(0),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    flex: 5,
                                    fit: FlexFit.tight,
                                    child: Container(
                                      // decoration: BoxDecoration(
                                      //     border: Border.all(
                                      //         width: 1,
                                      //         color: kSecondaryColorDark)
                                      //         ),
                                      padding: const EdgeInsets.only(
                                          top: 15,
                                          left: 20,
                                          bottom: 20,
                                          right: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(data[index].name!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  ?.copyWith(fontSize: 18)),
                                          const SizedBox(height: 10),
                                          ...serviceViewModel
                                              .getTextDetailsList(
                                                  data[index].details!),
                                        ],
                                      ),
                                      // height: 150,
                                      // width: 100,
                                    ),
                                  ),
                                  Flexible(
                                    flex: 5,
                                    fit: FlexFit.tight,
                                    child: Container(
                                      // decoration: BoxDecoration(
                                      //     border: Border.all(
                                      //         width: 1,
                                      //         color: kSecondaryColorDark)),
                                      padding: const EdgeInsets.only(
                                          top: 15,
                                          left: 20,
                                          bottom: 20,
                                          right: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Price',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  ?.copyWith(fontSize: 18)),
                                          const SizedBox(height: 10),
                                          Text(
                                              'Small: RM ${service.smallPrice}'),
                                          const SizedBox(height: 3),
                                          Text(
                                              'Medium: RM ${service.mediumPrice}'),
                                          const SizedBox(height: 3),
                                          Text(
                                              'Large: RM ${service.largePrice}'),
                                          const SizedBox(height: 3),
                                          Text('SUV: RM ${service.suvPrice}'),
                                          const SizedBox(height: 3),
                                          Text('MPV: RM ${service.mpvPrice}'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(
                  child: Text('Having some problem to load data'));
            }
        }
      },
    );
  }
}
