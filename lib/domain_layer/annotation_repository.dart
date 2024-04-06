import 'package:notas_diarias/data_layer/data_layer.dart';

class AnnotationRepository {
  final AnnotationApi _api;

  AnnotationRepository({required AnnotationApi api}) : _api = api;

  Future<int> saveAnnotation(Annotation anotacao) {
    return _api.saveAnnotation(anotacao);
  }

  Future<List> fetchAnnotations() {
    return _api.fetchAnnotations();
  }

  Future<int> updateAnnotation(Annotation anotacao) {
    return _api.updateAnnotation(anotacao);
  }

  Future<int> deleteAnnotation(int id) {
    return _api.deleteAnnotation(id);
  }
}
