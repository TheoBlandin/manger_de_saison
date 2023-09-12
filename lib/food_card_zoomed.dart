// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'checkbox_indicator.dart';
import 'preference_button.dart';
import 'food.dart';
import 'main.dart';

class FoodCardZoomed extends StatefulWidget {
  final Food food;
  final SharedPreferences prefs;
  final Function(bool) changePreference;

  const FoodCardZoomed({super.key, required this.food, required this.prefs, required this.changePreference});

  @override
  _FoodCardZoomedState createState() => _FoodCardZoomedState();
}

class _FoodCardZoomedState extends State<FoodCardZoomed> {
  get food => widget.food;

  int preferenceChoice = 0;
  // 0 : no choice
  // 1 : like
  // 2 : dislike

  @override
  void initState() {
    super.initState();
    if (widget.prefs.getStringList('likes')?.contains(food.nameGetter) ?? false) {
      preferenceChoice = 1;
    }
    else if (widget.prefs.getStringList('dislikes')?.contains(food.nameGetter) ?? false) {
      preferenceChoice = 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> nameMonths = ["JAN", "FEV", "MAR", "AVR", "MAI", "JUI", "JUI", "AOU", "SEP", "OCT", "NOV", "DEC"];

    List<CheckboxIndicator> monthsRow1 = [];
    List<CheckboxIndicator> monthsRow2 = [];

    for (var i = 0; i < 6; i++) {
      monthsRow1.add(CheckboxIndicator(food.monthsGetter.contains(i), nameMonths[i]));
    }
    for (var i = 6; i < 12; i++) {
      monthsRow2.add(CheckboxIndicator(food.monthsGetter.contains(i), nameMonths[i]));
    }

    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.70,
          heightFactor: 0.60,
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
                borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
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
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                          )
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black
                        )
                      )  
                    ],
                  ),
                  Text(
                    food.nameGetter,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      height: 1.2
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SvgPicture.asset(
                    food.imageGetter,
                    height: 80,
                    width: 80,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: monthsRow1,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: monthsRow2,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      PreferenceButton(
                        text: "J'aime",
                        icon: const Icon(
                          Icons.favorite,
                          color: fullHeart,
                          size: 45
                        ),
                        state: preferenceChoice == 1,
                        onChanged: () {
                          if (preferenceChoice == 1) {
                            setState(() {
                              preferenceChoice = 0;
                            });
                          } else {
                            setState(() {
                              preferenceChoice = 1;
                            });
                          }
                          widget.changePreference(true);
                        },
                      ),
                      PreferenceButton(
                        text: "Je n'aime pas",
                        icon: const Icon(
                          Icons.heart_broken,
                          color: brokenHeart,
                          size: 45
                        ),
                        state: preferenceChoice == 2,
                        onChanged: () {
                          if (preferenceChoice == 2) {
                            setState(() {
                              preferenceChoice = 0;
                            });
                          } else {
                            setState(() {
                              preferenceChoice = 2;
                            });
                          }
                          widget.changePreference(false);
                        },
                      )
                    ]
                  )
                ],
              )
            )
          )
        )
      ),
    );
  }
}