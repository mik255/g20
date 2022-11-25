class HttpRoutes{
  HttpRoutes({
    required this.productionUrl,
    required this.developUrl,
  }){
    if(const String.fromEnvironment('Production') == 'true') {
      baseUrl = productionUrl;
    } else {
      baseUrl = developUrl;
    }
  }
  String productionUrl;
  String developUrl;
  late String baseUrl;
  String get login => '$baseUrl/login';
  String get register => '$baseUrl/register';
  String get categories => '$baseUrl/category';
  String get historyReceipts => '$baseUrl/historyReceipt';
  String get orders => '$baseUrl/orders';
  String get receipt => '$baseUrl/receipts';
  String get userResults => '$baseUrl/users/results';
}