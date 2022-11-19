import 'package:flutter/material.dart';
import 'package:g20/view/account/components/button/ButtonController.dart';

class Button extends StatelessWidget {
  Button({Key? key, required this.controller,required this.onTap}) : super(key: key);
  ButtonController controller;
  void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ButtonState>(
        valueListenable: controller,
        builder: (context, state, snapshot) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child:  Center(
                  child: !state.isLoading? Text(
                    'Entrar',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ):const Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
          );
        });
  }
}
