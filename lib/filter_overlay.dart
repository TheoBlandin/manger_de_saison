import 'package:flutter/material.dart';
import 'main.dart';

import 'dropdown_filter.dart';

// ignore: must_be_immutable
class FiltersOverlay extends StatefulWidget {
  final Function(int, int) onSelected;
  int sortSelected;
  int prefSelected;

  FiltersOverlay(
      {Key? key,
      required this.onSelected,
      required this.sortSelected,
      required this.prefSelected})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FiltersOverlayState createState() => _FiltersOverlayState();
}

class _FiltersOverlayState extends State<FiltersOverlay> {
  final sort = <String>['Tout', 'Fruits', 'Légumes'];

  final preferencies = <String>['Tout', 'J\'aime', 'Je n\'aime pas'];

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: IntrinsicHeight(
            child: Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Filtres",
                                      style: TextStyle(
                                        color: text,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                        height: 1.2,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      icon: const Icon(Icons.close,
                                          color: Colors.black))
                                ]),
                            Container(
                                height: 3,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: primary)),
                            const SizedBox(height: 10),
                            DropdownFilter(
                              title: "Type d'aliment",
                              items: sort,
                              onSelected: (int value) => setState(() {
                                widget.sortSelected = value;
                              }),
                              selected: widget.sortSelected,
                            ),
                            const SizedBox(height: 10),
                            DropdownFilter(
                              title: "Préférences",
                              items: preferencies,
                              onSelected: (int value) => setState(() {
                                widget.prefSelected = value;
                              }),
                              selected: widget.prefSelected,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                onPressed: () {
                                  widget.onSelected(
                                      widget.sortSelected, widget.prefSelected);
                                  Navigator.of(context).pop();
                                },
                                child: InkWell(
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(color: text),
                                        ),
                                        child: const Padding(
                                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                            child: Text("Réinitialiser",
                                                style: TextStyle(
                                                  color: text,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.2,
                                                )))))),
                                TextButton(
                                    onPressed: () {
                                      widget.onSelected(widget.sortSelected,
                                          widget.prefSelected);
                                      Navigator.of(context).pop();
                                    },
                                    child: InkWell(
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: primary,
                                            ),
                                            child: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 20),
                                                child: Text("Appliquer",
                                                    style: TextStyle(
                                                      color: text,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.2,
                                                    ))))))
                              ],
                            )
                          ],
                        ))))));
  }
}
