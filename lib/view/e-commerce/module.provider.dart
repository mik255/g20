import 'package:flutter/material.dart';
import 'package:g20/view/e-commerce/pages/categories.dart';
import 'package:provider/provider.dart';
import 'moduleController.dart';

class EcommerceProvider extends StatelessWidget {
   const EcommerceProvider({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ListenableProvider(create: (_)=> ModuleController(context)..fetchCategories())
      ],
      child: const CategoriesPage(),
    );
  }
}

