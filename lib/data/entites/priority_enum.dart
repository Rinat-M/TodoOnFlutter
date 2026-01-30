enum PriorityEnum {
  low(name: 'Low'),
  medium(name: 'Medium'),
  high(name: 'High');

  const PriorityEnum({required this.name});

  final String name;

  static PriorityEnum fromString(String value) {
    return PriorityEnum.values.firstWhere(
      (e) => e.name == value,
      orElse: () => throw UnimplementedError("Unknown priority: $value"),
    );
  }
}
