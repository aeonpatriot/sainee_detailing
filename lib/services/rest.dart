abstract class Rest {
  Future get(String endpoint);
  Future post(String endpoint, {dynamic data});
}
