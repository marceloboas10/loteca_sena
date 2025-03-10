import 'package:flutter/material.dart';
import 'package:loteria/app/data/http/exception.dart';
import 'package:loteria/app/model/teste_model.dart';

import 'package:loteria/app/repositories/mega_repository_impl.dart';

class MegaStore {
  final MegaRepositoryImpl repository;

  MegaStore({required this.repository});

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<TesteModel>> state =
      ValueNotifier<List<TesteModel>>([]);

  final ValueNotifier<String> error = ValueNotifier<String>('');

  Future getNumerosSorteados(String concurso) async {
    isLoading.value = true;

    try {
      final result = await repository.getNumerosSorteados(concurso);
      state.value = result;
    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }
  }

  Future sorteioAnterior() async {
    isLoading.value = true;

    try {
      final result = await repository.getUltimoSorteio();
      state.value = result;
    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }
      isLoading.value = false;
  }
}
