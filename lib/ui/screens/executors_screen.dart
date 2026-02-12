import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todos_app/common/string_constants.dart';
import 'package:todos_app/data/providers/data_providers.dart';
import 'package:todos_app/ui/components/styled_list_tile.dart';
import 'package:todos_app/ui/routes/app_routes.dart';

class ExecutorsScreen extends ConsumerWidget {
  const ExecutorsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final executorsAsync = ref.watch(executorsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(StringConstants.executors),
      ),
      body: executorsAsync.when(
        data: (items) {
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final executor = items[index];
              return SizedBox(
                key: ValueKey(executor.id),
                height: 70,
                child: StyledListTile(
                  title: executor.name,
                  subtitle: Text(executor.phone),
                  leading: const Icon(Icons.person),
                  height: 35,
                ),
              );
            },
          );
        },
        error: (error, stack) => Text('Error: $error'),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.createExecutor),
        tooltip: StringConstants.createExecutor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
