// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:manger_de_saison/food_card_zoomed.dart';
import 'main.dart';

import 'food.dart';

class FoodCard extends StatelessWidget {
  final Food food;

  const FoodCard({super.key, required this.food});

  Food get foodGetter => food;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return FoodCardZoomed(food: food);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              spreadRadius: 0,
              offset: const Offset(0, 0),
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Row(
              children: [
                Text(food.typeGetter == 0 ? 'F' : 'L',
                    style: TextStyle(
                      color: food.typeGetter == 0 ? fruit : vegetable,
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ))
              ],
            ),
            SvgPicture.asset(
              food.imageGetter,
              height: 50,
              width: 50,
            ),
            Text(food.nameGetter,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.2
                ),
                textAlign: TextAlign.center,
            ),
          ]),
        )
      )
    );
  }
}
