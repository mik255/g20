import 'package:flutter/material.dart';
import 'package:g20/view/e-commerce/components/bag/bagState.dart';
import 'package:g20/view/e-commerce/components/product/store/ProductState.dart';

import '../../../../domain/models/product.model.dart';
import '../product/store/productController.dart';


class BagController extends ValueNotifier<BagState> {
  BagController(super.value);

  double total = 0;
  onPressed(Function onPressed) {
    value.onPressed = onPressed;
  }

  bool verifyIfEnable() {
    return total > 0;
  }
  setBagType(BagTypee type) {
    _setState(type);
  }
  void _setState(BagTypee type) {
    switch (type) {
      case BagTypee.homeBag:
        value = BagState(
            bagType: type,
            leftValue: total,
            nameButton: 'Caixa',
            onPressed: value.onPressed,
            enable: verifyIfEnable(),
            currentProduct: value.currentProduct,
            canRemoveProduct: true,
        );
        break;
      case BagTypee.casherBag:
        value = BagState(
            bagType: type,
            leftValue: total,
            nameButton: 'Pagamento',
            onPressed: value.onPressed,
            enable: verifyIfEnable(),
            currentProduct: value.currentProduct,
            canRemoveProduct: true
        );
        break;
      case BagTypee.paymentBag:
        value = BagState(
            bagType: type,
            leftValue: total,
            nameButton: 'Recibo',
            onPressed: value.onPressed,
            enable: verifyIfEnable(),
            currentProduct: value.currentProduct,
            canRemoveProduct: false
        );
        break;
        case BagTypee.receiveBag:
        value = BagState(
            bagType: type,
            leftValue: total,
            nameButton: 'Salvar',
            onPressed: value.onPressed,
            enable: verifyIfEnable(),
            currentProduct: value.currentProduct,
            canRemoveProduct: false
        );
        break;
    }
  }

  void increment(double price, {required BagTypee type,required ProductViewController currentProduct}) {
    value.currentProduct = currentProduct;
    total += price;
    _setState(type);
  }

  void decrement(double price, {required BagTypee type,required ProductViewController currentProduct}) {
    value.currentProduct = currentProduct;
    total -= price;
    _setState(type);
  }

}
