

import 'package:dio/dio.dart';
import 'package:g20/core/http/http.Implementation.dart';
import 'package:g20/core/http/http.routes.dart';

import 'core/http/http.dart';
import 'domain/models/user.model.dart';

class MainStances{
  static HttpApiClient httpApiClient = HttpClientDioImpl(dio: Dio());
  static HttpRoutes httpRoutes = HttpRoutes(productionUrl: '', developUrl: 'http://192.168.1.225:8080');
  static late User user;
}