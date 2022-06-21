import 'package:flutter/cupertino.dart';
import 'package:sainee_detailing/dependencies.dart';
import 'package:sainee_detailing/models/service.dart';
import 'package:sainee_detailing/services/services_service.dart';

class ServiceViewModel extends ChangeNotifier {
  final servicesService = service<ServicesService>();

  late List<Service> servicesList;

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
}
