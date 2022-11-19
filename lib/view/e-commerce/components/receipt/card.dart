import 'package:flutter/material.dart';
import 'package:g20/shared/extensions/currence.dart';
import 'package:g20/view/e-commerce/components/story/store/storyController.dart';

import '../../../../domain/models/paymentType.model.dart';

class ReceiptCard extends StatelessWidget {
  ReceiptCard({Key? key, required this.storyViewController}) : super(key: key);
  StoryViewController storyViewController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xffececec),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.store,
                        color: Color(0xff545454),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(storyViewController.value.story.name,
                          style: const TextStyle(
                            color: Color(0xff545454),
                            fontSize: 20,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500,
                          )),
                      Spacer(),
                      PopupMenuButton(
                        icon: Icon(Icons.cached,color: Colors.blue,),
                        itemBuilder: (ctx) => [
                          _buildPopupMenuItem(
                              'Cartão', PaymentType(name: 'credit card')),
                          _buildPopupMenuItem('Pix', PaymentType(name: 'pix')),
                          _buildPopupMenuItem(
                              'Lojista', PaymentType(name: 'lojist')),
                          _buildPopupMenuItem(
                              'Dinheiro', PaymentType(name: 'money')),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    storyViewController.value.story.paymentType!,
                    style: const TextStyle(
                      color: Color(0xff9a9a9a),
                      fontSize: 14,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Text(
                        "${storyViewController.value.listOfProductsSelected.length} itens",
                        style: const TextStyle(
                          color: Color(0xff9a9a9a),
                          fontSize: 14,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              decoration: const BoxDecoration(
                  border: Border(
                      left: BorderSide(color: Color(0xffff9811), width: 2))),
              child: Column(
                children: [
                  ...storyViewController.value.listOfProductsSelected.map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${e.value.product.count}x "
                                "${e.value.product.name}",
                                style: const TextStyle(
                                  color: Color(0xff9a9a9a),
                                  fontSize: 12,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                e.value.product.getTotal().toCurrence(),
                                style: const TextStyle(
                                  color: Color(0xff9a9a9a),
                                  fontSize: 14,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            width: 40,
                            height: 40,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    e.value.product.urlImg,
                                  ),
                                  fit: BoxFit.cover),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    spreadRadius: 2,
                                    offset: Offset(2, 2))
                              ],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  PopupMenuItem _buildPopupMenuItem(String title, PaymentType paymentType) {
    return PopupMenuItem(
      onTap: () {
        storyViewController.setPaymentMethod(paymentType);
      },
      child: Text(title),
    );
  }
}
