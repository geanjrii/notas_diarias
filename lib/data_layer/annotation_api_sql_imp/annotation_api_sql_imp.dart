import 'package:notas_diarias/data_layer/annotation_api/annotation_api.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../annotation_api/model/anotacao.dart';

final class AnnotationApiSqlImp implements AnnotationApi { 

  Database? _db;

  @override
  Future<int> saveAnnotation(Annotation annotation) async {
    final Database db = await _getDb();
    final int id =
        await db.insert('anotacao', annotation.toMap() as Map<String, dynamic>);
    return id;
  }

  @override
  Future<List> fetchAnnotations() async {
    final Database db = await _getDb();
    const String selectAnotacaoOrderByDataDesc =
        'SELECT * FROM anotacao ORDER BY data DESC';
    final List anotacoes = await db.rawQuery(selectAnotacaoOrderByDataDesc);
    return anotacoes;
  }

  @override
  Future<int> updateAnnotation(Annotation annotation) async {
    final Database dataBase = await _getDb();
    return await dataBase.update(
        'anotacao', annotation.toMap() as Map<String, dynamic>,
        where: 'id = ?', whereArgs: [annotation.id]);
  }

  @override
  Future<int> deleteAnnotation(int id) async {
    final Database dataBase = await _getDb();
    return await dataBase
        .delete('anotacao', where: 'id = ?', whereArgs: [id]);
  }

  Future<Database> _getDb() async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await _inicializarDb();
      return _db!;
    }
  }

  Future<Database> _inicializarDb() async {
    final String dbPath = await getDatabasesPath();
    final String dbFullPath = join(dbPath, 'banco_minhas_anotacaoes.db');
    final Database db =
        await openDatabase(dbFullPath, version: 1, onCreate: _create);
    return db;
  }

  void _create(Database db, int version) async {
    const String createTableAnotacao =
        'CREATE TABLE anotacao (id INTEGER PRIMARY KEY AUTOINCREMENT, titulo VARCHAR, descricao TEXT, data DATETIME)';
    await db.execute(createTableAnotacao);
  }
}
