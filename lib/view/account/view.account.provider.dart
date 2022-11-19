import 'package:flutter/cupertino.dart';
import 'package:g20/view/account/pages/login.page.dart';
import 'package:g20/view/account/pages/stores/loginController.dart';
import 'package:provider/provider.dart';



class LoginProvider extends StatelessWidget {
  const LoginProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ListenableProvider<LoginController>(
        create: (_) => LoginController(false),
      ),
    ], child: LoginPage());
  }
}
