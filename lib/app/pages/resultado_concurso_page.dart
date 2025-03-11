import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:loteria/app/model/numeros_sorteados_model.dart';
import 'package:loteria/app/widgets/bolinhas_widget.dart';
import 'package:http/http.dart' as http;
import 'package:loteria/app/widgets/resultado_sorteio_widget.dart';

class ResultadoConcursoPage extends StatefulWidget {
  const ResultadoConcursoPage({super.key, required this.numeros});
  final NumerosSorteadosModel numeros;

  @override
  State<ResultadoConcursoPage> createState() => _ResultadoConcursoPageState();
}

List<int>? dezenas;
var dadosApi = {};
bool carregou = true;

class _ResultadoConcursoPageState extends State<ResultadoConcursoPage> {
  @override
  void initState() {
    super.initState();
    dezenas = null;
    carregou = false;
    buscarResultado();
  }

  Future<void> buscarResultado() async {
    final url = Uri.parse(
        'https://api.guidi.dev.br/loteria/megasena/${widget.numeros.concurso}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = response.body;
      dadosApi = json.decode(data);
      
      dezenas =
          data.split('"listaDezenas":')[1].split(']')[0].split(',').map((e) {
        return int.parse(e.replaceAll('[', '').replaceAll('"', ''));
      }).toList();

      if (!mounted) {
        return;
      }

      setState(() {
        carregou = true;
      });
    }
  }

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
      body: carregou == false
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.white,
            ))
          : Padding(
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
                        dadosApi['dataApuracao'].toString(),
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
                        corBolinha: dezenas!.contains(
                                int.parse(widget.numeros.numero1.toString()))
                            ? Colors.amber
                            : Colors.white,
                      ),
                      BolinhasWidget(
                        numero: widget.numeros.numero2.toString(),
                        corBolinha: dezenas!.contains(
                                int.parse(widget.numeros.numero2.toString()))
                            ? Colors.amber
                            : Colors.white,
                      ),
                      BolinhasWidget(
                        numero: widget.numeros.numero3.toString(),
                        corBolinha: dezenas!.contains(
                                int.parse(widget.numeros.numero3.toString()))
                            ? Colors.amber
                            : Colors.white,
                      ),
                      BolinhasWidget(
                        numero: widget.numeros.numero4.toString(),
                        corBolinha: dezenas!.contains(
                                int.parse(widget.numeros.numero4.toString()))
                            ? Colors.amber
                            : Colors.white,
                      ),
                      BolinhasWidget(
                        numero: widget.numeros.numero5.toString(),
                        corBolinha: dezenas!.contains(
                                int.parse(widget.numeros.numero5.toString()))
                            ? Colors.amber
                            : Colors.white,
                      ),
                      BolinhasWidget(
                        numero: widget.numeros.numero6.toString(),
                        corBolinha: dezenas!.contains(
                                int.parse(widget.numeros.numero6.toString()))
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
                          BolinhasWidget(numero: dezenas![0].toString()),
                          BolinhasWidget(numero: dezenas![1].toString()),
                          BolinhasWidget(numero: dezenas![2].toString()),
                          BolinhasWidget(numero: dezenas![3].toString()),
                          BolinhasWidget(numero: dezenas![4].toString()),
                          BolinhasWidget(numero: dezenas![5].toString()),
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
                        quantidadeAcertos: dadosApi['listaRateioPremio'][0]
                                ['descricaoFaixa']
                            .toString(),
                        quantidadeGanhadores: dadosApi['listaRateioPremio'][0]
                                ['numeroDeGanhadores']
                            .toString(),
                        valorPremio: parsePremio(
                            dadosApi['listaRateioPremio'][0]['valorPremio']),
                      ),
                      ResultadoSorteioWidget(
                          nomePremio: 'Quina',
                          quantidadeAcertos: dadosApi['listaRateioPremio'][1]
                                  ['descricaoFaixa']
                              .toString(),
                          quantidadeGanhadores: dadosApi['listaRateioPremio'][1]
                                  ['numeroDeGanhadores']
                              .toString(),
                          valorPremio: dadosApi['listaRateioPremio'][1]
                              ['valorPremio']),
                      ResultadoSorteioWidget(
                        nomePremio: 'Quadra',
                        quantidadeAcertos: dadosApi['listaRateioPremio'][2]
                                ['descricaoFaixa']
                            .toString(),
                        quantidadeGanhadores: dadosApi['listaRateioPremio'][2]
                                ['numeroDeGanhadores']
                            .toString(),
                        valorPremio: parsePremio(
                            dadosApi['listaRateioPremio'][2]['valorPremio']),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
