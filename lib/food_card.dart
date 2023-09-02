// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

  void _showOverlay(BuildContext context) async {
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


    List<Checkbox> months = [];
    
    for (var i = 0; i < 12; i++) {
      
    }

    return GestureDetector(
      onTap: () {
        _showOverlay(context);
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
            )
          ]),
        )
      )
    );
  }
}
