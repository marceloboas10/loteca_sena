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
      appBar: AppBar(
        title: const Text('MEGA SENA'),
      ),
      body:  Padding(
        padding:const EdgeInsets.all(16),
        child: Column(
          children: [
           const AcessoRapido(),
         const   SizedBox(
              height: 30,
            ),
            UltimoSorteio(),
          ],
        ),
      ),
    );
  }
}
