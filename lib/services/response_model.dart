class Response {
  final String _status;
  final String _message;
  final dynamic _data;

  Response({status, message, data})
      : _status = status,
        _message = message,
        _data = data;

  get status => _status;
  get message => _message;
  get data => _data;

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }

  @override
  String toString() {
    return ''' 
      Response: {
        status: $status,
        message: $message,
      }
    ''';
  }
}
