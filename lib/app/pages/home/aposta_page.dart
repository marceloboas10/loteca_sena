import 'package:flutter/material.dart';
import 'package:loteria/app/widgets/bolinhas_aposta_widget.dart';
import 'package:loteria/app/widgets/concurso_label_widget.dart';

class ApostaPage extends StatefulWidget {
  const ApostaPage({super.key});

  @override
  State<ApostaPage> createState() => _ApostaPageState();
}

final numeroConcurso = TextEditingController();

class _ApostaPageState extends State<ApostaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mega da Sorte'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              ConcursoLabelWidget(numeroConcurso: numeroConcurso),
              const SizedBox(
                height: 20,
              ),
              const Flexible(
                child: BolinhasApostaWidget(),
              ),
            ],
          ),
        ));
  }
}
