class User {
  String? _id;
  String? _name;
  String _email;
  String? _phoneNumber;
  String? _password;
  String? _type;
  String? _gender;
  dynamic _image;

  User({id, name, email, phoneNumber, password, type, gender, image})
      : _id = id,
        _name = name,
        _email = email,
        _phoneNumber = phoneNumber,
        _password = password,
        _type = type,
        _gender = gender,
        _image = image;

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
  get image => _image;
  set image(value) => _image = value;

  User.copy(User from)
      : this(
          id: from._id,
          name: from._name,
          email: from._email,
          phoneNumber: from._phoneNumber,
          password: from._password,
          type: from._type,
          gender: from._gender,
          image: from._image,
        );

  User.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name'],
          email: json['email'],
          phoneNumber: json['phoneNumber'],
          password: json['password'],
          type: json['type'],
          gender: json['gender'],
          image: json['image'],
        );

  Map<String, dynamic> toJson() => {
        'id': _id,
        'name': _name,
        'email': _email,
        'phoneNumber': _phoneNumber,
        'password': _password,
        'type': _type,
        'gender': _gender,
        'image': _image,
      };

  @override
  String toString() {
    return 'User: {id: $id, name: $name, email: $email, phoneNumber: $phoneNumber, type: $type, gender: $gender, image: $image, }';
  }
}
