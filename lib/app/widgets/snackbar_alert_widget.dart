// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SnackbarAlertWidget {
  const SnackbarAlertWidget({
    Key? key,
    required this.title,
    required this.color,
    required this.duracao,
  }) : super();

  final String title;
  final Color color;
  final int duracao;

  show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: duracao),
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      ),
      backgroundColor: color,
    ));
  }
}
