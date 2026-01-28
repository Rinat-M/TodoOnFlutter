import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos_app/data/database/repositories/todos_repository.dart';
import 'package:todos_app/data/providers/dao_providers.dart';

final todosRepositoryProvider = Provider<TodosRepository>((ref) {
  final dao = ref.watch(todosDaoProvider);
  return TodosRepository(dao);
});
