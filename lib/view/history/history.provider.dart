

import 'package:flutter/material.dart';
import 'package:g20/view/history/pages/historyHome.dart';
import 'package:g20/view/results/pages/resultsPage.dart';
import 'package:provider/provider.dart';

import 'historyModuleController.dart';


class HistoryProvider extends StatefulWidget {
  const HistoryProvider({Key? key}) : super(key: key);

  @override
  State<HistoryProvider> createState() => _HistoryProviderState();
}

class _HistoryProviderState extends State<HistoryProvider> {
  // You need to create this key to control what navigator you want to use

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider(create: (_)=> HistoryModuleController(context)..fetchReceiptsHistory())
      ],
      child: const HistoryHome(),
    );
  }
}
