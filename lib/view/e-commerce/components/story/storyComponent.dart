import 'package:flutter/material.dart';
import 'package:g20/view/e-commerce/components/category/categoryViewController.dart';

class StoryComponent extends StatelessWidget {
  const StoryComponent({
    Key? key,
    required this.categoryViewController,
  }) : super(key: key);
  final CategoryViewController categoryViewController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: categoryViewController.value.storyControllers.length,
          itemBuilder: (context, index) {
            var item = categoryViewController.value.storyControllers[index];
            bool selected =
                categoryViewController.value.currentStoryController == item;
            if (item.value.filteredProductViewControllers.isEmpty) {
              return Container();
            }
            return Row(
              children: [
                InkWell(
                    onTap: () {
                      categoryViewController.selectStory(item);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 5,
                          ),
                        ],
                        color: selected ? Colors.blue : Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(item.value.story.name,
                            style: TextStyle(
                                color: selected ? Colors.white : Colors.black,
                                fontSize: 15)),
                      ),
                    )),
              ],
            );
          })
    );
  }
}
