import 'package:dio/dio.dart';
import 'package:g20/core/http/http.Implementation.dart';
import '../core/http/http.routes.dart';
import 'account.dart';
import 'package:g20/core/http/http.dart';

class MainStatics {
  static Account? account = Account();
  static HttpApiClient httpClient = HttpClientDioImpl(dio: Dio());
  static HttpRoutes httpRoutes = HttpRoutes(
    productionUrl: 'https://g20-api.herokuapp.com',
    developUrl: 'http://demo6271311.mockable.io/',
  );
}
