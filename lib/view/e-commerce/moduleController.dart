import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:g20/domain/models/order.model.dart';
import 'package:g20/view/e-commerce/components/bag/bagState.dart';
import 'package:g20/view/e-commerce/pages/checkout.dart';
import 'package:g20/view/e-commerce/pages/home.dart';
import 'package:g20/view/e-commerce/pages/payment.dart';
import 'package:g20/view/e-commerce/pages/receive.dart';
import 'package:provider/provider.dart';
import '../../core/http/http.ErrorsHandle.dart';
import '../../core/http/http.Request.dart';
import '../../core/http/http.Response.dart';
import '../../domain/models/category.model.dart';
import '../../mainStances.dart';
import '../../shared/widgets/GenericError.dart';
import 'components/category/categoryState.dart';
import 'components/category/categoryViewController.dart';

class EcommerceState{}
class EcommerceStateLoading extends EcommerceState{}
class EcommerceStateSuccess extends EcommerceState{}
class EcommerceStateValues extends EcommerceState{
  List<Category> categories;
  EcommerceStateValues({required this.categories});
}
class ModuleController extends ValueNotifier<EcommerceState>{
  ModuleController(this.context) : super(EcommerceStateLoading());

  BuildContext context;
  Category? category;
  List<Category> categories = [];
  String observation = '';
  late CategoryViewController categoryViewController;
 late ReceiptController receiptController;
  void fetchCategories() async {
    value = EcommerceStateLoading();
    try {
      HttpApiResponse httpApiResponse = await MainStances.httpApiClient.request(
          HttpApiRequest(
            url: MainStances.httpRoutes.categories,
            method: 'GET',
          ));
      if (httpApiResponse.statusCode == 200) {
        List<dynamic> data = httpApiResponse.data;
        value = EcommerceStateValues(
            categories: data.map((e) => Category.fromJson(e)).toList()
        );
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
      navigator(GenericError(
        title: "Ops, Erro inexperado",
        subtitle: e.message,
        errorCode: 'Fetch Categories',
      ));
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
      navigator(const GenericError(
        title: "Ops, Erro inexperado",
        subtitle: "Tente mais tarde",
        errorCode: 'unknown',
      ));
    }
  }

  void choiceCategory(Category category) {
    this.category = category;
    categoryViewController = CategoryViewController(
      CategoryState(
        category: category,
        storyControllers: [],
        currentStoryController: null,
        storiesWithProductsSelected: [],
      ),
    );
  }

  navigator(Widget widget) async {
    if (widget is Receive) {
      bool isAll = categoryViewController.value.storiesWithProductsSelected
          .where((element) =>
      element.value.story.paymentType != null
      ).isEmpty;

      if (isAll) {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Métodos de pagamento"),
              content: Container(
                height: 150,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const ListTile(
                        leading: Icon(Icons.warning, color: Colors.amber,),
                        title: Text(
                          "Selecione um método de pagamento para cada loja",
                          style: TextStyle(fontSize: 15),),
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 12,),
                          const Text("Lojas sem método de pagamento"),
                          const SizedBox(height: 12,),
                          ...categoryViewController
                              .buildListOfStoriesWithProductsSelected().map((
                              e) =>
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(e.value.story.name,),
                              )
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('ok', style: TextStyle(fontSize: 20),),
                    )),
              ],
            );
          },
        );
        return;
      }
    }
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return ListenableProvider<ModuleController>.value(
            value: this,
            child: widget,
          );
        })).then((value) {
      BagTypee bagTypee = BagTypee.homeBag;
      if (widget is HomePage) {
        bagTypee = BagTypee.homeBag;
      } else if (widget is Checkout) {
        bagTypee = BagTypee.homeBag;
      } else if (widget is PaymentPage) {
        bagTypee = BagTypee.casherBag;
      } else if (widget is Receive) {
        bagTypee = BagTypee.paymentBag;
      }
      categoryViewController.bagController.setBagType(bagTypee);
    });
  }

  void buildReceipt(){
    receiptController = ReceiptController(ReceiptStateValue(
      receipt: Receipt(
        date: DateTime.now().millisecondsSinceEpoch,
        stories: categoryViewController.value.storiesWithProductsSelected.map((e) => e.value.story).toList(),
        observation: observation,)
    ));
    }


  void setObservation(String value) {
    observation = value;
  }
}
