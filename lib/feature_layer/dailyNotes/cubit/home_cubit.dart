// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:notas_diarias/domain_layer/domain_layer.dart';

import '../../../data_layer/annotation_api/model/anotacao.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required AnnotationRepository repository,
  })  : _repository = repository,
        super(const HomeState());

  final AnnotationRepository _repository;

  Future<void> onSubmited({Annotation? selectedAnnotation}) async {
    final Annotation anotacao = Annotation(
      title: state.title,
      description: state.description,
      date: DateFormat('d/M/y H:m:s').format(DateTime.now()),
    );

    if (selectedAnnotation == null) {
      await _repository.saveAnnotation(anotacao);
    } else {
      await _repository
          .updateAnnotation(anotacao.copyWith(id: selectedAnnotation.id));
    }
    emit(state.copyWith(saveOrUpdate: '', title: '', description: ''));

    await fetchAnnotation();
  }

  Future<void> onDeleted(int id) async {
    await _repository.deleteAnnotation(id);
    await fetchAnnotation();
  }

  Future<void> fetchAnnotation() async {
    final List anotacoesRecuperadas = await _repository.fetchAnnotations();
    final annotations =
        anotacoesRecuperadas.map((item) => Annotation.fromMap(item)).toList();

    emit(state.copyWith(annotations: annotations));
  }

  void register({Annotation? anotacao}) {
    if (anotacao == null) {
      emit(state.copyWith(
        saveOrUpdate: 'Salvar',
        title: '',
        description: '',
      ));
    } else {
      emit(state.copyWith(
        saveOrUpdate: 'Atualizar',
        title: anotacao.title!,
        description: anotacao.description!,
      ));
    }
  }

  void onTitleChanged(String title) {
    emit(state.copyWith(title: title));
  }

  void onDescriptionChanged(String description) {
    emit(state.copyWith(description: description));
  }
}
