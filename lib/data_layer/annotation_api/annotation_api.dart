import 'model/anotacao.dart';

abstract interface class AnnotationApi {
  Future<int> saveAnnotation(Annotation anotacao);

  Future<List> fetchAnnotations();

  Future<int> updateAnnotation(Annotation anotacao);

  Future<int> deleteAnnotation(int id);
}
