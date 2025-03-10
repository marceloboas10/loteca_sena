import 'package:loteria/app/model/teste_model.dart';

abstract class MegaRepositoryImpl {
  Future<List<TesteModel>> getNumerosSorteados(String concurso);

  Future<List<TesteModel>> getUltimoSorteio();
}
