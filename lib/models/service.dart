// ignore_for_file: non_constant_identifier_names, unused_field

class Service {
  final String? _id;
  String? name;
  List<String>? details;
  String? smallPrice;
  String? mediumPrice;
  String? largePrice;
  String? suvPrice;
  String? mpvPrice;
  String? _created_at;
  String? _updated_at;

  Service(
      {id,
      this.name,
      required this.details,
      this.smallPrice,
      this.mediumPrice,
      this.largePrice,
      this.suvPrice,
      this.mpvPrice,
      created_at,
      updated_at})
      : _id = id,
        _created_at = created_at,
        _updated_at = updated_at;

  String? get id => _id;

  factory Service.copy(Service from) {
    return Service(
        id: from.id,
        name: from.name,
        details: [...from.details ?? []],
        smallPrice: from.smallPrice,
        mediumPrice: from.mediumPrice,
        largePrice: from.largePrice,
        suvPrice: from.suvPrice,
        mpvPrice: from.mpvPrice);
  }

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['name'],
      details: [...json['details'].split('|')],
      smallPrice: json['smallPrice'],
      mediumPrice: json['mediumPrice'],
      largePrice: json['largePrice'],
      suvPrice: json['suvPrice'],
      mpvPrice: json['mpvPrice'],
    );
  }

  Map<String, dynamic> toJson() => {
        // 'id': _id,
        'name': name,
        'details': _convertListtoString(details!),
        'smallPrice': smallPrice,
        'mediumPrice': mediumPrice,
        'largePrice': largePrice,
        'suvPrice': suvPrice,
        'mpvPrice': mpvPrice,
      };

  String _convertListtoString(List<String> details) {
    String converted = '';
    for (String detail in details) {
      converted = converted + '|' + detail;
    }
    return converted.substring(1);
  }

  @override
  String toString() {
    return '''
      services: {
        id: $id,
        name: $name,
        details: $details,
        smallPrice: $smallPrice,
        mediumPrice: $mediumPrice,
        largePrice: $largePrice,
        suvPrice: $suvPrice,
        mpvPrice: $mpvPrice,
      }
    ''';
  }
}
