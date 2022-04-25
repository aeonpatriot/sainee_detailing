class User {
  final String? _id;
  final String _name;
  final String _email;
  final String? _password;
  final String _type;
  final dynamic _image;

  User({id, name, email, password, type, image})
      : _id = id,
        _name = name,
        _email = email,
        _password = password,
        _type = type,
        _image = image;

  get id => _id;
  // set id(value) => _id = value;
  get name => _name;
  // set name(value) => _name = value;
  get email => _email;
  // set email(value) => _email = value;
  get password => _password;
  // set password(value) => _password = value;
  get type => _type;
  // set type(value) => _type = value;
  get image => _image;
  // set image(value) => _image = value;

  User.copy(User from)
      : this(
          id: from._id,
          name: from._name,
          email: from._email,
          password: from._password,
          type: from._type,
          image: from._image,
        );

  User.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name'],
          email: json['email'],
          password: json['password'],
          type: json['type'],
          image: json['image'],
        );

  Map<String, dynamic> toJson() => {
        'id': _id,
        'name': _name,
        'email': _email,
        'password': _password,
        'type': _type,
        'image': _image,
      };
}
