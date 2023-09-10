import 'package:flutter/material.dart';

class PreferenceButton extends StatefulWidget{
  final String text;
  final Icon icon;
  final bool state;
  final Function(bool) onChanged;

  PreferenceButton({required this.text, required this.icon, required this.state, required this.onChanged});

  @override
  _PreferenceButtonState createState() => _PreferenceButtonState();
}

class _PreferenceButtonState extends State<PreferenceButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget.icon,
        SizedBox(width: 10),
        Text(widget.text),
        Spacer(),
        Switch(
          value: widget.state,
          onChanged: (value) {
            setState(() {
              widget.onChanged(value);
            });
          },
        ),
      ],
    );
  }
}