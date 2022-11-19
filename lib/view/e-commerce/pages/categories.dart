import 'package:flutter/material.dart';
import 'package:g20/view/e-commerce/moduleController.dart';
import 'package:g20/view/e-commerce/pages/home.dart';
import 'package:provider/provider.dart';
import '../../../domain/models/category.model.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: ValueListenableBuilder<EcommerceState>(
            valueListenable: context.read<ModuleController>(),
            builder: (BuildContext context, value, Widget? child)  {
                  if(value is EcommerceStateValues){
                    EcommerceStateValues state = value;
                    return Padding(
                      padding: const EdgeInsets.only(top:16),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Todas as Categorias",
                              style: TextStyle(
                                color: Color(0xff292929),
                                fontSize: 16,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: state.categories.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                      onTap: ()async{
                                        context.read<ModuleController>().choiceCategory(state.categories[index]);
                                        context.read<ModuleController>().navigator(const HomePage());
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children:[
                                                    Container(
                                                      width: 275,
                                                      height: 64,
                                                      child: Stack(
                                                        children: [

                                                          Padding(
                                                            padding: EdgeInsets.only(left: 16),
                                                            child: Text(
                                                              state.categories[index].name,
                                                              style: const TextStyle(
                                                                color: Color(0xff009557),
                                                                fontSize: 14,
                                                                fontFamily: "Montserrat",
                                                                fontWeight: FontWeight.w700,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(top:30,left: 16),
                                                            child: Text(
                                                              "descrição da categoria...",
                                                              style: TextStyle(
                                                                color: Color(0xff9a9a9a),
                                                                fontSize: 12,
                                                                fontFamily: "Montserrat",
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(left: 16,top: 52),
                                                            child: Text(
                                                              "${state.categories[index].stories.length} lojas",
                                                              style: TextStyle(
                                                                color: Color(0xff9a9a9a),
                                                                fontSize: 12,
                                                                fontFamily: "Montserrat",
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 16),
                                                  ],
                                                ),
                                                Transform.rotate(
                                                  angle: -110,
                                                  child: const SizedBox(
                                                    width: 28.96,
                                                    height: 28.96,
                                                    child: Icon(Icons.arrow_back_ios_sharp, color: Color(
                                                        0xffcbcbcb),),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider()
                                        ],
                                      )
                                  );
                                }),
                          ),

                        ],
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          ));
  }
}
