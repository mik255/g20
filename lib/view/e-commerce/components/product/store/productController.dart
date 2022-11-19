import 'package:flutter/material.dart';
import 'IProductController.dart';
import 'ProductState.dart';

class ProductViewController extends ValueNotifier<ProductState> implements IProductController {
  ProductViewController(super.value);
   Function(ProductViewController)? onUpdate;
  @override
  void increment() {
    value.product.count++;
    value = IncrementedState(
      product: value.product,
    );
    onUpdate?.call(this);

  }
  @override
  void decrement() {
    value.product.count--;
    value = DecrementedState(
      product: value.product,
    );
    onUpdate?.call(this);
  }
  @override
  getTotal() {
    return value.product.count * value.product.price;
  }
  clean(){
    value.product.count = 0;
    onUpdate?.call(this);
    notifyListeners();
  }
}
