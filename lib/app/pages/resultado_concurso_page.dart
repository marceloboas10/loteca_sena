import 'package:flutter/material.dart';
import 'package:loteria/app/data/http/http_client.dart';
import 'package:loteria/app/model/numeros_sorteados_model.dart';
import 'package:loteria/app/repositories/mega_repository.dart';
import 'package:loteria/app/widgets/bolinhas_widget.dart';
import 'package:loteria/app/widgets/resultado_sorteio_widget.dart';

class ResultadoConcursoPage extends StatefulWidget {
  const ResultadoConcursoPage({super.key, required this.numeros});
  final NumerosSorteadosModel numeros;

  @override
  State<ResultadoConcursoPage> createState() => _ResultadoConcursoPageState();
}

class _ResultadoConcursoPageState extends State<ResultadoConcursoPage> {
  final MegaRepository repository = MegaRepository(client: HttpClientt());

  double parsePremio(dynamic valor) {
    if (valor is int) {
      return valor.toDouble();
    } else if (valor is double) {
      return valor;
    } else {
      throw Exception('Tipo de valor inesperado');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Mega Sena'),
      ),
      body: FutureBuilder(
        future:
            repository.getNumerosSorteados(widget.numeros.concurso.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            ));
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
              'Concurso ${widget.numeros.concurso} não foi realizado!',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum sorteio encontrado'));
          } else {
            final sorteio = snapshot.data!.first;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Concurso',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Data Sorteio',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.numeros.concurso.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        sorteio.dataApuracao,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text('Sua Aposta',
                      style: TextStyle(fontSize: 24, color: Colors.white)),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BolinhasWidget(
                        numero: widget.numeros.numero1.toString(),
                        corBolinha: sorteio.listaDezenas
                                .contains(widget.numeros.numero1.toString())
                            ? Colors.amber
                            : Colors.white,
                      ),
                      BolinhasWidget(
                        numero: widget.numeros.numero2.toString(),
                        corBolinha: sorteio.listaDezenas
                                .contains(widget.numeros.numero2.toString())
                            ? Colors.amber
                            : Colors.white,
                      ),
                      BolinhasWidget(
                        numero: widget.numeros.numero3.toString(),
                        corBolinha: sorteio.listaDezenas
                                .contains(widget.numeros.numero3.toString())
                            ? Colors.amber
                            : Colors.white,
                      ),
                      BolinhasWidget(
                        numero: widget.numeros.numero4.toString(),
                        corBolinha: sorteio.listaDezenas
                                .contains(widget.numeros.numero4.toString())
                            ? Colors.amber
                            : Colors.white,
                      ),
                      BolinhasWidget(
                        numero: widget.numeros.numero5.toString(),
                        corBolinha: sorteio.listaDezenas
                                .contains(widget.numeros.numero5.toString())
                            ? Colors.amber
                            : Colors.white,
                      ),
                      BolinhasWidget(
                        numero: widget.numeros.numero6.toString(),
                        corBolinha: sorteio.listaDezenas
                                .contains(widget.numeros.numero6.toString())
                            ? Colors.amber
                            : Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: [
                      const Text('Números sorteados',
                          style: TextStyle(fontSize: 24, color: Colors.white)),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          BolinhasWidget(
                              numero: sorteio.listaDezenas[0].toString()),
                          BolinhasWidget(
                              numero: sorteio.listaDezenas[1].toString()),
                          BolinhasWidget(
                              numero: sorteio.listaDezenas[2].toString()),
                          BolinhasWidget(
                              numero: sorteio.listaDezenas[3].toString()),
                          BolinhasWidget(
                              numero: sorteio.listaDezenas[4].toString()),
                          BolinhasWidget(
                              numero: sorteio.listaDezenas[5].toString()),
                        ],
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Premiação',
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ResultadoSorteioWidget(
                        nomePremio: 'Sena',
                        quantidadeAcertos: sorteio.listaRateioPremio[0]
                            ['descricaoFaixa'],
                        quantidadeGanhadores: sorteio.listaRateioPremio[0]
                                ['numeroDeGanhadores']
                            .toString(),
                        valorPremio: parsePremio(
                          sorteio.listaRateioPremio[0]['valorPremio'],
                        ),
                      ),
                      ResultadoSorteioWidget(
                        nomePremio: 'Quina',
                        quantidadeAcertos: sorteio.listaRateioPremio[1]
                            ['descricaoFaixa'],
                        quantidadeGanhadores: sorteio.listaRateioPremio[1]
                                ['numeroDeGanhadores']
                            .toString(),
                        valorPremio: parsePremio(
                            sorteio.listaRateioPremio[1]['valorPremio']),
                      ),
                      ResultadoSorteioWidget(
                          nomePremio: 'Quadra',
                          quantidadeAcertos: sorteio.listaRateioPremio[2]
                              ['descricaoFaixa'],
                          quantidadeGanhadores: sorteio.listaRateioPremio[2]
                                  ['numeroDeGanhadores']
                              .toString(),
                          valorPremio: parsePremio(
                              sorteio.listaRateioPremio[2]['valorPremio']))
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
