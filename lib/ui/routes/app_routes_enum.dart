enum AppRoutesEnum {
  main(path: '/'),
  createTodo(path: '/create_todo'),
  editTodo(path: '/edit_todo'),
  executors(path: '/executors'),
  createExecutor(path: '/create_executor');

  const AppRoutesEnum({required this.path});

  final String path;
}
