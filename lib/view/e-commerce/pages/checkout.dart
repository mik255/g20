import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:g20/view/e-commerce/pages/payment.dart';
import 'package:provider/provider.dart';
import '../../e-commerce/components/category/categoryState.dart';
import '../../e-commerce/components/bag/bagComponent.dart';
import '../../e-commerce/components/product/checkoutProductItem.dart';
import '../../e-commerce/components/story/checkoutTitleItem.dart';
import '../components/bag/bagState.dart';
import '../moduleController.dart';

class Checkout extends StatefulWidget {
  const Checkout({
    Key? key,
  }) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  String observationText = '';

  @override
  Widget build(BuildContext context) {
    ModuleController appController = context.read<ModuleController>();
    appController.categoryViewController
        .buildListOfStoriesWithProductsSelected();
    context.read<ModuleController>().categoryViewController.bagType =
        BagTypee.casherBag;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: const Text("Checkout"),
          actions: [
            InkWell(
              onTap: () {
                showModalBottomSheet<void>(
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25.0))),
                  context: context,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Icon(
                                      Icons.close,
                                      color: Colors.black54,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            ListTile(
                              leading: const Icon(Icons.edit),
                              title: TextField(
                                  maxLines: 10,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Observação',
                                      hintText: 'Escreva algo aqui...'),
                                  onChanged: (String value) {
                                    observationText = value;
                                  }),
                            ),
                            ElevatedButton(
                                child: const Text('Salvar'),
                                onPressed: () {
                                  appController.setObservation(observationText);
                                  Navigator.of(context).pop();
                                  Fluttertoast.showToast(
                                      msg: 'Salvo com sucesso',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.white,
                                      textColor: Colors.blue,
                                      fontSize: 16.0
                                  );
                                }),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Icon(Icons.edit),
                    SizedBox(
                      width: 4,
                    ),
                    Text('Observação'),
                  ],
                ),
              ),
            )
          ],
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        ValueListenableBuilder<CategoryState>(
                            valueListenable:
                                appController.categoryViewController,
                            builder: (ctx, state, widget) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    state.storiesWithProductsSelected.length,
                                itemBuilder: (context, index) {
                                  var storeController =
                                      state.storiesWithProductsSelected[index];
                                  return Card(
                                    elevation: 5,
                                    color: Colors.blue,
                                    child: Column(
                                      children: [
                                        CheckoutTitleItem(
                                          storyViewController: storeController,
                                        ),
                                        Divider(),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: storeController.value
                                                .listOfProductsSelected.length,
                                            itemBuilder: (context, index) {
                                              var productController =
                                                  storeController.value
                                                      .listOfProductsSelected
                                                      .toList()[index];
                                              if (productController
                                                      .value.product.count ==
                                                  0) {
                                                return Container();
                                              }
                                              return CheckoutProductItem(
                                                  productController:
                                                      productController);
                                            }),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }),
                        const SizedBox(
                          height: 120,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BagComponent(
                  bagController:
                      appController.categoryViewController.bagController,
                  onPressed: () {
                    appController.categoryViewController.bagController
                        .setBagType(BagTypee.paymentBag);
                    appController.navigator(const PaymentPage());
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
