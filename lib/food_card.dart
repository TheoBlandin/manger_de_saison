// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:manger_de_saison/checkbox_indicator.dart';
import 'main.dart';

import 'food.dart';

class FoodCard extends StatefulWidget {
  final Food food;

  const FoodCard({super.key, required this.food});

  @override
  _FoodCardState createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  get food => widget.food;

  Food get foodGetter => food;

  Future<void> _dialogBuilder(BuildContext context, List<CheckboxIndicator> monthsRow1, List<CheckboxIndicator> monthsRow2) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Material(
          type: MaterialType.transparency,
          child: Center(
              child: FractionallySizedBox(
                widthFactor: 0.70,
                heightFactor: 0.50,
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
                              children: monthsRow1,
                            ),
                            Row(
                              children: monthsRow2,
                            ),
                          ],
                        )
                      ],
                    )
                  )
                )
              )
          ),
        );
      }
    );
  }

  void _showOverlay(BuildContext context, List<Checkbox> months_row1, List<Checkbox> months_row2) async {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        child: Container(
          color: Colors.black.withOpacity(0.5),
          child: Scaffold(
            body: Center(
              child: FractionallySizedBox(
                widthFactor: 0.70,
                heightFactor: 0.50,
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
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2,
                                )
                            ),
                            IconButton(
                              onPressed: () {
                                print("close overlay");
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
                              children: months_row1,
                            ),
                            Row(
                              children: months_row2,
                            ),
                          ],
                        )
                      ],
                    )
                  )
                )
              )
            )
          )
        )
      );
    });
    overlayState.insert(overlayEntry);
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

    return GestureDetector(
      onTap: () {
        _dialogBuilder(context, monthsRow1, monthsRow2);
        // _showOverlay(context, monthsRow1, monthsRows2);
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
