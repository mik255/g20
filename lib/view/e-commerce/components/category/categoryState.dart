



import 'package:g20/domain/models/category.model.dart';

import '../story/store/storyController.dart';

class CategoryState{
  CategoryState({
    required this.category,
     required this.storyControllers,
     required this.currentStoryController,
     required this.storiesWithProductsSelected,
  });
  Category category;
  List<StoryViewController> storyControllers = [];
  List<StoryViewController> storiesWithProductsSelected = [];
  StoryViewController? currentStoryController;
}