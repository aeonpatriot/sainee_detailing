// ignore_for_file: non_constant_identifier_names

class Book {
  final String? _id;
  final String? _userId;
  final String? _userName;
  String? carId;
  String? carName;
  String? addressId;
  String? serviceId;
  String? serviceName;
  String? date;
  String? timeSlot;
  String? totalPrice;
  String? paymentType;
  String? status;
  final String? _created_at;
  final String? _updated_at;

  Book({
    id,
    userId,
    userName,
    this.carId,
    this.carName,
    this.addressId,
    this.serviceId,
    this.serviceName,
    this.date,
    this.timeSlot,
    this.totalPrice,
    this.paymentType,
    this.status,
    created_at,
    updated_at,
  })  : _id = id,
        _userId = userId,
        _userName = userName,
        _created_at = created_at,
        _updated_at = updated_at;

  String? get id => _id;
  String? get userId => _userId;
  String? get userName => _userName;
  String? get created_at => _created_at;
  String? get updated_at => _updated_at;

  factory Book.copy(Book from) {
    return Book(
      id: from.id,
      userId: from.userId,
      userName: from.userName,
      carId: from.carId,
      carName: from.carName,
      addressId: from.addressId,
      serviceId: from.serviceId,
      serviceName: from.serviceName,
      date: from.date,
      timeSlot: from.timeSlot,
      totalPrice: from.totalPrice,
      paymentType: from.paymentType,
      status: from.status,
      created_at: from.created_at,
      updated_at: from.updated_at,
    );
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      userId: json['userId'],
      userName: json['userName'],
      carId: json['carId'],
      carName: json['carName'],
      addressId: json['addressId'],
      serviceId: json['serviceId'],
      serviceName: json['serviceName'],
      date: json['date'],
      timeSlot: json['timeSlot'],
      totalPrice: json['totalPrice'],
      paymentType: json['paymentType'],
      status: json['status'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': _id,
        'userId': userId,
        'userName': userName,
        'carId': carId,
        'carName': carName,
        'addressId': addressId,
        'serviceId': serviceId,
        'serviceName': serviceName,
        'date': date,
        'timeSlot': timeSlot,
        'totalPrice': totalPrice,
        'paymentType': paymentType,
        'status': status,
        'created_at': _created_at,
        'updated_at': _updated_at,
      };

  @override
  String toString() {
    return '''
      Book: {
        id: $_id,
        userId: $userId,
        userName: $userName,
        carId: $carId,
        carName: $carName,
        addressId: $addressId,
        serviceId: $serviceId,
        serviceName: $serviceName,
        date: $date,
        timeSlot: $timeSlot,
        totalPrice: $totalPrice,
        paymentType: $paymentType,
        status: $status,
        created_at: $_created_at,
        updated_at: $_updated_at,
      }
    ''';
  }
}
