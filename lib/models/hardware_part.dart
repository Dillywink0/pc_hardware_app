// models/hardware_part.dart
class HardwarePart {
  final String name;
  final String description;
  final double price;
  final String category; // Added category field

  HardwarePart({
    required this.name,
    required this.description,
    required this.price,
    required this.category, // Added category field
  });
}
