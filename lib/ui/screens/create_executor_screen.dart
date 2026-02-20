import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todos_app/common/string_constants.dart';
import 'package:todos_app/data/entites/executor_entity.dart';
import 'package:todos_app/data/providers/repository_providers.dart';

@RoutePage()
class CreateExecutorScreen extends HookConsumerWidget {
  const CreateExecutorScreen({super.key});

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return StringConstants.enterValidPhone;
    }

    RegExp regex = RegExp(
      r'^\+?7?\s?\(?\d{3}\)?[\s\-]?\d{3}[\s\-]?\d{2}[\s\-]?\d{2}$',
    );

    if (!regex.hasMatch(value)) {
      return StringConstants.invalidNumberFormat;
    }

    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final phoneController = useTextEditingController();

    final formKey = useMemoized(() => GlobalKey<FormState>());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(StringConstants.executor),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    label: Text(StringConstants.name),
                    hint: Text(StringConstants.enterName),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.name,
                  validator: (value) => (value?.trim().length ?? 0) < 2
                      ? StringConstants.minimumTwoCharacters
                      : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    label: Text(StringConstants.phone),
                    hint: Text(StringConstants.enterPhone),
                    prefixText: StringConstants.prefixPhone,
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) => validatePhone(value),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }

                      final todosRepository = ref.read(todosRepositoryProvider);
                      todosRepository.addExecutor(
                        ExecutorEntity(
                          id: 0,
                          name: nameController.value.text,
                          phone: phoneController.value.text,
                        ),
                      );

                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(StringConstants.executorHasBeenCreated),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Text(StringConstants.createExecutor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
