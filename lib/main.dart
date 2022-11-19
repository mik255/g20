import 'package:flutter/material.dart';
import 'package:g20/view/account/view.account.provider.dart';
import 'package:g20/view/e-commerce/module.provider.dart';
import 'package:g20/view/e-commerce/pages/checkout.dart';
import 'package:g20/view/e-commerce/pages/home.dart';
import 'package:g20/view/e-commerce/pages/payment.dart';
import 'package:g20/view/e-commerce/pages/receive.dart';
import 'package:g20/view/history/history.provider.dart';
import 'package:g20/view/results/pages/filterPage.dart';
import 'package:g20/view/results/resultsProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      routes: {
        '/login': (context) => const LoginProvider(),
        '/ecommerceProvider': (context) =>  EcommerceProvider(),
        '/homePage': (context) =>  HomePage(),
        '/payment': (context) => const PaymentPage(),
         '/checkout': (context) =>  const Checkout(),
         '/receive': (context) =>  const Receive(),
         '/results': (context) =>  const ResultProvider(),
         '/history': (context) =>  const HistoryProvider(),
      },
      title: 'Flutter Demo',debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginProvider()
    );
  }
}

