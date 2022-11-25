import 'package:flutter/material.dart';
import 'package:g20/view/results/pages/resultsPage.dart';
import 'package:provider/provider.dart';
import 'moduleResultController.dart';

class ResultProvider extends StatefulWidget {
  const ResultProvider({Key? key}) : super(key: key);

  @override
  State<ResultProvider> createState() => _ResultProviderState();
}

class _ResultProviderState extends State<ResultProvider> {
 // You need to create this key to control what navigator you want to use

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider(create: (_)=> ResultsModuleController(context)..fetchByDate(DateTime.now(),DateTime.now()))
      ],
      child: ChartResultsPage(),
    );
  }
}
