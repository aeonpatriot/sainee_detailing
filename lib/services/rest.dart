abstract class Rest {
  String? _apiToken;
  set apiToken(value) => _apiToken = value;
  get apiToken => _apiToken;
  Future get(String endpoint);
  Future post(String endpoint, {dynamic data});
  Future postWithToken(String endpoint, {dynamic data});
  Future putWithToken(String endpoint, {dynamic data});
}
