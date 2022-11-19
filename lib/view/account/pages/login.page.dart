import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:g20/view/account/components/textField.dart';
import 'package:g20/view/account/pages/stores/loginController.dart';
import 'package:provider/provider.dart';
import '../components/button/ButtonController.dart';
import '../components/button/button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  ButtonController controller = ButtonController(
    ButtonState(
      isLoading: false,
      isDisabled: false,
      text: 'Submit',
    ),
  );

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Spacer(flex: 3),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Login',style: TextStyle(color: Colors.white,fontSize: 25),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Este aplicativo é uma versão de teste alpha 1.0.0, podendo ter instabilidades',style: TextStyle(color: Colors.white,
              ),textAlign: TextAlign.center,),
            ),
            Spacer(flex: 3),
            TextFieldComponent(
              label: 'CNPJ',
            ),
            SizedBox(height: 16),
            TextFieldComponent(
              label: 'Senha',
            ),
            Spacer(),
            Button(
              controller: controller,
              onTap: () async {
                controller.awaitState();
                String result = await context.read<LoginController>().login('123', '123');
                if(result == 'ok'){
                  Navigator.pushReplacementNamed(context, '/ecommerceProvider');
                }else{
                  Fluttertoast.showToast(
                      msg: result,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                }

                controller.stopAwaitState();
              },
            ),
            Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
