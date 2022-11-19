import '../../../../../domain/models/product.model.dart';

class ProductState {
  ProductState({
    required this.product,
  });
  Product product;
}

class IncrementedState extends ProductState {
  IncrementedState({
    required Product product,
  }) : super(product: product);
}

class DecrementedState extends ProductState {
  DecrementedState({
    required Product product,
  }) : super(product: product);
}
