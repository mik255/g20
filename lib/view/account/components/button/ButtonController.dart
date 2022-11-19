


import 'package:flutter/cupertino.dart';
class ButtonState {
  ButtonState({
    this.isLoading = false,
    this.isDisabled = false,
    required this.text
  });
 bool isLoading = false;
 bool isDisabled = false;
 String text = 'Submit';
}
class ButtonController extends ValueNotifier<ButtonState> {
  ButtonController(super.value);

  awaitState() {
    value = ButtonState(
      isLoading: true,
      isDisabled: true,
      text: 'Loading...',
    );
  }
  stopAwaitState() {
    value = ButtonState(
      isLoading: false,
      isDisabled: true,
      text: 'sucess',
    );
  }
}