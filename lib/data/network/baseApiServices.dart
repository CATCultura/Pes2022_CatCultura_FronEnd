import "package:http/http.dart" as http;

abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(http.Client client);

  Future<dynamic> getPostApiResponse(
      String url, dynamic data);

}