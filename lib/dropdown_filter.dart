import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropdownFilter extends StatelessWidget {
  final String title;
  final List<String> items;
  final Function(int) onSelected;
  final int selected;

  const DropdownFilter({super.key, 
    required this.title,
    required this.items,
    required this.onSelected,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return 
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          textAlign: TextAlign.left,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 1.2,
          )
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            items: items.map<DropdownMenuItem<String>>((String item) => DropdownMenuItem<String>(
              value: items.indexOf(item).toString(),
              child: Text(item, style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 1.2,
              )),
            )).toList(),
            value: selected.toString(),
            buttonStyleData: const ButtonStyleData(
              width: 125,
            ),
            onChanged: (String? value) {
              onSelected(int.parse(value!));
            }
          ),
        )
      ]
    );
  }
}