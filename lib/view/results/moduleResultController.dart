import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:g20/shared/extensions/datetime_extension.dart';
import 'package:provider/provider.dart';
import '../../core/http/http.ErrorsHandle.dart';
import '../../core/http/http.Request.dart';
import '../../core/http/http.Response.dart';
import '../../domain/models/results.model.dart';
import '../../domain/models/user.model.dart';
import '../../mainStances.dart';
import '../../shared/widgets/GenericError.dart';

class ResultsState {
  String currentFilterDateName = 'Hoje';
  bool isLoading = false;
  UserResults? results;

  ResultsState({
    required this.isLoading,
    required this.currentFilterDateName,
    required this.results,
  });
}

enum Dates {
  hoje,
  ontem,
  esteMes,
  esteAno,
  custom,
}

class ResultsModuleController extends ValueNotifier<ResultsState> {
  ResultsModuleController(this.context)
      : super(
      ResultsState(
          isLoading: true,
          currentFilterDateName: "Hoje",
          results: null,
        ));
  BuildContext context;
  Dates currentDates = Dates.hoje;

  void fetchResults() async {
    value = ResultsState(
      isLoading: true,
      currentFilterDateName: "Hoje",
      results: null,
    );
    try {
      HttpApiResponse httpApiResponse =
          await MainStances.httpApiClient.request(HttpApiRequest(
        url: MainStances.httpRoutes.userResults,
        method: 'POST',
            body: {
              'id':MainStances.user.id,
              'start': DateTime.now().millisecondsSinceEpoch,
              'end': DateTime.now().millisecondsSinceEpoch
            }
      ));
      if (httpApiResponse.statusCode == 200) {
        value = ResultsState(
          isLoading: false,
          currentFilterDateName: "Hoje",
          results: UserResults.fromMap(httpApiResponse.data),
        );
        print(value.results!.toJson());
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
          fontSize: 16.0);
      print(_);
      navigator(GenericError(
        title: "Ops, Erro inexperado",
        subtitle: e.message,
        errorCode: 'Fetch Results',
      ));
      throw ' error';
    } catch (e, _) {
      print(e);
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
    throw ' error';
  }

  void filterTranslate(int direction) {
    if (currentDates == Dates.esteAno && direction == 1) {
      currentDates = Dates.hoje;
      searchFilter(currentDates);
      return;
    }

    if (currentDates == Dates.hoje && direction == -1) {
      currentDates = Dates.esteAno;
      searchFilter(currentDates);
      return;
    }

    int index = currentDates.index + direction;
    currentDates = Dates.values[index];
    searchFilter(currentDates);
  }

  Future<void> fetchByDate(DateTime start, DateTime end) async {
    try {
      HttpApiResponse httpApiResponse = await MainStances.httpApiClient.request(
          HttpApiRequest(
              url: MainStances.httpRoutes.userResults,
              method: 'POST',
              body: {
             'id':MainStances.user.id,
             'start': start.millisecondsSinceEpoch,
             'end': end.millisecondsSinceEpoch
          }));
      if (httpApiResponse.statusCode == 200) {
        value = ResultsState(
          isLoading: false,
          currentFilterDateName: value.currentFilterDateName,
          results: UserResults.fromMap(httpApiResponse.data),
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
        errorCode: 'Fetch Results',
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

  Future<void> searchFilter(Dates dates, {DateTime? start, DateTime? end})async {
    if (dates == Dates.hoje) {
      value = ResultsState(
        isLoading: true,
        currentFilterDateName: "Hoje",
        results: value.results,
      );
      await fetchByDate(DateTime.now(), DateTime.now());
      return;
    } else if (dates == Dates.ontem) {
      value = ResultsState(
        isLoading: true,
        currentFilterDateName: "Ontem",
        results: value.results,
      );
      await fetchByDate(
          DateTime.now().subtract(const Duration(days: 1)), DateTime.now());
      return;
    } else if (dates == Dates.esteMes) {
      value = ResultsState(
        isLoading: true,
        currentFilterDateName: "Este mes",
        results: value.results,
      );
      await fetchByDate(
          DateTime.now().subtract(const Duration(days: 30)), DateTime.now());
      return;
    } else if (dates == Dates.esteAno) {
      value = ResultsState(
        isLoading: true,
        currentFilterDateName: "Este Ano",
        results: value.results,
      );
      await fetchByDate(DateTime(DateTime.now().year), DateTime.now());
      return;
    } else if (dates == Dates.custom) {
      start = start ?? DateTime.now();
      end = end ?? DateTime.now();
      value = ResultsState(
        isLoading: true,
        currentFilterDateName:
            "${start.customToString()} - ${end.customToString()}",
        results: value.results,
      );
      await fetchByDate(start, end);
      return;
    }
  }

  void navigator(Widget widget) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
      return ListenableProvider<ResultsModuleController>.value(
        value: this,
        child: widget,
      );
    }));
  }
}
