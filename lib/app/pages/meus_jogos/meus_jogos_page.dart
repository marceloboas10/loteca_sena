import 'package:flutter/material.dart';
import 'package:loteria/app/data/database/my_database.dart';
import 'package:loteria/app/model/numeros_sorteados_model.dart';
import 'package:loteria/app/pages/resultado_concurso_page.dart';
import 'package:loteria/app/widgets/bolinhas_widget.dart';

class MeusJogosPage extends StatefulWidget {
  MeusJogosPage({super.key});

  final MyDatabase _database = MyDatabase();

  @override
  State<MeusJogosPage> createState() => _MeusJogosPageState();
}

class _MeusJogosPageState extends State<MeusJogosPage> {
  @override
  void initState() {
    super.initState();
    buscarNumeros();
  }

  Future<List<NumerosSorteadosModel>> buscarNumeros() async {
    final numeros = await MyDatabase().listar();
    return numeros;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Meus Jogos'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
            ),
            FutureBuilder(
                future: buscarNumeros(),
                builder: (context, numerosSalvos) {
                  if (!numerosSalvos.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (numerosSalvos.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        'Sem Nenhum Jogo',
                        style: TextStyle(color: Colors.white, fontSize: 28),
                      ),
                    );
                  }
                  List<NumerosSorteadosModel>? numerosSorteados =
                      numerosSalvos.data;

                  return Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: numerosSorteados!.length,
                      itemBuilder: (context, index) {
                        var row = GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ResultadoConcursoPage(
                                numeros: numerosSorteados[index],
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Row(
                              children: [
                                BolinhasWidget(
                                    numero: numerosSorteados[index]
                                        .numero1
                                        .toString()),
                                const SizedBox(
                                  width: 10,
                                ),
                                BolinhasWidget(
                                    numero: numerosSorteados[index]
                                        .numero2
                                        .toString()),
                                const SizedBox(
                                  width: 10,
                                ),
                                BolinhasWidget(
                                    numero: numerosSorteados[index]
                                        .numero3
                                        .toString()),
                                const SizedBox(
                                  width: 10,
                                ),
                                BolinhasWidget(
                                    numero: numerosSorteados[index]
                                        .numero4
                                        .toString()),
                                const SizedBox(
                                  width: 10,
                                ),
                                BolinhasWidget(
                                    numero: numerosSorteados[index]
                                        .numero5
                                        .toString()),
                                const SizedBox(
                                  width: 10,
                                ),
                                BolinhasWidget(
                                    numero: numerosSorteados[index]
                                        .numero6
                                        .toString()),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text(
                                          'Excluir Jogo',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                        content: const Text(
                                          'Tem certeza que deseja excluir esse jogo?',
                                          style: TextStyle(fontSize: 20),
                                          textAlign: TextAlign.center,
                                        ),
                                        actionsAlignment:
                                            MainAxisAlignment.center,
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                'Não',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 18),
                                              )),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                Navigator.pop(context);
                                                widget._database
                                                    .deleteNumerosSalvos(
                                                        numerosSorteados[index]
                                                            .id!
                                                            .toInt());
                                              });
                                            },
                                            child: const Text(
                                              'Sim',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 18),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16, right: 14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Concurso: ${numerosSorteados[index].concurso.toString()} ',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        'Data da aposta: ${numerosSorteados[index].data.toString()}',
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                row,
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
