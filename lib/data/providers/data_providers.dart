import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos_app/data/database/app_database.dart';
import 'package:todos_app/data/providers/repository_providers.dart';

final prioritiesProviders = FutureProvider<List<Priority>>((ref) {
  final todosRepository = ref.watch(todosRepositoryProvider);
  return todosRepository.allPriorities;
});

final executorsProviders = FutureProvider<List<Executor>>((ref) {
  final todosRepository = ref.watch(todosRepositoryProvider);
  return todosRepository.allExecutors;
});
