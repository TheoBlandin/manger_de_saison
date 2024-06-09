import 'package:flutter/material.dart';
import 'main.dart';

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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Type d'aliment",
                                    style: TextStyle(
                                      color: secondaryText,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2,
                                    )),
                                const SizedBox(height: 5),
                                Wrap(
                                  spacing: 10.0,
                                  children: List<Widget>.generate(
                                    3,
                                    (int index) {
                                      return ChoiceChip(
                                        label: Text(sort[index]),
                                        labelStyle: TextStyle(
                                          color: widget.sortSelected == index
                                              ? text
                                              : unselected,
                                        ),
                                        selected: widget.sortSelected == index,
                                        pressElevation: 0.0,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 8),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        backgroundColor: Colors.white,
                                        selectedColor: Colors.white,
                                        side: BorderSide(
                                            color: widget.sortSelected == index
                                                ? primary
                                                : unselected,
                                            width: 2.0),
                                        onSelected: (bool selected) {
                                          setState(() {
                                            widget.sortSelected =
                                                selected ? index : 0;
                                          });
                                        },
                                      );
                                    },
                                  ).toList(),
                                ),
                                const SizedBox(height: 10),
                                const Text("Préférences",
                                    style: TextStyle(
                                      color: secondaryText,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2,
                                    )),
                                const SizedBox(height: 5),
                                Wrap(
                                  spacing: 5.0,
                                  children: List<Widget>.generate(
                                    3,
                                    (int index) {
                                      return ChoiceChip(
                                        label: Text(preferencies[index]),
                                        labelStyle: TextStyle(
                                          color: widget.prefSelected == index
                                              ? text
                                              : unselected,
                                        ),
                                        selected: widget.prefSelected == index,
                                        pressElevation: 0.0,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 8),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        backgroundColor: Colors.white,
                                        selectedColor: Colors.white,
                                        side: BorderSide(
                                            color: widget.prefSelected == index
                                                ? primary
                                                : unselected,
                                            width: 2.0),
                                        onSelected: (bool selected) {
                                          setState(() {
                                            widget.prefSelected =
                                                selected ? index : 0;
                                          });
                                        },
                                      );
                                    },
                                  ).toList(),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          widget.sortSelected = 0;
                                          widget.prefSelected = 0;
                                          setState(() {
                                            
                                          });
                                        },
                                        child: InkWell(
                                            child: Container(
                                                width: 140,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border:
                                                      Border.all(color: text),
                                                ),
                                                child: const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 20),
                                                    child: Text("Réinitialiser",
                                                        style: TextStyle(
                                                          color: text,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w400,
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
                                                width: 140,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: primary,
                                                ),
                                                child: const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
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
                            )
                          ],
                        ))))));
  }
}
