// lib/models/card.dart
class CardModel {
  final int id;
  final String imageUrl;
  final String name;
  final double offset;

  CardModel({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.offset,
  });
}