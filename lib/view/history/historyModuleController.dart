import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../core/http/http.ErrorsHandle.dart';
import '../../core/http/http.Request.dart';
import '../../core/http/http.Response.dart';
import '../../domain/models/order.model.dart';
import '../../mainStances.dart';
import '../../shared/widgets/GenericError.dart';

class HistoryState {
  bool isLoading;
  List<Receipt>? receipts;

  HistoryState({required this.isLoading, required this.receipts});
}

class HistoryModuleController extends ValueNotifier<HistoryState> {
  HistoryModuleController(this.context)
      : super(HistoryState(isLoading: true, receipts: []));
  BuildContext context;

  void fetchReceiptsHistory() async {
    value = HistoryState(
      isLoading: true,
      receipts: null,
    );
    try {
      HttpApiResponse httpApiResponse =
          await MainStances.httpApiClient.request(HttpApiRequest(
        url: MainStances.httpRoutes.historyReceipts,
        method: 'GET',
      ));
      if (httpApiResponse.statusCode == 200) {
        List<dynamic> data = httpApiResponse.data;
        List<Receipt> receipts = data.map((e) => Receipt.fromJson(e)).toList();
        value = HistoryState(
          isLoading: false,
          receipts: receipts,
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
          fontSize: 16.0);
      print(_);
      navigator(GenericError(
        title: "Ops, Erro inexperado",
        subtitle: e.message,
        errorCode: 'Fetch historyReceipts',
      ));
      throw ' error';
    } catch (e, _) {
      print(_);
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      navigator(const GenericError(
        title: "Ops, Erro inexperado",
        subtitle: "Tente mais tarde",
        errorCode: 'unknown',
      ));
      throw ' error';
    }
  }

  void navigator(Widget widget) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ListenableProvider<HistoryModuleController>.value(
        value: this,
        child: widget,
      );
    }));
  }
}
