import 'package:flutter/material.dart';
import 'package:g20/view/e-commerce/components/story/store/storyController.dart';

class CheckoutTitleItem extends StatelessWidget {
  const CheckoutTitleItem({Key? key, required this.storyViewController})
      : super(key: key);
  final StoryViewController storyViewController;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable:storyViewController,
        builder: (ctx, state, child) {
          return ListTile(
            leading: const Icon(Icons.store,color: Colors.white,),
            title: Text(
              storyViewController.value.story.name,
              style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              'total : ${storyViewController.getTotal()}',
              style: const TextStyle(color: Colors.white),
            ),
          );
        }

    );
  }
}
