import 'package:flutter/material.dart';

class AlertWidget extends StatelessWidget {
  const AlertWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xffececec),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Método de pagamento",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color(0xff88b8f9),
                  fontSize: 14,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "Escolha um método de pagamento para cada loja,\n para concluir seu pedido",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color(0xff96bdcc),
                  fontSize: 12,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
