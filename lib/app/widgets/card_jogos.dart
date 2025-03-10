import 'package:flutter/material.dart';

class CardJogosWidget extends StatelessWidget {
  const CardJogosWidget(
      {super.key, required this.nome, required this.icon, required this.onTap});

  final String nome;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 120,
        decoration: const BoxDecoration(
          color: Color(0xFFF7FFFB),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: Colors.green.shade800,
              ),
              Text(nome),
            ],
          ),
        ),
      ),
    );
  }
}
