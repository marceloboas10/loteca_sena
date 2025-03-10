import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ResultadoSorteioWidget extends StatelessWidget {
  const ResultadoSorteioWidget(
      {super.key,
      required this.nomePremio,
      required this.quantidadeAcertos,
      required this.quantidadeGanhadores,
      required this.valorPremio});

  final String nomePremio;
  final String quantidadeAcertos;
  final String quantidadeGanhadores;
  final double valorPremio;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '$nomePremio - $quantidadeAcertos\n$quantidadeGanhadores apostas ganhadoras\nPrêmio: ${NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(valorPremio)} ',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
