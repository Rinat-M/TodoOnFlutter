import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos_app/data/database/repositories/todos_repository.dart';
import 'package:todos_app/data/providers/dao_providers.dart';
import 'package:todos_app/utils/logger.dart';

final todosRepositoryProvider = Provider<TodosRepository>((ref) {
  logger.i('Init todosRepositoryProvider');
  final dao = ref.watch(todosDaoProvider);
  return TodosRepository(dao);
});
