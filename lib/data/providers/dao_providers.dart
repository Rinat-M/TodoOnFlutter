import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos_app/data/database/daos/todos_dao.dart';
import 'package:todos_app/data/providers/database_provider.dart';

final todosDaoProvider = Provider<TodosDao>((ref) {
  final db = ref.watch(databaseProvider);
  return db.todosDao; // generated getter from @DriftDatabase(daos: [TodosDao])
});
