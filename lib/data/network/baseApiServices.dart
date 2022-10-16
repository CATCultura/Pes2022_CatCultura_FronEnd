import "package:http/http.dart" as http;

abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url);

  Future<dynamic> getPostApiResponse(
      String url, dynamic data);

}