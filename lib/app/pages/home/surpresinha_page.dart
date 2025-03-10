import 'package:flutter/material.dart';
import 'package:loteria/app/data/database/my_database.dart';
import 'package:loteria/app/funcoes/gera_numeros.dart';
import 'package:loteria/app/model/numeros_sorteados_model.dart';
import 'package:loteria/app/pages/meus_jogos/meus_jogos_page.dart';
import 'package:loteria/app/widgets/bolinhas_widget.dart';
import 'package:loteria/app/widgets/concurso_label_widget.dart';
import 'package:loteria/app/widgets/snackbar_alert_widget.dart';

List todosNumeros = [];

class SurpresinhaPage extends StatefulWidget {
  const SurpresinhaPage({super.key});

  @override
  State<SurpresinhaPage> createState() => _HomePageState();
}

var numerosSorteadosModel = NumerosSorteadosModel();
final concurso = TextEditingController();

class _HomePageState extends State<SurpresinhaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Surpresinha',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 20),
              ),
              Image.asset(
                'assets/images/logo_mega.png',
                fit: BoxFit.cover,
                height: 250,
              ),
              ConcursoLabelWidget(numeroConcurso: concurso),
              TextButton(
                onPressed: () {
                  setState(() {
                    var sorteio = geradorNumnerosMega();
                    todosNumeros = sorteio.toList();
                  });
                  todosNumeros.sort();
                },
                child: Container(
                  width: 190,
                  height: 50,
                  color: const Color(0xFF00875F),
                  child: const Center(
                    child: Text(
                      'Supresinha',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                visible: todosNumeros.isNotEmpty,
                child: const Text(
                  'Numeros da Sorte',
                  style: TextStyle(color: Colors.amber, fontSize: 24),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 15)),
              if (todosNumeros.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BolinhasWidget(
                      numero: todosNumeros[0].toString(),
                    ),
                    BolinhasWidget(
                      numero: todosNumeros[1].toString(),
                    ),
                    BolinhasWidget(numero: todosNumeros[2].toString()),
                    BolinhasWidget(numero: todosNumeros[3].toString()),
                    BolinhasWidget(numero: todosNumeros[4].toString()),
                    BolinhasWidget(numero: todosNumeros[5].toString()),
                  ],
                ),
              const SizedBox(
                height: 60,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        if (concurso.text.isEmpty || todosNumeros.isEmpty) {
                          const SnackbarAlertWidget(
                                  duracao: 1,
                                  title: 'Informe o Concurso',
                                  color: Colors.red)
                              .show(context);
                        } else {
                          MyDatabase().insert(numerosSorteadosModel);
                          String dataAtual =
                              '${DateTime.now().day.toString().padLeft(2, '0')}/${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().year}';

                          numerosSorteadosModel.numero1 =
                              todosNumeros[0].toString();
                          numerosSorteadosModel.numero2 =
                              todosNumeros[1].toString();
                          numerosSorteadosModel.numero3 =
                              todosNumeros[2].toString();
                          numerosSorteadosModel.numero4 =
                              todosNumeros[3].toString();
                          numerosSorteadosModel.numero5 =
                              todosNumeros[4].toString();
                          numerosSorteadosModel.numero6 =
                              todosNumeros[5].toString();
                          numerosSorteadosModel.data = dataAtual;
                          numerosSorteadosModel.concurso = concurso.text;
                          const SnackbarAlertWidget(
                                  duracao: 2,
                                  title: 'Números Adicionados com Sucesso!',
                                  color: Colors.green)
                              .show(context);
                          setState(() {
                            todosNumeros.clear();
                          });
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                            color: const Color(0xFF00875F),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Center(
                          child: Text(
                            'Adiconar Numeros',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => MeusJogosPage()),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                            color: const Color(0xFF00875F),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Center(
                          child: Text(
                            'Visualizar Numeros',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
