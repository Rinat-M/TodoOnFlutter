class TodoEntity {
  final int id;
  final String description;
  final int priority;
  final int executor;
  final int? status;
  final DateTime? createdAt;
  final DateTime executionDate;

  const TodoEntity({
    required this.id,
    required this.description,
    required this.priority,
    required this.executor,
    required this.executionDate,
    this.status,
    this.createdAt,
  });
}
