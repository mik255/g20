import 'package:g20/domain/models/story.model.dart';
import '../../product/store/productController.dart';

class StoryState {
  StoryState({
    required this.story,
    required this.productViewControllers,
    required this.filteredProductViewControllers,
    required this.listOfProductsSelected,
  });
  Story story;
  List<ProductViewController> productViewControllers;
  Set<ProductViewController> filteredProductViewControllers;
  Set<ProductViewController> listOfProductsSelected;

}
