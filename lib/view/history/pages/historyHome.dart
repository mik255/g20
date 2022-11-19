

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/historyCardComponent.dart';
import '../historyModuleController.dart';

class HistoryHome extends StatelessWidget {
  const HistoryHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HistoryModuleController historyModuleController = context.read<HistoryModuleController>();
    return Scaffold(
      appBar: AppBar(title: Text("Histórico"),),
        body: ValueListenableBuilder<HistoryState>(
          valueListenable: historyModuleController,
          builder: (BuildContext context, value, Widget? child) {
            if(value.isLoading){
              return const Center(child: CircularProgressIndicator(),);
            }
            return ListView.builder(
              itemCount: value.receipts!.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
                  child: HistoryCardComponent(
                    receipt: value.receipts![index],
                  ),
                );
              },

            );
          },
        ));
  }
}
