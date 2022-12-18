import 'package:flutter/cupertino.dart';
import '../../../../domain/models/product.model.dart';
import '../../../e-commerce/components/bag/bagController.dart';
import '../../../e-commerce/components/bag/bagState.dart';
import '../../../e-commerce/components/category/categoryState.dart';
import '../../../e-commerce/components/story/store/storyController.dart';
import '../../../e-commerce/components/story/store/storyState.dart';
import '../product/store/ProductState.dart';
import '../product/store/productController.dart';

class CategoryViewController extends ValueNotifier<CategoryState> {
  CategoryViewController(super.value) {
    bagType = BagTypee.casherBag;
    bagController = BagController(
      BagState(
        bagType: bagType,
        leftValue: 0,
        nameButton: 'Pagamento',
        enable: false,
        onPressed: () {},
        currentProduct: null,
          canRemoveProduct: true
      ),
    );

    var storyList = value.category.stories.map((story) {
      var products = productViewControllerBuild(story.productList);
      return StoryViewController(
        StoryState(
            story: story,
            productViewControllers: products,
            filteredProductViewControllers: products.toSet(),
            listOfProductsSelected: {}),
      );
    }).toList();
    value = CategoryState(
        category: value.category,
        storyControllers: storyList,
        currentStoryController: storyList.first,
        storiesWithProductsSelected: []);
  }

  late BagController bagController;
  late BagTypee bagType;
  Function(CategoryState)? onUpdate;

  void selectStory(StoryViewController storyViewController) {
    value = CategoryState(
      category: value.category,
      storyControllers: value.storyControllers,
      currentStoryController: storyViewController,
      storiesWithProductsSelected: value.storiesWithProductsSelected,
    );
    onUpdate?.call(value);
  }

  List<ProductViewController> productViewControllerBuild(
      List<Product> products) {
    return products.map((element) {
      return ProductViewController(
        ProductState(product: element),
      )..onUpdate = (ProductViewController state) {
        for (var element in products) {
          element.isSelected =false;
        }
        state.value.product.isSelected = true;
          if (state.value is IncrementedState) {
            bagController.increment(state.value.product.price, type: bagType,currentProduct:state);
          } else if (state.value is DecrementedState) {
            bagController.decrement(state.value.product.price, type: bagType,currentProduct:state);
          }
        value.currentStoryController?.value.productViewControllers.forEach((element) {
          element.notifyListeners();
        });
          for (var element in value.storiesWithProductsSelected) {
            element.notifyListeners();
          }
        };
    }).toList();
  }

  void searchProduct(String search) {
    for (var element in value.storyControllers) {
      element.searchProduct(search);
    }
    notifyListeners();
  }

  bool storiesIsEmpty() {
    return value.storyControllers
        .where((element) =>
            element.value.filteredProductViewControllers.isNotEmpty)
        .isEmpty;
  }

  bool isStorySearchIsEmpty() {
    return value
        .currentStoryController!.value.filteredProductViewControllers.isEmpty;
  }

  List<StoryViewController> buildListOfStoriesWithProductsSelected() {
    return value.storiesWithProductsSelected = value.storyControllers
        .where((element) => element.buildListOfProductsSelected().isNotEmpty)
        .toList();
  }
}
