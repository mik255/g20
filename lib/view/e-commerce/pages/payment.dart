import 'package:flutter/material.dart';
import 'package:g20/domain/models/story.model.dart';
import 'package:g20/view/e-commerce/components/Payment/PaymentItemCompenent.dart';
import 'package:g20/view/e-commerce/pages/receive.dart';
import 'package:provider/provider.dart';
import '../components/Payment/alertWidget.dart';
import '../components/Payment/store/paymentController.dart';
import '../components/Payment/store/paymentState.dart';
import '../components/bag/bagComponent.dart';
import '../components/bag/bagState.dart';
import '../components/story/store/storyController.dart';
import '../moduleController.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    ModuleController appController = context.read<ModuleController>();
    appController.categoryViewController
        .buildListOfStoriesWithProductsSelected();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Payment"),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const AlertWidget(),
                  ListView(
                    shrinkWrap: true,
                    children: appController.categoryViewController.value
                        .storiesWithProductsSelected
                        .map((StoryViewController storyViewController) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PaymentComponent(
                            paymentController: PaymentController(PaymentState()),
                            storyViewController: storyViewController),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BagComponent(
                  bagController: appController.categoryViewController.bagController,
                  onPressed: () {
                    appController.navigator(const Receive());
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
