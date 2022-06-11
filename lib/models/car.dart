// ignore_for_file: non_constant_identifier_names

class Car {
  final String? _id;
  String? userId;
  String? type;
  String? model;
  String? brand;
  String? plateNumber;
  String? carImagePath;
  String? carImageName;
  String? description;
  String? defaultCar;
  final String? _created_at;
  final String? _updated_at;

  Car(
      {id,
      this.userId,
      this.type,
      this.model,
      this.brand,
      this.plateNumber,
      this.carImagePath,
      this.carImageName,
      this.description,
      this.defaultCar,
      created_at,
      updated_at})
      : _id = id,
        _created_at = created_at,
        _updated_at = updated_at;

  String? get id => _id;
  String? get created_at => _created_at;
  String? get updated_at => _updated_at;

  factory Car.copy(Car from) {
    return Car(
      id: from.id,
      userId: from.userId,
      type: from.type,
      model: from.model,
      brand: from.brand,
      plateNumber: from.plateNumber,
      carImagePath: from.carImagePath,
      carImageName: from.carImageName,
      description: from.description,
      defaultCar: from.defaultCar,
      created_at: from.created_at,
      updated_at: from.updated_at,
    );
  }

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      userId: json['userId'],
      type: json['type'],
      model: json['model'],
      brand: json['brand'],
      plateNumber: json['plateNumber'],
      carImagePath: json['carImagePath'],
      carImageName: json['carImageName'],
      description: json['description'],
      defaultCar: json['defaultCar'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': _id,
        'userId': userId,
        'type': type,
        'model': model,
        'brand': brand,
        'plateNumber': plateNumber,
        'carImagePath': carImagePath,
        'carImageName': carImageName,
        'description': description,
        'defaultCar': defaultCar,
        'created_at': _created_at,
        'updated_at': _updated_at,
      };

  @override
  toString() {
    return '''
      Car: {
        id: $_id,
        userId: $userId,
        type: $type,
        model: $model,
        brand: $brand,
        plateNumber: $plateNumber,
        carImagePath: $carImagePath,
        carImageName: $carImageName,
        description: $description,
        defaultCar: $defaultCar,
        created_at: $_created_at,
        updated_at: $_updated_at,
      }
    ''';
  }
}
