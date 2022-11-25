import 'package:flutter/material.dart';
import 'package:g20/shared/widgets/GenericError.dart';
import 'package:g20/view/results/pages/filterPage.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';
import '../../../domain/models/results.model.dart';
import '../../../shared/formats.dart';
import '../components/filter/filterComponent.dart';
import '../moduleResultController.dart';

class ChartResultsPage extends StatelessWidget {
  ChartResultsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ResultsModuleController resultsModuleController =
        context.read<ResultsModuleController>();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text("Resultados",style: TextStyle(color: Colors.white),),
          actions: [
            ElevatedButton(
                onPressed: () {
                  resultsModuleController.navigator(FilterPage());
                },
                child: const Text('filtrar')),
          ],
        ),
        backgroundColor: Colors.blue,
        body: ValueListenableBuilder<ResultsState>(
            valueListenable: resultsModuleController,
            builder: (ctx, state, child) {
              if (state.results == null && !state.isLoading) {
                return const GenericError(
                    title: "null exception",
                    subtitle:
                        "Um erro aconteceu, tente noivamente mais tarde, ou fale com o nosso suporte",
                    errorCode: 'NullResultExeption');
              }
              return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(height: 16),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 2),
                              )
                            ],
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              FilterComponent(),
                              if (state.isLoading)
                                const Expanded(
                                    child: Center(
                                        child: CircularProgressIndicator()))
                              else
                                Expanded(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 40.0),
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.topCenter,
                                              child: CircularPercentIndicator(
                                                radius: 90.0,
                                                lineWidth: 7.0,
                                                animation: true,
                                                backgroundColor:
                                                    Colors.red[200]!,
                                                percent: state
                                                    .results!.marginProfit/100,
                                                center: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Lucro com G20',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontSize: 18.0,
                                                          color:
                                                              Colors.grey[700]),
                                                    ),
                                                    Text(
                                                      formatMoney(state
                                                          .results!.g20total),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 25.0,
                                                          color:
                                                              Colors.grey[700]),
                                                    ),
                                                  ],
                                                ),
                                                footer: const Text(
                                                  "",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17.0),
                                                ),
                                                circularStrokeCap:
                                                    CircularStrokeCap.butt,
                                                progressColor:
                                                    Colors.blue[200]!,
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Container(
                                                height: 90,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                      spreadRadius: 5,
                                                      blurRadius: 7,
                                                      offset:
                                                          const Offset(0, 2),
                                                    )
                                                  ],
                                                  color: Colors.white,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      const Text(
                                                          "Margem de lucro"),
                                                      Text(
                                                          "${state.results!.marginProfit}%"),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          _customContainer(
                                              'Com G20',
                                              state.results!.g20Price,
                                              Colors.blue[200]!),
                                          _customContainer(
                                              'Preço da praça',
                                              state.results!.priceSquare,
                                              Colors.red[200]!),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            _customContainer2(
                                              'Total de Vendas',
                                              Colors.white,
                                              text:  state.results!.totalOrders.toString(),
                                              value: 50,
                                            ),
                                            _customContainer2(
                                              'Ticket Médio',
                                              Colors.white,
                                              value: 50.00,
                                              text:  state.results!.ticket.toString(),
                                            ),
                                          ],
                                        ),
                                      ),

                                      const Spacer(),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ));
            }));
  }

  Widget _customContainer(String titulo, double value, Color color) {
    return Container(
      height: 100,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 2,
            offset: Offset(0, 2),
          )
        ],
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  titulo,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            Flexible(
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text(formatMoney(value))),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _customContainer2(String titulo, Color color,
      {required String text, required double value}) {
    return Container(
      height: 70,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 2),
          )
        ],
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Text(
                titulo,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            Expanded(
              child: Center(child: Text(text)),
            )
          ],
        ),
      ),
    );
  }
}

