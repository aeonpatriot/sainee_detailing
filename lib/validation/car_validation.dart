import 'package:flutter/material.dart';
import 'package:sainee_detailing/models/car.dart';
import 'package:sainee_detailing/validation/validation_item.dart';

class CarValidation extends ChangeNotifier {
  ValidationItem _model = ValidationItem(null, null);
  ValidationItem _type = ValidationItem(null, null);
  ValidationItem _brand = ValidationItem(null, null);
  ValidationItem _plateNumber = ValidationItem(null, null);
  ValidationItem _description = ValidationItem(null, null);
  bool _defaultCarToggled = false;

  ValidationItem get model => _model;
  ValidationItem get type => _type;
  ValidationItem get brand => _brand;
  ValidationItem get plateNumber => _plateNumber;
  ValidationItem get description => _description;

  get defaultCarToggled => _defaultCarToggled;
  setDefaultCarToggled(value) {
    _defaultCarToggled = value;
    notifyListeners();
  }

  String getDefaultCar() {
    if (defaultCarToggled == true) {
      return 'Y';
    } else {
      return 'N';
    }
  }

  bool isCarDetailsEmpty() {
    if ((model.value == null || model.value == '') &&
        (type.value == null || type.value == '') &&
        (brand.value == null || brand.value == '') &&
        (plateNumber.value == null || plateNumber.value == '') &&
        (description.value == null || description.value == '') &&
        (defaultCarToggled == null || defaultCarToggled == false)) {
      return true;
    } else {
      return false;
    }
  }

  void setModel(String model) {
    if (model.length >= 3) {
      _model = ValidationItem(model, null);
    } else {
      _model = ValidationItem(null, 'Must be at least 3 characters');
    }
    notifyListeners();
  }

  void setType(String? type) {
    if (type != null) {
      _type = ValidationItem(type, null);
    } else {
      _type = ValidationItem(null, 'Please select car type');
    }
    notifyListeners();
  }

  void setBrand(String brand) {
    if (brand.length >= 3) {
      _brand = ValidationItem(brand, null);
    } else {
      _brand = ValidationItem(null, 'Must be at least 3 characters');
    }
    notifyListeners();
  }

  void setPlateNumber(String plateNumber) {
    if (plateNumber.length >= 3) {
      _plateNumber = ValidationItem(plateNumber, null);
    } else {
      _plateNumber = ValidationItem(null, 'Must be at least 3 characters');
    }
    notifyListeners();
  }

  void setDescription(String description) {
    if (description.length >= 3) {
      _description = ValidationItem(description, null);
    } else {
      _description = ValidationItem(null, 'Must be at least 3 characters');
    }
    notifyListeners();
  }

  Car getValidatedCar(String userId) {
    final Car car = Car(
      userId: userId,
      type: type.value,
      brand: brand.value,
      model: model.value,
      plateNumber: plateNumber.value,
      description: description.value,
      defaultCar: getDefaultCar(),
    );
    return car;
  }

  void setValidationItemEdit({required Car car}) {
    _type = ValidationItem(car.type, null);
    _model = ValidationItem(car.model, null);
    _brand = ValidationItem(car.brand, null);
    _plateNumber = ValidationItem(car.plateNumber, null);
    _description = ValidationItem(car.description, null);
    if (car.defaultCar == 'Y') {
      setDefaultCarToggled(true);
    } else {
      setDefaultCarToggled(false);
    }
  }

  bool isCarDetailsValid() {
    if (type.value != null &&
        model.value != null &&
        brand.value != null &&
        plateNumber.value != null &&
        description.value != null) {
      return true;
    } else {
      return false;
    }
  }

  void resetValidationItem() {
    _type = ValidationItem(null, null);
    _model = ValidationItem(null, null);
    _brand = ValidationItem(null, null);
    _plateNumber = ValidationItem(null, null);
    _description = ValidationItem(null, null);
    setDefaultCarToggled(false);
  }
}
