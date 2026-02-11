import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos_app/data/entites/executor_entity.dart';
import 'package:todos_app/data/entites/priority_entity.dart';
import 'package:todos_app/data/entites/status_entity.dart';
import 'package:todos_app/data/entites/todo_with_relations.dart';
import 'package:todos_app/data/providers/repository_providers.dart';
import 'package:todos_app/common/logger.dart';

final prioritiesProvider = FutureProvider.autoDispose<List<PriorityEntity>>((
  ref,
) {
  logger.i('Init prioritiesProvider');
  final todosRepository = ref.watch(todosRepositoryProvider);
  return todosRepository.allPriorities;
});

final executorsProvider = FutureProvider.autoDispose<List<ExecutorEntity>>((
  ref,
) {
  logger.i('Init executorsProvider');
  final todosRepository = ref.watch(todosRepositoryProvider);
  return todosRepository.allExecutors;
});

final executorsStreamProvider = StreamProvider<List<ExecutorEntity>>((ref) {
  logger.i('Init executorsProvider');
  final todosRepository = ref.watch(todosRepositoryProvider);
  return todosRepository.watchExecutors();
});

final todosProvider = StreamProvider<List<TodoWithRelations>>((ref) {
  logger.i('Init todosProvider');
  final todosRepository = ref.watch(todosRepositoryProvider);
  return todosRepository.watchTodosWithRelations();
});

final todoDataProvider = StreamProvider.autoDispose
    .family<TodoWithRelations, int>((ref, id) {
      logger.i('Init todoDataProvider');
      final todosRepository = ref.watch(todosRepositoryProvider);
      return todosRepository.watchTodoWithRelationsById(id);
    });

final statusesProvider = FutureProvider<List<StatusEntity>>((ref) {
  logger.i('Init statusesProvider');
  final todosRepository = ref.watch(todosRepositoryProvider);
  return todosRepository.allStatuses;
});
