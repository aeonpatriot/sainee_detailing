import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sainee_detailing/dependencies.dart';
import 'package:sainee_detailing/models/car.dart';
import 'package:sainee_detailing/services/car_service.dart';
import 'package:sainee_detailing/widget/custom_snackbar.dart';

class CarViewModel extends ChangeNotifier {
  final carService = service<CarService>();

  late Car _editingCar;
  late Car _editingCarCopy;
  late Car _defaultCar;
  bool _isSubmitted = false;

  final typeList = <String>[
    'Small',
    'Medium',
    'Large',
    'SUV',
    'MPV',
  ];

  Car get editingCar => _editingCar;
  set editingCar(value) => _editingCar = value;
  Car get editingCarCopy => _editingCarCopy;
  set editingCarCopy(value) => _editingCarCopy = value;
  Car get defaultCar => _defaultCar;

  bool get isSubmitted => _isSubmitted;
  setIsSubmitted(value) {
    _isSubmitted = value;
    notifyListeners();
  }

  void setDefaultCar(List<Car> carList) {
    for (Car car in carList) {
      if (car.defaultCar == 'Y') {
        _defaultCar = car;
      }
    }
  }

  Future getUserCars(String userId) async {
    final List<Car>? cars = await carService.getUserCars(userId);
    if (cars == null) {
      print('get failed');
    } else {
      print('get success');
      print(cars.length);
      setDefaultCar(cars);
      print(defaultCar);
      return cars;
    }
  }

  Future submitCarDetails(
      {required BuildContext context,
      required Car newCar,
      required VoidCallback resetImagePicker,
      required dynamic resetValidationItem,
      required XFile? imageFile}) async {
    setIsSubmitted(true);

    final Car? car = await carService.createNewCar(newCar);

    if (car == null) {
      FailedSnackBar.show(
          context: context,
          title: 'Oh Snap!',
          message: 'There is some problem creating your car. Please try again');
      setIsSubmitted(false);
    } else {
      final carImage =
          await carService.updateImage(carId: car.id!, imageFile: imageFile);

      if (carImage == null) {
        resetImagePicker();
        resetValidationItem();
        Navigator.of(context).pop();
        noti();

        SuccessSnackBar.show(
            context: context,
            message:
                'Your new car has been created successfully. But the image did not uploaded. You can try upload the image again');

        setIsSubmitted(false);
      } else {
        resetImagePicker();
        resetValidationItem();
        Navigator.of(context).pop();
        noti();

        SuccessSnackBar.show(
            context: context,
            message: 'Your new car has been created successfully');

        setIsSubmitted(false);
      }
    }
  }

  Future updateCarDetails(
      {required BuildContext context,
      required dynamic resetValidationItem,
      required XFile? imageFile,
      required VoidCallback clearCache,
      required VoidCallback resetImage}) async {
    setIsSubmitted(true);

    List<Future<dynamic>> requestList = [];
    int nullCount = 0;

    if (isCarDetailsChanged()) {
      requestList.add(carService.updateCar(
          editedCar: editingCarCopy, carId: editingCarCopy.id!));
    }
    if (imageFile != null) {
      requestList.add(carService.updateImage(
          imageFile: imageFile, carId: editingCarCopy.id!));
    }

    final List jsonResults = await Future.wait(requestList);

    for (var result in jsonResults) {
      if (result == null) {
        nullCount++;
      }
    }

    if (nullCount == jsonResults.length) {
      setIsSubmitted(false);
      clearCache();
      requestList = [];
      FailedSnackBar.show(
          context: context,
          title: 'On Snap!',
          message:
              'There is some problem updating your car. If this error persists please call our customer service');
    } else {
      setIsSubmitted(false);
      resetImage();
      resetValidationItem();
      clearCache();
      SuccessSnackBar.show(
          context: context, message: 'Car have been updated successfully');
      Navigator.of(context).pop();
      requestList = [];
    }
  }

  Future deleteCar(
      {required BuildContext context,
      required String carId,
      required VoidCallback resetValidationItem}) async {
    print(carId);
    final response = await carService.deleteCar(carId);

    if (response == null) {
      FailedSnackBar.show(
          context: context,
          title: 'Oh Snap!',
          message: 'There is some problem deleting the car. Please try again');
    } else {
      resetValidationItem();
      Navigator.of(context).pop();
      Navigator.of(context)
          .pop(); //2 pop because first popo from alert dialog and second pop from the edit screen
      noti();
      SuccessSnackBar.show(
          context: context, message: 'Car has been deleted successfully');
    }
  }

  bool isCarDetailsChanged() {
    if (editingCar.type != editingCarCopy.type ||
        editingCar.model != editingCarCopy.model ||
        editingCar.brand != editingCarCopy.brand ||
        editingCar.plateNumber != editingCarCopy.plateNumber ||
        editingCar.description != editingCarCopy.description ||
        editingCar.defaultCar != editingCarCopy.defaultCar) {
      return true;
    } else {
      return false;
    }
  }

  setCarForEdit(Car car) {
    editingCar = car;
    editingCarCopy = Car.copy(editingCar);
  }

  noti() {
    notifyListeners();
  }
}
