// lib/widgets/card_widget.dart
import 'package:collectics/features/home/models/cards_model.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final CardModel card;
  final bool isGridView;

  const CardWidget({
    super.key,
    required this.card,
    this.isGridView = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isGridView ? double.infinity : 380,
      height: isGridView ? 200 : 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              card.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                card.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}