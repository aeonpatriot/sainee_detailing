import 'package:get_it/get_it.dart';
import 'package:sainee_detailing/services/address_service.dart';
import 'package:sainee_detailing/services/book_service.dart';
import 'package:sainee_detailing/services/car_service.dart';
import 'package:sainee_detailing/services/rest.dart';
import 'package:sainee_detailing/services/rest_service.dart';
import 'package:sainee_detailing/services/services_service.dart';
import 'package:sainee_detailing/services/user_service.dart';

GetIt service = GetIt.instance;

void init() {
  service.registerLazySingleton<Rest>(() => RestService());

  service.registerLazySingleton(() => UserService());
  service.registerLazySingleton(() => AddressService());
  service.registerLazySingleton(() => CarService());
  service.registerLazySingleton(() => ServicesService());
  service.registerLazySingleton(() => BookService());
}
