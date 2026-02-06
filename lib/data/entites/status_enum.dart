enum StatusEnum {
  assigned(name: 'Assigned'),
  inProcess(name: 'InProcess'),
  completed(name: 'Completed');

  const StatusEnum({required this.name});

  final String name;

  static StatusEnum fromString(String value) {
    return StatusEnum.values.firstWhere(
      (e) => e.name == value,
      orElse: () => throw UnimplementedError("Unknown status: $value"),
    );
  }
}
