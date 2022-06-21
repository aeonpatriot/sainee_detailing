import 'package:image_picker/image_picker.dart';
import 'package:sainee_detailing/dependencies.dart';
import 'package:sainee_detailing/models/car.dart';
import 'package:sainee_detailing/services/response_model.dart';
import 'package:sainee_detailing/services/rest.dart';

class CarService {
  final restService = service<Rest>();

  Future<List<Car>?> getAllCars() async {
    final json = await restService.get('cars') as List?;
    if (json == null) {
      return null;
    }
    List<Car>? cars = json.map((car) => Car.fromJson(car)).toList();
    return cars;
  }

  Future<Car?> getCar(String carId) async {
    final json = await restService.get('cars/$carId');

    if (json == null) return null;

    return Car.fromJson(json);
  }

  Future<List<Car>?> getUserCars(String userId) async {
    final json = await restService.get('cars/user/$userId') as List?;
    if (json == null) {
      return null;
    }
    List<Car>? cars = json.map((car) => Car.fromJson(car)).toList();
    return cars;
  }

  Future<Car?> createNewCar(Car newCar) async {
    final json = await restService.postWithToken('cars', data: newCar);

    if (json == null) {
      return null;
    }
    Car? car = Car.fromJson(json);
    return car;
  }

  Future<Car?> updateCar(
      {required String carId, required Car editedCar}) async {
    final json = await restService.putWithToken('cars/$carId', data: editedCar);

    if (json == null) {
      return null;
    }

    Car? car = Car.fromJson(json);
    return car;
  }

  Future<Car?> updateImage(
      {required String carId, required XFile? imageFile}) async {
    final json = await restService.uploadImage(
        endpoint: 'car/carImage/$carId',
        imageFile: imageFile,
        requestName: 'carImage');

    if (json == null) return null;
    return Car.fromJson(json['data']);
  }

  Future<String?> deleteCar(String carId) async {
    final json = await restService.deleteWithToken('car/$carId');

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
