import 'package:flutter/material.dart';
import 'package:g20/domain/models/paymentType.model.dart';
import 'package:g20/view/e-commerce/components/Payment/store/paymentState.dart';

class PaymentController extends ValueNotifier<PaymentState> {
  PaymentController(super.value);

   void select(PaymentType paymentType ) {
    value = PaymentState(
        paymentType:paymentType
    );
  }
}
