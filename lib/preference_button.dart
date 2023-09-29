import 'package:flutter/material.dart';
import 'package:manger_de_saison/main.dart';

class PreferenceButton extends StatelessWidget{
  final String text;
  final bool likeIcon; // true: like, false: dislike
  final bool state;
  final Function() onChanged;

  const PreferenceButton({super.key, required this.text, required this.likeIcon, required this.state, required this.onChanged});

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
            Icon(
              likeIcon ? Icons.favorite : Icons.heart_broken,
              color: state ? (likeIcon ? fullHeart : brokenHeart) : Colors.grey,
              size: 45
            ),
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