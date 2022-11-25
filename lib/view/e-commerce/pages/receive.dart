import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:g20/domain/models/order.model.dart';
import 'package:g20/view/e-commerce/components/bag/bagController.dart';
import 'package:g20/view/e-commerce/components/product/store/productController.dart';
import 'package:g20/view/e-commerce/components/story/store/storyController.dart';
import 'package:g20/view/e-commerce/pages/receiptSucessPage.dart';
import 'package:provider/provider.dart';

import '../../../core/http/http.ErrorsHandle.dart';
import '../../../core/http/http.Request.dart';
import '../../../core/http/http.Response.dart';
import '../../../mainStances.dart';
import '../../../shared/widgets/GenericError.dart';
import '../components/bag/bagComponent.dart';
import '../components/bag/bagState.dart';
import '../components/product/store/ProductState.dart';
import '../components/receipt/card.dart';
import '../components/story/store/storyState.dart';
import '../moduleController.dart';
class ReceiptState{}
class ReceiptStateValue extends ReceiptState{
  Receipt receipt;
  ReceiptStateValue({required this.receipt});
}
class ReceiptStateLoading extends ReceiptState{}
class ReceiptStateSucess extends ReceiptState{}
//teste
class ReceiptController extends ValueNotifier<ReceiptState>{
  ReceiptController(super.value);
  late Receipt cachedReceipt;
  setLoading(){
   value = ReceiptStateLoading();
  }
  Future<void> saveReceipt() async{
     cachedReceipt = (value as ReceiptStateValue).receipt;
    value = ReceiptStateLoading();
    try {
      HttpApiResponse httpApiResponse = await MainStances.httpApiClient.request(
          HttpApiRequest(
              url: MainStances.httpRoutes.receipt,
              method: 'POST',
              body: cachedReceipt.toJson()
          ));
      if (httpApiResponse.statusCode == 200) {
        value = ReceiptStateSucess();
        return;
      }
    } on HttpError catch (e, _) {
      Fluttertoast.showToast(
          msg: e.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
      print(_);
    }
    catch (e, _) {
      print(_);
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
  back(){
    value = ReceiptStateValue(
      receipt: cachedReceipt
    );
    notifyListeners();
  }
}
class Receive extends StatelessWidget {
  const Receive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ModuleController appController = context.read<ModuleController>()..buildReceipt();
   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     appController.categoryViewController.bagController.setBagType(BagTypee.receiveBag);
   });

    return ValueListenableBuilder<EcommerceState>(
        valueListenable: appController,
        builder: (BuildContext context, value, Widget? child) {
          return ReceiptPage(
              receiptController: appController.receiptController
              ,bagController:appController.categoryViewController.bagController);
        });
  }
}
class ReceiptPage extends StatelessWidget {
   ReceiptPage({Key? key,required this.receiptController,required this.bagController}) : super(key: key);
 ReceiptController receiptController;
 BagController bagController;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (BuildContext context, state, Widget? child) {
        if (state is ReceiptStateSucess) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.push(context,MaterialPageRoute(builder:(ctx)=> ThankYouPage(title: '',onBack:(){
              Navigator.pushReplacementNamed(context, '/ecommerceProvider');
             // receiptController.back();
            })));
          });
        }
        if(state is ReceiptStateValue){
          return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Icon(Icons.arrow_back)),
                                const SizedBox(
                                  width: 25,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Recibo",
                                      style: TextStyle(
                                        color: Color(0xff292929),
                                        fontSize: 16,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "${state.receipt.attributes.stories.length}"
                                          " Lojas selecionadas",
                                      style: const TextStyle(
                                        color: Color(0xff9a9a9a),
                                        fontSize: 11,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                PopupMenuButton(
                                  icon: const Icon(
                                    Icons.menu,
                                    color: Colors.black54,
                                  ),
                                  itemBuilder: (ctx) => [],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 16,
                                ),
                                ...state.receipt.attributes.stories
                                    .map((e) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0),
                                  child:
                                  ReceiptCard(storyViewController: StoryViewController(
                                      StoryState(productViewControllers: [],
                                        story: e, listOfProductsSelected:
                                        e.productList.map((e) => ProductViewController(ProductState(product: e))).where((element)
                                        => element.value.product.count>0).toSet(),
                                        filteredProductViewControllers: {},

                                      )
                                  )),
                                  
                                )),
                              ],
                            ),
                            SizedBox(height: 120,)
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: BagComponent(
                          bagController:
                          bagController,
                          onPressed: () async {
                            bagController.setBagType(BagTypee.homeBag);
                            receiptController.saveReceipt();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ));

        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      valueListenable: receiptController,
    );
  }
}
