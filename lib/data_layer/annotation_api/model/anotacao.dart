// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Annotation extends Equatable {
  final int? id;
  final String? title;
  final String? description;
  final String? date;
  const Annotation({
    this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  factory Annotation.fromMap(Map<String, dynamic> map) {
    return Annotation(
      id: map["id"],
      title: map["titulo"],
      description: map["descricao"],
      date: map["data"],
    );
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "titulo": title,
      "descricao": description,
      "data": date,
    };

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

  Annotation copyWith({
    int? id,
    String? title,
    String? description,
    String? date,
  }) {
    return Annotation(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }

  @override
  List<Object?> get props => [id, title, description, date];
}
