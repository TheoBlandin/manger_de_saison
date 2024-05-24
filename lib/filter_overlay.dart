import 'package:flutter/material.dart';
import 'main.dart';

import 'dropdown_filter.dart';

// ignore: must_be_immutable
class FiltersOverlay extends StatefulWidget {
  final Function(int, int) onSelected;
  int sortSelected;
  int prefSelected;

  FiltersOverlay({Key? key, required this.onSelected, required this.sortSelected, required this.prefSelected}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FiltersOverlayState createState() => _FiltersOverlayState();
}

class _FiltersOverlayState extends State<FiltersOverlay> {
  final sort = <String>[
    'Tout',
    'Fruits',
    'Légumes'
  ];

  final preferencies = <String>[
    'Tout',
    'J\'aime',
    'Je n\'aime pas'
  ];

  @override
  Widget build(BuildContext context) {
    return  Material(
      type: MaterialType.transparency,
        child: FractionallySizedBox(
          widthFactor: 0.80,
          heightFactor: 0.35,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Options de tri",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
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
                    ]
                  ),
                  Container(
                    height: 1,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 1,
                        )
                      )
                    )
                  ),
                  const SizedBox(height: 10),
                  DropdownFilter(
                    title: "Type d'aliment",
                    items: sort,
                    onSelected: (int value) => setState(() { widget.sortSelected = value; }),
                    selected: widget.sortSelected,
                  ),
                  const SizedBox(height: 10),
                  DropdownFilter(
                    title: "Préférences",
                    items: preferencies,
                    onSelected: (int value) => setState(() { widget.prefSelected = value; }),
                    selected: widget.prefSelected,
                  ),
                  TextButton(
                    onPressed: () {
                      widget.onSelected(widget.sortSelected, widget.prefSelected);
                      Navigator.of(context).pop();
                    },
                    child: InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: primary,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Appliquer",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              height: 1.2,
                            )
                          )
                        )
                      )
                    )
                  )
                ],
              )
            )
          )
      )
    );
  }
}

