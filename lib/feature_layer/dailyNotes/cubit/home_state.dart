part of 'home_cubit.dart';

class HomeState extends Equatable {
  final String title;
  final String description;
  final List<Annotation> annotations;
  final String saveOrUpdate;

  const HomeState({
    this.title = '',
    this.description = '',
    this.annotations = const [],
    this.saveOrUpdate = '',
  });

  HomeState copyWith({
    String? title,
    String? description,
    List<Annotation>? annotations,
    String? saveOrUpdate,
  }) {
    return HomeState(
      title: title ?? this.title,
      description: description ?? this.description,
      annotations: annotations ?? this.annotations,
      saveOrUpdate: saveOrUpdate ?? this.saveOrUpdate,
    );
  }

  @override
  List<Object> get props => [title, description, annotations, saveOrUpdate];
}
