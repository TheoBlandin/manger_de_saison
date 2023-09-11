import 'package:flutter/material.dart';

class PreferenceButton extends StatelessWidget{
  final String text;
  final Icon icon;
  final bool state;
  final Function() onChanged;

  const PreferenceButton({super.key, required this.text, required this.icon, required this.state, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged();
      },
      child: Opacity(
        opacity: state ? 1 : 0.5,
        child: Column(
          children: [
            icon,
            const SizedBox(height: 7),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16
              )
            ),
          ]
        )
      )
    );
  }
}