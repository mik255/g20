import 'package:flutter/material.dart';

class TextFieldComponent extends StatelessWidget {
  TextFieldComponent({Key? key, required this.label,this.onChange}) : super(key: key);
  final String label;
  Function(String value)? onChange;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,

        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: label,
        labelStyle: const TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w300),
      ),
    );
  }
}
