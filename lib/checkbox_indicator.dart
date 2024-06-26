import 'package:flutter/material.dart';
import 'main.dart';

// ignore: must_be_immutable
class CheckboxIndicator extends StatelessWidget {
  bool state;
  String month;

  CheckboxIndicator(this.state, this.month, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: state ? inSeason : outSeason,
                  borderRadius: BorderRadius.circular(5)
                )
              )
            ),
            state ? const Positioned(
              top: 4,
              child: Icon(
                Icons.check,
                color: secondaryText,
                size: 20,
              )
            ) : const SizedBox.shrink()
          ]
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          month,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            height: 0.7
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}