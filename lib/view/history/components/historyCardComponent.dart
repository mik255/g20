import 'package:flutter/material.dart';
import 'package:g20/domain/models/order.model.dart';
import 'package:g20/shared/extensions/currence.dart';
import 'package:g20/shared/extensions/datetime_extension.dart';
import 'package:g20/view/e-commerce/components/bag/bagController.dart';

import '../../e-commerce/components/bag/bagState.dart';
import '../../e-commerce/pages/receive.dart';

class HistoryCardComponent extends StatelessWidget {
  HistoryCardComponent({Key? key, required this.receipt}) : super(key: key);
  Receipt receipt;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => ReceiptPage(
                      receiptController: ReceiptController(ReceiptStateValue(
                        receipt: receipt,
                      )),
                      bagController: BagController(BagState(
                          bagType: BagTypee.receiveBag,
                          leftValue: 0,
                          nameButton: 'Salvar',
                          onPressed: () {},
                          enable: true,
                          currentProduct: null)),
                    )));
      },
      child: Container(
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
                    children: [
                      Text(
                        DateTime.fromMillisecondsSinceEpoch(receipt.date??0)
                            .customToString(),
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
                        "${receipt.attributes.stories.length} lojas",
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
                        receipt.getTotal().toCurrence(),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
