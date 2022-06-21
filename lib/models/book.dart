// ignore_for_file: non_constant_identifier_names

class Book {
  final String? _id;
  final String? _userId;
  String? carId;
  String? addressId;
  String? serviceId;
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
    this.carId,
    this.addressId,
    this.serviceId,
    this.date,
    this.timeSlot,
    this.totalPrice,
    this.paymentType,
    this.status,
    created_at,
    updated_at,
  })  : _id = id,
        _userId = userId,
        _created_at = created_at,
        _updated_at = updated_at;

  String? get id => _id;
  String? get userId => _userId;
  String? get created_at => _created_at;
  String? get updated_at => _updated_at;

  factory Book.copy(Book from) {
    return Book(
      id: from.id,
      userId: from.userId,
      carId: from.carId,
      addressId: from.addressId,
      serviceId: from.serviceId,
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
      carId: json['carId'],
      addressId: json['addressId'],
      serviceId: json['serviceId'],
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
        'carId': carId,
        'addressId': addressId,
        'serviceId': serviceId,
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
        carId: $carId,
        addressId: $addressId,
        serviceId: $serviceId,
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
