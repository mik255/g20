import 'package:flutter/material.dart';
import 'package:g20/domain/models/paymentType.model.dart';
import 'package:g20/view/e-commerce/components/Payment/store/paymentController.dart';
import 'package:g20/view/e-commerce/components/Payment/store/paymentState.dart';
import '../story/store/storyController.dart';

class PaymentComponent extends StatelessWidget {
  const PaymentComponent({Key? key, required this.paymentController, required this.storyViewController})
      : super(key: key);
  final PaymentController paymentController;
  final StoryViewController storyViewController;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<PaymentState>(
        valueListenable: paymentController,
        builder: (BuildContext context, state, Widget? child) {
          bool isSelected = paymentController.value.paymentType!=null;
          print('isSelected: $isSelected');
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x3f000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
              color: const Color(0xffe7e7e7),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 2,
                          height: 62,
                          color: const Color(0xffff9811),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          Text(
                            storyViewController.value.story.name,
                            style: const TextStyle(
                              color: Color(0xff292929),
                              fontSize: 14,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "${storyViewController.value.listOfProductsSelected.length} itens",
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
                            "Total : R\$ ${storyViewController.getTotal()}",
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
                        ],
                      ),
                      const Spacer(),
                      PopupMenuButton(
                        iconSize: 80,
                        icon: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: isSelected?Colors.blue:Colors.black12
                          ),
                          child:  Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text( isSelected?
                              state.paymentType!.name:"selecionar",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                        itemBuilder: (ctx) => [
                          _buildPopupMenuItem('Cartão',PaymentType(name: 'credit card')),
                          _buildPopupMenuItem('Pix',PaymentType(name: 'pix')),
                          _buildPopupMenuItem('Lojista',PaymentType(name: 'lojist')),
                          _buildPopupMenuItem('Dinheiro',PaymentType(name: 'money')),
                        ],
                      )
                    ],
                  ),
                  if(!isSelected)
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0,top: 16),
                      child: Text(
                        "Selecione um método de pagamento",
                        style: TextStyle(
                          color: Color(0xffd43239),
                          fontSize: 11,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    )
                ],
              ),
            ),
          );
        });

  }
  PopupMenuItem _buildPopupMenuItem(
      String title, PaymentType paymentType) {
    return PopupMenuItem(
      onTap: (){
        paymentController.select(paymentType);
        storyViewController.setPaymentMethod(paymentType);
      },
      child:  Text(title),
    );}
}
