import 'package:flutter/material.dart';
import 'package:g20/view/results/moduleResultController.dart';
import 'package:provider/provider.dart';

class FilterComponent extends StatelessWidget {
   FilterComponent({Key? key}) : super(key: key);
  late final ResultsModuleController resultsModuleController;

  @override
  Widget build(BuildContext context) {
    resultsModuleController = context.read<ResultsModuleController>();
    return ValueListenableBuilder<ResultsState>(
      valueListenable: resultsModuleController,
      builder: (ctx,state,child){
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            InkWell(
                onTap: () async {
                  resultsModuleController.filterTranslate(1);
                },
                child: const Icon(Icons.keyboard_arrow_left)),
             Text(state.currentFilterDateName),
            InkWell(
              child: const Icon(Icons.keyboard_arrow_right),
              onTap: () async {
                resultsModuleController.filterTranslate(-1);
              },
            ),
          ]),
        ),
      );}
    );
  }
}
