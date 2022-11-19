import 'package:flutter/material.dart';
import '../../../../domain/models/product.model.dart';
import '../../../../shared/formats.dart';
import 'store/ProductState.dart';
import 'store/productController.dart';

class ProductComponent extends StatelessWidget {
  const ProductComponent({
    Key? key,
    required this.productController,
    required this.height,
    required this.width,
  }) : super(key: key);
  final ProductViewController productController;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ProductState>(
        valueListenable: productController,
        builder: (context, state, snapshot) {
          Product product = productController.value.product;
          return InkWell(
            onTap: () {
              productController.increment();
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
              child: SizedBox(
                height: height,
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          image: DecorationImage(
                              image: NetworkImage(
                                  productController.value.product.urlImg),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(20),
                          border: productController.value.product.isSelected
                              ? Border.all(color: Colors.blue, width: 4)
                              : null,
                          color: Colors.blue.shade300),
                      child: Stack(
                        children: [
                          if (state.product.count > 0)
                            Align(
                              alignment: Alignment.topRight * 1.1,
                              child: AnimatedContainer(
                                curve: Curves.ease,
                                duration: const Duration(milliseconds: 200),
                                height: 25,
                                width: 25,
                                child: CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 25,
                                  child: Text(
                                    state.product.count.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: [
                        Text(
                          formatMoney(product.price),
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 4,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: productController.value.product.isSelected
                                      ? Border.all(color: Colors.blue, width: 4)
                                      : null,
                                  color: Colors.blue.shade300),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  formatPorcent(((product.price*100)/product.squerePrice)-100),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Text(
                              formatMoney(product.squerePrice),
                              style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 8),
                            ),
                          ],
                        ),
                        Text(
                          'descrição do produto que aqui vc coloca todoas',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(
                          'embalagem 1kg',
                          style: TextStyle(color: Colors.grey[500],fontSize: 12),
                        ),
                      ],
                    )

                  ],
                ),
              ),
            ),
          );
        });
  }
}
