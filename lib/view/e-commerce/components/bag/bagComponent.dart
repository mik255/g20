import 'package:flutter/material.dart';
import 'package:g20/view/e-commerce/components/product/store/productController.dart';
import 'package:g20/view/e-commerce/moduleController.dart';
import 'package:provider/provider.dart';

import '../../../../shared/formats.dart';
import '../../../e-commerce/components/bag/bagController.dart';
import '../../../e-commerce/components/bag/bagState.dart';

class BagComponent extends StatelessWidget {
  const BagComponent({
    Key? key,
    required this.bagController,
    required this.onPressed,
  }) : super(key: key);
  final BagController bagController;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<BagState>(
        valueListenable: bagController,
        builder: (BuildContext context, BagState state, Widget? child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.ease,
            height: 90,
            alignment: Alignment(0, state.enable ? 0 : 6),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
              opacity: state.enable ? 1 : 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${ state.currentProduct?.value.product.count??0}x ${state.currentProduct?.value.product.name}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "total "
                                  " ${formatMoney(state.currentProduct?.getTotal()??0)}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${formatMoney(state.leftValue)}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if ( state.currentProduct != null &&
                          state.currentProduct!.value.product.count>0)

                      const Spacer(),
                      if ( state.currentProduct != null &&
                          state.currentProduct!.value.product.count>0)
                       if(state.canRemoveProduct)
                        InkWell(
                          onTap: () {
                            state.currentProduct?.decrement();
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            child: const CircleAvatar(
                              backgroundColor: Colors.white30,
                              radius: 50,
                              child: Icon(
                                Icons.exposure_minus_1,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          state.onPressed = onPressed;
                          state.onPressed.call();
                        },
                        child: Container(
                          height: 58,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                state.nameButton,
                                style: const TextStyle(
                                  color: Color(0xff447acb),
                                  fontSize: 20,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
