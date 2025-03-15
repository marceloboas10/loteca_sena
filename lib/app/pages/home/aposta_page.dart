import 'package:flutter/material.dart';
import 'package:loteria/app/widgets/bolinhas_aposta_widget.dart';

class ApostaPage extends StatefulWidget {
  const ApostaPage({super.key});

  @override
  State<ApostaPage> createState() => _ApostaPageState();
}

class _ApostaPageState extends State<ApostaPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Adicionar Jogo'),
        ),
        body: const Padding(
          padding: EdgeInsets.only(
            left: 12,
            right: 12,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Flexible(
                child: BolinhasApostaWidget(),
              ),
            ],
          ),
        ));
  }
}
