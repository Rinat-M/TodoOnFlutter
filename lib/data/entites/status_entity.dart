class StatusEntity {
  final int id;
  final String name;
  final String description;

  const StatusEntity({
    required this.id,
    required this.name,
    required this.description,
  });

  @override
  String toString() =>
      'StatusEntity(id: $id, name: $name, description=$description)';
}
