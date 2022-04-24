class User {
  String _id;
  String _name;
  String _email;
  String _password;
  String _type;
  dynamic _image;

  User({id, name, email, password, type, image})
      : this._id = id,
        this._name = name,
        this._email = email,
        this._password = password,
        this._type = type,
        this._image = image;

  get id => _id;
  set id(value) => _id = value;
  get name => _name;
  set name(value) => _name = value;
  get email => _email;
  set email(value) => _email = value;
  get password => _password;
  set password(value) => _password = value;
  get type => _type;
  set type(value) => _type = value;
  get image => _image;
  set image(value) => _image = value;

  User.copy(User from)
      : this(
          id: from.id,
          name: from.name,
          email: from.email,
          password: from.password,
          type: from.type,
          image: from.image,
        );

  User.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: ['name'],
          email: ['email'],
          password: ['password'],
          type: ['type'],
          image: ['image'],
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
        'type': type,
        'image': image,
      };
}
