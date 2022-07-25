import 'package:sainee_detailing/dependencies.dart';
import 'package:sainee_detailing/models/service.dart';
import 'package:sainee_detailing/services/response_model.dart';
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

  Future<Service?> storeNewService(Service service) async {
    final json =
        await restService.postWithToken('services', data: service.toJson());
    if (json == null) {
      return null;
    }
    return Service.fromJson(json);
  }

  Future<Service?> updateService(Service service) async {
    final json = await restService.postWithToken('services/${service.id}',
        data: service);
    if (json == null) {
      return null;
    }
    return Service.fromJson(json);
  }

  Future<String?> deleteService(String carId) async {
    final json = await restService.deleteWithToken('services/$carId');

    if (json == null) {
      return null;
    }

    final Response result = Response.fromJson(json);
    if (result.status == '1') {
      return result.message;
    }
    return null;
  }
}
