import 'package:flutter/material.dart';

import 'food.dart';

class FoodCard extends StatelessWidget {
  final Food food;

  const FoodCard({required this.food});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [ BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 15,
          spreadRadius: 0,
          offset: const Offset(0, 0),
        ) ],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(food.nameGetter),
    );
  }
}