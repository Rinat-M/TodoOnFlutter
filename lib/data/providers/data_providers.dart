import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos_app/data/entites/executor_entity.dart';
import 'package:todos_app/data/entites/priority_entity.dart';
import 'package:todos_app/data/entites/todo_with_relations.dart';
import 'package:todos_app/data/providers/repository_providers.dart';
import 'package:todos_app/utils/logger.dart';

final prioritiesProviders = FutureProvider<List<PriorityEntity>>((ref) {
  logger.i('Init prioritiesProviders');
  final todosRepository = ref.watch(todosRepositoryProvider);
  return todosRepository.allPriorities;
});

final executorsProviders = FutureProvider<List<ExecutorEntity>>((ref) {
  logger.i('Init executorsProviders');
  final todosRepository = ref.watch(todosRepositoryProvider);
  return todosRepository.allExecutors;
});

final todosProviders = StreamProvider<List<TodoWithRelations>>((ref) {
  logger.i('Init todosProviders');
  final todosRepository = ref.watch(todosRepositoryProvider);
  return todosRepository.watchTodosWithRelations();
});
