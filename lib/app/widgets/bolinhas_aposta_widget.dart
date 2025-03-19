import 'package:flutter/material.dart';
import 'package:loteria/app/data/database/my_database.dart';
import 'package:loteria/app/model/numeros_sorteados_model.dart';
import 'package:loteria/app/widgets/concurso_label_widget.dart';
import 'package:loteria/app/widgets/snackbar_alert_widget.dart';

List numerosSelecionados = [];

class BolinhasApostaWidget extends StatefulWidget {
  const BolinhasApostaWidget({Key? key, this.tamanho}) : super(key: key);

  final double? tamanho;

  @override
  State<BolinhasApostaWidget> createState() => _BolinhasApostaWidgetState();
}

var numerosSelecionadosModel = NumerosSorteadosModel();
final numeroConcurso = TextEditingController();

class _BolinhasApostaWidgetState extends State<BolinhasApostaWidget> {
  @override
  void dispose() {
    numeroConcurso.clear();
    super.dispose();
  }

  int totalSelect = 0;
  List<bool> isSelectedList = List<bool>.filled(60, false);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConcursoLabelWidget(numeroConcurso: numeroConcurso),
        const SizedBox(
          height: 22,
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6, mainAxisSpacing: 10, crossAxisSpacing: 22),
            itemCount: 60,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(
                    () {
                      if (isSelectedList[index]) {
                        isSelectedList[index] = false;
                        totalSelect--;
                        numerosSelecionados
                            .remove((index + 1).toString().padLeft(2, '0'));
                      } else if (totalSelect < 6) {
                        isSelectedList[index] = true;
                        totalSelect++;
                        numerosSelecionados
                            .add((index + 1).toString().padLeft(2, '0'));
                      }
                      numerosSelecionados.sort();
                    },
                  );
                },
                child: CircleAvatar(
                  backgroundColor: isSelectedList[index] == false
                      ? Colors.white
                      : Colors.amber,
                  child: Text(
                    (index + 1).toString().padLeft(2, '0'),
                    style: TextStyle(
                        fontSize: widget.tamanho ?? 26,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
        ),
        Visibility(
          visible: numerosSelecionados.length == 6,
          child: TextButton(
              onPressed: () {
                if (numeroConcurso.text.isEmpty) {
                  const SnackbarAlertWidget(
                          duracao: 1,
                          title: 'Informe o número do concurso',
                          color: Colors.red)
                      .show(context);
                } else {
                  MyDatabase().insert(numerosSelecionadosModel);
                  String dataAtual =
                      '${DateTime.now().day.toString().padLeft(2, '0')}/${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().year}';

                  numerosSelecionadosModel.numero1 =
                      numerosSelecionados[0].toString();
                  numerosSelecionadosModel.numero2 =
                      numerosSelecionados[1].toString();
                  numerosSelecionadosModel.numero3 =
                      numerosSelecionados[2].toString();
                  numerosSelecionadosModel.numero4 =
                      numerosSelecionados[3].toString();
                  numerosSelecionadosModel.numero5 =
                      numerosSelecionados[4].toString();
                  numerosSelecionadosModel.numero6 =
                      numerosSelecionados[5].toString();
                  numerosSelecionadosModel.data = dataAtual;
                  numerosSelecionadosModel.concurso = numeroConcurso.text;

                  const SnackbarAlertWidget(
                          duracao: 2,
                          title: 'Números Adicionados com Sucesso!',
                          color: Colors.green)
                      .show(context);
                  setState(() {
                    numerosSelecionados.clear();
                    isSelectedList = List<bool>.filled(60, false);
                    totalSelect = 0;
                  });
                }
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: const Color(0xFF00875F),
                    borderRadius: BorderRadius.circular(8)),
                child: const Center(
                  child: Text(
                    'Incluir Aposta',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              )),
        )
      ],
    );
  }
}
