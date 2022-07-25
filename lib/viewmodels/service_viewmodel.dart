import 'package:flutter/cupertino.dart';
import 'package:sainee_detailing/dependencies.dart';
import 'package:sainee_detailing/models/service.dart';
import 'package:sainee_detailing/services/services_service.dart';
import 'package:sainee_detailing/widget/custom_snackbar.dart';

class ServiceViewModel extends ChangeNotifier {
  final servicesService = service<ServicesService>();

  late Service serviceDetails;
  late Service serviceDetailsCopy;

  bool isSubmitted = false;

  late List<Service> servicesList;

  void setIsSubmitted(value) {
    isSubmitted = value;
    notifyListeners();
  }

  noti() {
    notifyListeners();
  }

  Future storeNewService(BuildContext context, Service newService,
      void Function() resetValidationItem) async {
    final Service? service = await servicesService.storeNewService(newService);
    if (service == null) {
      FailedSnackBar.show(
          context: context,
          title: 'Oh Snap!',
          message:
              'There is some problem creating new service. Please try again');
      setIsSubmitted(false);
    } else {
      resetValidationItem();
      Navigator.of(context).pop();
      SuccessSnackBar.show(
          context: context,
          message: 'Your new service has been added successfully');
      setIsSubmitted(false);
      return service;
    }
  }

  Future deleteService(
      {required BuildContext context,
      required String serviceId,
      required VoidCallback resetValidationItem}) async {
    final response = await servicesService.deleteService(serviceId);

    if (response == null) {
      FailedSnackBar.show(
          context: context,
          title: 'Oh Snap!',
          message:
              'There is some problem deleting the service. Please try again');
    } else {
      resetValidationItem();
      Navigator.of(context).pop();
      Navigator.of(context)
          .pop(); //2 pop because first popo from alert dialog and second pop from the edit screen
      noti();
      SuccessSnackBar.show(
          context: context, message: 'Service has been deleted successfully');
    }
  }

  Future updateService(
      {required BuildContext context,
      required Service service,
      required dynamic resetValidationItem}) async {
    final json = await servicesService.updateService(service);

    if (json == null) {
      FailedSnackBar.show(
          context: context,
          title: 'Oh Snap!',
          message:
              'There is some problem updating your service. Please try again');
      setIsSubmitted(false);
    } else {
      resetValidationItem();
      Navigator.of(context).pop();
      noti();
      SuccessSnackBar.show(
          context: context, message: 'Service has been updated successfully');
      setIsSubmitted(false);
    }
  }

  Future getServices() async {
    final List<Service>? services = await servicesService.getAllServices();
    if (services == null) {
    } else {
      servicesList = services;
      return services;
    }
  }

  List<Widget> getTextDetailsList(List<String> detailsList) {
    final List<Widget> textDetailsList = [];
    for (String detail in detailsList) {
      textDetailsList.add(Text('- $detail'));
      textDetailsList.add(const SizedBox(height: 1));
    }
    return textDetailsList;
  }

  String setServicePrice({required String carType, required Service service}) {
    switch (carType) {
      case 'Small':
        return service.smallPrice!;
      case 'Medium':
        return service.mediumPrice!;
      case 'Large':
        return service.largePrice!;
      case 'SUV':
        return service.suvPrice!;
      case 'MPV':
        return service.mpvPrice!;
      default:
        return '';
    }
  }

  List<String> otherTypePriceItem(Service service) {
    final List<String> otherPrices;
    otherPrices = [
      'Small: RM ${service.smallPrice}',
      'Medium: RM ${service.mediumPrice}',
      'Large: RM ${service.largePrice}',
      'SUV: RM ${service.suvPrice}',
      'MPV: RM ${service.mpvPrice}',
    ];
    return otherPrices;
  }

  void setServiceForEdit(Service service) {
    serviceDetails = service;
    serviceDetailsCopy = Service.copy(serviceDetails);
  }
}
