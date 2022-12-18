import 'package:flutter/material.dart';
import 'package:g20/core/http/http.Request.dart';
import '../../../../core/http/http.Response.dart';
import '../../../../domain/models/user.model.dart';
import '../../../../mainStances.dart';

class LoginController extends ValueNotifier<bool>{
  LoginController(super.value);

  Future<String> login(String cnpj, String password) async {
    HttpApiResponse httpApiResponse = await MainStances.httpApiClient.request(
        HttpApiRequest(
      url: MainStances.httpRoutes.login,
      method: 'POST',
      body: {
        "cnpj":cnpj,
        "password":password
      }
    ));
    if(httpApiResponse.statusCode == 200){
      try{
        MainStances.user = User.fromMap(httpApiResponse.data);
      }catch(e,_){
        print(_);
      }
      return 'ok';
    }else{
      return 'Cnpj ou senha incorretas';
    }
  }
}
