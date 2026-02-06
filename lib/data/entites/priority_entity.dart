class PriorityEntity {
  final int id;
  final String name;
  final String description;

  const PriorityEntity({
    required this.id,
    required this.name,
    required this.description,
  });

  @override
  String toString() =>
      'PriorityEntity(id: $id, name: $name, description=$description)';
}
