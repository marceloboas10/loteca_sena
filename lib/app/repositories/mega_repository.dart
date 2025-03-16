import 'dart:convert';

import 'package:loteria/app/data/http/exception.dart';
import 'package:loteria/app/data/http/http_client.dart';
import 'package:loteria/app/model/teste_model.dart';
import 'package:loteria/app/repositories/mega_repository_impl.dart';

class MegaRepository implements MegaRepositoryImpl {
  final IHttpClient client;

  MegaRepository({required this.client});

  @override
  Future<List<TesteModel>> getNumerosSorteados(String concurso) async {
    final response = await client.get(
        url: 'https://api.guidi.dev.br/loteria/megasena/$concurso');

    if (response.statusCode == 200) {
      final List<TesteModel> numerosSorteados = [];
      final body = jsonDecode(response.body);

      
        final TesteModel numeros = TesteModel.fromMap(body);
        numerosSorteados.add(numeros);
      
      return numerosSorteados;
    } else if (response.statusCode == 404) {
      throw NotFoundException('A URl não foi encontrada');
    } else {
      throw Exception("Não foi possível carregar os dados");
    }
  }

  @override
  Future<List<TesteModel>> getUltimoSorteio() async {
    final response = await client.get(
        url: 'https://api.guidi.dev.br/loteria/megasena/ultimo');

    if (response.statusCode == 200) {
      final List<TesteModel> numerosSorteados = [];
      final body = jsonDecode(response.body);

      final TesteModel numeros = TesteModel.fromMap(body);
      numerosSorteados.add(numeros);

      return numerosSorteados;
    } else if (response.statusCode == 404) {
      throw NotFoundException('A URl não foi encontrada');
    } else {
      throw Exception("Não foi possível carregar os dados");
    }
  }
}
