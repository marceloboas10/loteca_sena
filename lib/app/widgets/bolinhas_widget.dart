import 'package:flutter/material.dart';

class BolinhasWidget extends StatelessWidget {
  const BolinhasWidget(
      {Key? key, required this.numero, this.corBolinha, this.corNumero})
      : super(key: key);

  final String numero;
  final Color? corBolinha;
  final Color? corNumero;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: corBolinha ?? Colors.white,
      child: Text(
        numero,
        style: TextStyle(
            fontSize: 26,
            color: corNumero ?? Colors.black,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
