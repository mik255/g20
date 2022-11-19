import 'package:flutter/cupertino.dart';
import 'package:g20/view/e-commerce/components/story/store/storyState.dart';
import '../../../../../domain/models/paymentType.model.dart';
import '../../product/store/productController.dart';

class StoryViewController extends ValueNotifier<StoryState> {
  StoryViewController(StoryState state) : super(state);

  select(){
    value = StoryState(
      story: value.story,
      productViewControllers: value.productViewControllers,
      filteredProductViewControllers: value.filteredProductViewControllers,
      listOfProductsSelected: value.listOfProductsSelected,
    );
  }
  deselect(){
    value = StoryState(
      story: value.story,
      productViewControllers: value.productViewControllers,
      filteredProductViewControllers: value.filteredProductViewControllers,
      listOfProductsSelected: value.listOfProductsSelected,
    );
  }
  selectProduct(ProductViewController productViewController) {
    productViewController.increment();
    notifyListeners();
  }

  deselectProduct(ProductViewController productViewController) {
    productViewController.decrement();
    notifyListeners();
  }

  void searchProduct(String search) {
    if (search.isEmpty) {
      value = StoryState(
        story: value.story,
        productViewControllers: value.productViewControllers,
        filteredProductViewControllers: value.productViewControllers.toSet(),
        listOfProductsSelected: value.listOfProductsSelected,
      );
    } else {
      var result = value.productViewControllers.where((element) {
        return element.value.product.name
            .toLowerCase()
            .contains(search.toLowerCase());
      }).toSet();
      value = StoryState(
        story: value.story,
        productViewControllers: value.productViewControllers,
        filteredProductViewControllers: result,
        listOfProductsSelected: value.listOfProductsSelected,
      );
    }
  }
  List<ProductViewController> buildListOfProductsSelected(){
     value.listOfProductsSelected = value.productViewControllers.where((element) {
      return element.value.product.count > 0;
    }).toSet();
     return value.listOfProductsSelected.toList();
  }
  double getTotal(){
    return value.listOfProductsSelected.fold(0, (total, element) {
      return total + element.value.product.count * element.value.product.price;
    });
  }
  void setPaymentMethod(PaymentType paymentType){
    value.story.paymentType = paymentType.name;
  }
}
