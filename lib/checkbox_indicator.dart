import 'package:flutter/material.dart';

import 'main.dart';

class CheckboxIndicator extends StatelessWidget {
  bool state;
  String month;

  CheckboxIndicator(this.state, this.month, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Checkbox(
          value: state,
          onChanged: null,
          checkColor: Colors.black,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          fillColor: MaterialStatePropertyAll(state ? inSeason : outSeason),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(
          height: 3,
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