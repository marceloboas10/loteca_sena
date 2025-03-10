import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loteria/app/data/http/http_client.dart';
import 'package:loteria/app/repositories/mega_repository.dart';
import 'package:loteria/app/model/teste_model.dart';
import 'package:loteria/app/widgets/bolinhas_widget.dart';

class UltimoSorteio extends StatelessWidget {
  final MegaRepository repository = MegaRepository(client: HttpClientt());

  UltimoSorteio({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TesteModel>>(
      future: repository.getUltimoSorteio(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Erro ao carregar dados'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Nenhum sorteio encontrado'));
        } else {
          final sorteio = snapshot.data!.first;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Último sorteio',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(color: Color(0xFFF7FFFB)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/icone_trevo.png',
                      height: 30,
                    ),
                    const Text(
                      'mega-sena',
                      style: TextStyle(
                          color: Color(0xFF036548),
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    Column(
                      children: [
                        const Text('Último concurso'),
                        Text('${sorteio.concurso}'),
                        Text(sorteio.data),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: const Color(0xFFF2EFE5),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: sorteio.dezenas
                              .map((dezena) => BolinhasWidget(
                                    numero: dezena,
                                    corBolinha: Colors.green.shade800,
                                    corNumero: Colors.white,
                                  ))
                              .toList(),
                        ),
                      ),
                      sorteio.acumulou == true
                          ? const Center(child: Text('Acumulou!'))
                          : const Center(
                              child: Text('Vencedores: 1\nPrêmio: 111111')),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                          'Proximo Prêmio: R\$ ${NumberFormat.currency(locale: 'pt_Br', symbol: 'R\$').format(sorteio.valorEstimadoProximoConcurso)}'),
                      Text('Próximo Concurso: ${sorteio.dataProximoConcurso}'),
                    ],
                  ), //${NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(valorPremio)}
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
