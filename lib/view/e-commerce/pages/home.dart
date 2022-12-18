import 'package:flutter/material.dart';
import 'package:g20/view/e-commerce/components/category/categoryState.dart';
import 'package:g20/view/e-commerce/pages/payment.dart';
import 'package:provider/provider.dart';
import '../components/bag/bagComponent.dart';
import '../components/bag/bagState.dart';
import '../components/product/productComponent.dart';
import '../components/search/search.dart';
import '../components/story/storyComponent.dart';
import '../moduleController.dart';
import 'checkout.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          drawer: ClipRRect(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(35),
                bottomRight: Radius.circular(35)),
            child: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  UserAccountsDrawerHeader(
                    accountEmail: const Text("mikael20informatica@gmail.com"),
                    accountName: const Text("Mikael"),
                    currentAccountPicture: CircleAvatar(
                        child: Image.network(
                            'https://cdn.pixabay.com/photo/2019/08/11/18/59/icon-4399701_960_720.png')),
                  ),
                  ListTile(
                    title: const Text('Meus Resultados'),
                    leading: const Icon(Icons.bar_chart),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        "/results",
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Histórico'),
                    leading: const Icon(Icons.history),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        "/history",
                      );
                    },
                  ),
                  Divider(),
                ],
              ),
            ),
          ),
          body: Stack(
            children: [
              CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                      backgroundColor: Colors.transparent,
                      pinned: true,
                      snap: false,
                      floating: false,
                      expandedHeight: 200.0,
                      flexibleSpace: Stack(children: [
                        const Positioned.fill(
                          child: Image(
                            image: AssetImage('assets/Produtos.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                            child: Center(
                              child: SizedBox(
                                  height: 90,
                                  child: Image.asset('assets/g20-logo.png')),
                            )),
                      ])),
                  SliverToBoxAdapter(
                      child: Container(
                        height: MediaQuery.of(context).size.height + 120,
                        child: Column(mainAxisSize: MainAxisSize.max, children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(top: 16.0, left: 16, right: 16),
                            child: SearchComponent(
                              onChanged: (String value) {
                                context
                                    .read<ModuleController>()
                                    .categoryViewController
                                    .searchProduct(value);
                              },
                            ),
                          ),
                          Expanded(
                              child: ValueListenableBuilder<CategoryState>(
                                  valueListenable: context
                                      .read<ModuleController>()
                                      .categoryViewController,
                                  builder: (context, state, child) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SingleChildScrollView(
                                        physics: NeverScrollableScrollPhysics(),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            StoryComponent(
                                                categoryViewController: context
                                                    .read<ModuleController>()
                                                    .categoryViewController),
                                            if (context
                                                .read<ModuleController>()
                                                .categoryViewController
                                                .storiesIsEmpty())
                                              const Center(
                                                child: Text("No stories"),
                                              )
                                            else if (context
                                                .read<ModuleController>()
                                                .categoryViewController
                                                .isStorySearchIsEmpty())
                                              const Center(
                                                  child: Text("select some stories"))
                                            else
                                              GridView.count(
                                                  physics: ScrollPhysics(),
                                                  childAspectRatio: 0.52,
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  crossAxisSpacing: 2,
                                                  mainAxisSpacing: 2,
                                                  crossAxisCount: 3,
                                                  children: List.generate(
                                                      state
                                                          .currentStoryController!
                                                          .value
                                                          .filteredProductViewControllers
                                                          .length,
                                                          (index) => ProductComponent(
                                                        productController: state
                                                            .currentStoryController!
                                                            .value
                                                            .filteredProductViewControllers
                                                            .toList()[index],
                                                        height: 120,
                                                        width: 90,
                                                      ))),
                                            SizedBox(
                                              height: 120,
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }))
                        ]),
                      )),
                ],
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BagComponent(
                    bagController: context
                        .read<ModuleController>()
                        .categoryViewController
                        .bagController,
                    onPressed: () {
                      context
                          .read<ModuleController>()
                          .categoryViewController
                          .bagController
                          .setBagType(BagTypee.paymentBag);
                      context
                          .read<ModuleController>()
                          .navigator(const PaymentPage());
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
