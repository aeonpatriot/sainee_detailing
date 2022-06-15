import 'package:sainee_detailing/dependencies.dart';
import 'package:sainee_detailing/models/service.dart';
import 'package:sainee_detailing/services/rest.dart';

class ServicesService {
  final restService = service<Rest>();

  Future<List<Service>?> getAllServices() async {
    final json = await restService.get('services') as List?;
    if (json == null) {
      return null;
    }
    List<Service>? services =
        json.map((service) => Service.fromJson(service)).toList();
    return services;
  }
}
