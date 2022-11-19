import '../product/store/productController.dart';

enum BagTypee {
  homeBag,
  casherBag,
  paymentBag,
  receiveBag
}
class BagState {
  BagState({
    required this.leftValue,
    required this.nameButton,
    this.errorMessage,
    this.enable = false,
    required this.onPressed,
    required this.bagType,
    required this.currentProduct

  });
  BagTypee bagType;
  double leftValue;
  String nameButton;
  String? errorMessage;
  bool enable;
  Function onPressed;
  ProductViewController? currentProduct;
}

