class Address {
  String? _id;
  String? _userId;
  String? _name;
  String? _phoneNumber;
  String? _state;
  String? _city;
  String? _postcode;
  String? _addressLine1;
  String? _defaultAddress;
  String? _latitude;
  String? _longitude;
  String? _created_at;
  String? _updated_at;

  Address(
      {id,
      userId,
      name,
      phoneNumber,
      state,
      city,
      postcode,
      addressLine1,
      defaultAddress,
      latitude,
      longitude,
      created_at,
      updated_at})
      : _id = id,
        _userId = userId,
        _name = name,
        _phoneNumber = phoneNumber,
        _state = state,
        _city = city,
        _postcode = postcode,
        _addressLine1 = addressLine1,
        _defaultAddress = defaultAddress,
        _latitude = latitude,
        _longitude = longitude,
        _created_at = created_at,
        _updated_at = updated_at;

  get id => _id;
  get userId => _userId;
  // set userId(value) => _userId = value;
  get name => _name;
  set name(value) => _name = value;
  get phoneNumber => _phoneNumber;
  set phoneNumber(value) => _phoneNumber = value;
  get state => _state;
  set state(value) => _state = value;
  get city => _city;
  set city(value) => _city = value;
  get postcode => _postcode;
  set postcode(value) => _postcode = value;
  get addressLine1 => _addressLine1;
  set addressLine1(value) => _addressLine1 = value;
  get defaultAddress => _defaultAddress;
  set defaultAddress(value) => _defaultAddress = value;
  get latitude => _latitude;
  set latitude(value) => _latitude = value;
  get longitude => _longitude;
  set longitude(value) => _longitude = value;
  get created_at => _created_at;
  // set created_at(value) => _created_at = value;
  get updated_at => _updated_at;
  // set updated_at(value) => _updated_at = value;

  // Address.copy(Address from)
  //     : this(
  //         id: from.id,
  //         userId: from.userId,
  //         name: from.name,
  //         phoneNumber: from.phoneNumber,
  //         state: from.state,
  //         city: from.city,
  //         postcode: from.postcode,
  //         addressLine1: from.addressLine1,
  //         defaultAddress: from.defaultAddress,
  //         latitude: from.latitude,
  //         longitude: from.longitude,
  //         created_at: from.created_at,
  //         updated_at: from.updated_at,
  //       );

  factory Address.copy(Address from) {
    return Address(
      id: from.id,
      userId: from.userId,
      name: from.name,
      phoneNumber: from.phoneNumber,
      state: from.state,
      city: from.city,
      postcode: from.postcode,
      addressLine1: from.addressLine1,
      defaultAddress: from.defaultAddress,
      latitude: from.latitude,
      longitude: from.longitude,
      created_at: from.created_at,
      updated_at: from.updated_at,
    );
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      state: json['state'],
      city: json['city'],
      postcode: json['postcode'],
      addressLine1: json['addressLine1'],
      defaultAddress: json['defaultAddress'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }

  // Address.fromJson(Map<String, dynamic> json)
  //     : this(
  //         id: json['id'],
  //         userId: json['userId'],
  //         name: json['name'],
  //         phoneNumber: json['phoneNumber'],
  //         state: json['state'],
  //         city: json['city'],
  //         postcode: json['postcode'],
  //         addressLine1: json['addressLine1'],
  //         defaultAddress: json['defaultAddress'],
  //         latitude: json['latitude'],
  //         longitude: json['longitude'],
  //         created_at: json['created_at'],
  //         updated_at: json['updated_at'],
  //       );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'name': name,
        'phoneNumber': phoneNumber,
        'state': state,
        'city': city,
        'postcode': postcode,
        'addressLine1': addressLine1,
        'defaultAddress': defaultAddress,
        'latitude': latitude,
        'longitude': longitude,
        'created_at': created_at,
        'updated_at': updated_at,
      };

  @override
  String toString() {
    return 'Address: {id: $id, userId: $userId, name: $name, phoneNumber: $phoneNumber, state: $state, city: $city, postcode: $postcode, addressLine1: $addressLine1, defaultAddress: $defaultAddress, latitude: $latitude, longitude: $longitude, created_at: $created_at, updated_at: $updated_at}';
  }
}
