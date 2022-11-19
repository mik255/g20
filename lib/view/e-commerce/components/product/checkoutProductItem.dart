import 'package:flutter/material.dart';
import 'package:g20/shared/formats.dart';
import 'package:g20/view/e-commerce/components/product/store/ProductState.dart';
import 'package:g20/view/e-commerce/components/product/store/productController.dart';

class CheckoutProductItem extends StatelessWidget {
  const CheckoutProductItem({Key? key,required this.productController}) : super(key: key);
  final ProductViewController productController;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ProductState>(
      valueListenable: productController,
      builder: (context, state, snapshot) {
        return ListTile(
          leading: const Icon(
            Icons.restore_from_trash,
            color: Colors.white,
          ),
          title:
          Text(productController.value.product.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
              )),
          subtitle: Text("itens: "+productController.value.product.count.toString()+'x',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 10
              )),
          trailing: SizedBox(
            width: 120,
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {
                      productController.increment();
                    },
                    child: const CircleAvatar(
                      radius: 15,
                      child: Text(
                        '+',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    )),
                Flexible(
                  child: FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                          "${formatMoney(productController.getTotal())}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15)),
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      productController.decrement();
                    },
                    child: const CircleAvatar(
                      radius: 15,
                      child: Text('-',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20)),
                    )),
              ],
            ),
          ));}
    );
  }
}
