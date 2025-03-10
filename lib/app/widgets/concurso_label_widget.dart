import 'package:flutter/material.dart';

class ConcursoLabelWidget extends StatelessWidget {
  const ConcursoLabelWidget({super.key, required this.numeroConcurso});

  final TextEditingController numeroConcurso;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: TextField(
        controller: numeroConcurso,
        cursorColor: Colors.white,
        decoration: const InputDecoration(
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            label: Center(
              child: Text(
                "Concurso",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            hintText: 'Concurso',
            hintStyle: TextStyle(
              color: Colors.white,
            ),
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }
}
