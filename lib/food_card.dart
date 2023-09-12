// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:manger_de_saison/food_card_zoomed.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

import 'food.dart';

class FoodCard extends StatefulWidget {
  final Food food;
  final SharedPreferences prefs;

  const FoodCard({super.key, required this.food, required this.prefs});

  @override
  _FoodCardState createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  get prefs => widget.prefs;
  get food => widget.food;
  Food get foodGetter => widget.food;

  int preferenceChoice = 0;
  @override
  initState() {
    super.initState();
    if (prefs.getStringList('likes')?.contains(food.nameGetter) ?? false) {
      preferenceChoice = 1;
    } else if (prefs.getStringList('dislikes')?.contains(food.nameGetter) ?? false) {
      preferenceChoice = 2;
    }
  }

  void changePreference(bool likeBtn) {
    if (likeBtn) {
      if (preferenceChoice == 1) {
        setState(() {
          preferenceChoice = 0;
        });
      } else {
        setState(() {
          preferenceChoice = 1;
        });
      }
    } else {
      if (preferenceChoice == 2) {
        setState(() {
          preferenceChoice = 0;
        });
      } else {
        setState(() {
          preferenceChoice = 2;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return FoodCardZoomed(
                    food: food,
                    prefs: prefs,
                    changePreference: changePreference);
              }).then((value) {
            if (preferenceChoice != 0) {
              if (preferenceChoice == 1) {
                List<String> likedFoods = widget.prefs.getStringList('likes') ?? [];
                if (likedFoods.contains(food.nameGetter)) {
                  return;
                }
                likedFoods.add(food.nameGetter);
                widget.prefs.setStringList('likes', likedFoods);

                List<String> dislikedFoods = widget.prefs.getStringList('dislikes') ?? [];
                dislikedFoods.remove(food.nameGetter);
                widget.prefs.setStringList('dislikes', dislikedFoods);
              } else {
                List<String> dislikedFoods = widget.prefs.getStringList('dislikes') ?? [];
                if (dislikedFoods.contains(food.nameGetter)) {
                  return;
                }
                dislikedFoods.add(food.nameGetter);
                widget.prefs.setStringList('dislikes', dislikedFoods);

                List<String> likedFoods = widget.prefs.getStringList('likes') ?? [];
                likedFoods.remove(food.nameGetter);
                widget.prefs.setStringList('likes', likedFoods);
              }
            } else {
              List<String> likedFoods = widget.prefs.getStringList('likes') ?? [];
              likedFoods.remove(food.nameGetter);
              widget.prefs.setStringList('likes', likedFoods);

              List<String> dislikedFoods = widget.prefs.getStringList('dislikes') ?? [];
              dislikedFoods.remove(food.nameGetter);
              widget.prefs.setStringList('dislikes', dislikedFoods);
            }
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
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(food.typeGetter == 0 ? 'F' : 'L',
                            style: TextStyle(
                              color: food.typeGetter == 0 ? fruit : vegetable,
                              fontSize: 23,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                            )),
                        preferenceChoice == 0
                            ? const SizedBox.shrink()
                            : Icon(
                                preferenceChoice == 1
                                    ? Icons.favorite
                                    : Icons.heart_broken,
                                color: preferenceChoice == 1
                                    ? fullHeart
                                    : brokenHeart,
                                size: 23,
                              ),
                      ],
                    ),
                    SvgPicture.asset(
                      food.imageGetter,
                      height: 50,
                      width: 50,
                    ),
                    Text(
                      food.nameGetter,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1.2),
                      textAlign: TextAlign.center,
                    ),
                  ]),
            )));
  }
}
