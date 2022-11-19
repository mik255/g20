import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../moduleResultController.dart';

class FilterPage extends StatefulWidget {
  FilterPage({Key? key,}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
   DateTime selectStart = DateTime.now();
   DateTime selectEnd = DateTime.now();

  late final ResultsModuleController resultsModuleController;

  Future<DateTime?> _selectDate(BuildContext context, DateTime select) async {
    return await showDatePicker(
        context: context,
        initialDate: select,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
  }
  @override
  initState(){
    resultsModuleController = context.read<ResultsModuleController>();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder<ResultsState>(
            valueListenable: resultsModuleController,
            builder: (ctx, state, child) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              var picked = await _selectDate(context, selectStart);
                              if (picked != null && picked != selectStart) {
                                selectStart = picked;
                              }

                            },
                            child:  Text('start')),
                        ElevatedButton(
                            onPressed: () async {
                              var picked = await _selectDate(context, selectEnd);
                              if (picked != null && picked != selectEnd) {
                                selectEnd = picked;
                              }
                            },
                            child: Text('end'))
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          resultsModuleController.searchFilter(Dates.custom
                              ,start: selectStart,end: selectEnd
                          );
                        },
                        child: const Text('Filtrar'))
                  ],
                ),
              );
            }));
  }
}
