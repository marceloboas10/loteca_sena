import 'package:flutter/material.dart';
import 'package:loteria/app/widgets/acesso_rapido.dart';
import 'package:loteria/app/widgets/ultimo_sorteio.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: AppBar(
          centerTitle: false,
          title: const Text('Olá\nBoa sorte'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const AcessoRapido(),
            const SizedBox(
              height: 60,
            ),
            UltimoSorteio(),
          ],
        ),
      ),
    );
  }
}
