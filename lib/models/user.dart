// ignore_for_file: non_constant_identifier_names

class User {
  String? _id;
  String? _name;
  String _email;
  String? _phoneNumber;
  String? _password;
  String? _type;
  String? _gender;
  String? _headerImagePath;
  String? _profileImagePath;
  String? _created_at;
  String? _updated_at;

  User(
      {id,
      name,
      email,
      phoneNumber,
      password,
      type,
      gender,
      created_at,
      updated_at,
      headerImagePath,
      profileImagePath})
      : _id = id,
        _name = name,
        _email = email,
        _phoneNumber = phoneNumber,
        _password = password,
        _type = type,
        _gender = gender,
        _created_at = created_at,
        _updated_at = updated_at,
        _headerImagePath = headerImagePath,
        _profileImagePath = profileImagePath;

  get id => _id;
  // set id(value) => _id = value;
  get name => _name;
  set name(value) => _name = value;
  get email => _email;
  set email(value) => _email = value;
  get phoneNumber => _phoneNumber;
  set phoneNumber(value) => _phoneNumber = value;
  get password => _password;
  // set password(value) => _password = value;
  get type => _type;
  // set type(value) => _type = value;
  get gender => _gender;
  set gender(value) => _gender = value;
  String? get headerImagePath => _headerImagePath;
  set headerImagePath(value) => _headerImagePath = value;
  String? get profileImagePath => _profileImagePath;
  set profileImagePath(value) => _profileImagePath = value;
  get created_at => _created_at;
  // set created_at(value) => _created_at = value;
  get updated_at => _updated_at;
  // set updated_at(value) => _updated_at = value;

  // User.copy(User from)
  //     : this(
  //         id: from._id,
  //         name: from._name,
  //         email: from._email,
  //         phoneNumber: from._phoneNumber,
  //         password: from._password,
  //         type: from._type,
  //         gender: from._gender,
  //         image: from._image,
  //         created_at: from._created_at,
  //         updated_at: from._updated_at,
  //       );

  factory User.copy(User from) {
    return User(
      id: from._id,
      name: from._name,
      email: from._email,
      phoneNumber: from._phoneNumber,
      password: from._password,
      type: from._type,
      gender: from._gender,
      headerImagePath: from._headerImagePath,
      profileImagePath: from._profileImagePath,
      created_at: from._created_at,
      updated_at: from._updated_at,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      password: json['password'],
      type: json['type'],
      gender: json['gender'],
      headerImagePath: json['headerImagePath'],
      profileImagePath: json['profileImagePath'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
  // User.fromJson(Map<String, dynamic> json)
  //     : this(
  //         id: json['id'],
  //         name: json['name'],
  //         email: json['email'],
  //         phoneNumber: json['phoneNumber'],
  //         password: json['password'],
  //         type: json['type'],
  //         gender: json['gender'],
  //         image: json['image'],
  //         created_at: json['created_at'],
  //         updated_at: json['updated_at'],
  //       );

  Map<String, dynamic> toJson() => {
        'id': _id,
        'name': _name,
        'email': _email,
        'phoneNumber': _phoneNumber,
        'password': _password,
        'type': _type,
        'gender': _gender,
        'headerImagePath': _headerImagePath,
        'profileImagePath': _profileImagePath,
        'created_at': _created_at,
        'updated_at': _updated_at,
      };

  @override
  String toString() {
    return '''
      User: {
        id: $id,
        name: $name,
        email: $email,
        phoneNumber: $phoneNumber,
        type: $type,
        gender: $gender,
        headerImagePath: $headerImagePath,
        profileImagePath: $profileImagePath,
        created_at: $created_at,
        updated_at: $updated_at,
      }
      ''';
  }
}
