import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manger_de_saison/food_card.dart';

import 'food.dart';

void main() {
  runApp(const MainApp());

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
}

const MaterialColor winter = MaterialColor(
  0xFF99B2D6,
  <int, Color>{
    100: Color(0xFF99B2D6),
  },
);
const MaterialColor spring = MaterialColor(
  0xFFBDE38C,
  <int, Color>{
    100: Color(0xFFBDE38C),
  },
);
const MaterialColor summer = MaterialColor(
  0xFFFFFA70,
  <int, Color>{
    100: Color(0xFFFFFA70),
  },
);
const MaterialColor autumn = MaterialColor(
  0xFFF2C37D,
  <int, Color>{
    100: Color(0xFFF2C37D),
  },
);
const MaterialColor vegetable = MaterialColor(
  0xFF1E6C0E,
  <int, Color>{
    100: Color(0xFF1E6C0E),
  },
);
const MaterialColor fruit = MaterialColor(
  0xFF5C0E6C,
  <int, Color>{
    100: Color(0xFF5C0E6C),
  },
);
const MaterialColor fullHeart = MaterialColor(
  0xFFDE59A1,
  <int, Color>{
    100: Color(0xFFDE59A1),
  },
);
const MaterialColor brokenHeart = MaterialColor(
  0xFF4D3397,
  <int, Color>{
    100: Color(0xFF4D3397),
  },
);
const MaterialColor inSeason = MaterialColor(
  0xFFB6E27D,
  <int, Color>{
    100: Color(0xFFB6E27D),
  },
);
const MaterialColor outSeason = MaterialColor(
  0xFFD9D9D9,
  <int, Color>{
    100: Color(0xFFD9D9D9),
  },
);

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int? monthSelected;

  @override
  void initState() {
    super.initState();
    monthSelected = DateTime.now().month - 1;
  }

  var foods = <Food>[];
  // ignore: prefer_typing_uninitialized_variables
  var jsonParse;
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/calendar.json');
    final data = await json.decode(response);
    setState(() {
      jsonParse = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: curly_braces_in_flow_control_structures
    if (jsonParse == null)
      readJson();
    else {
      jsonParse.forEach((key, value) {
        var newFood = Food(
          name: key,
          type: value['type'],
          months:
              (value['season'] as List).map((item) => item as String).toList(),
          image: value['pic'] ?? 'assets/pics/unknown.svg',
        );
        foods.add(newFood);
      });
    }

    final months = <String>[
      'JANVIER',
      'FÉVRIER',
      'MARS',
      'AVRIL',
      'MAI',
      'JUIN',
      'JUILLET',
      'AOÛT',
      'SEPTEMBRE',
      'OCTOBRE',
      'NOVEMBRE',
      'DÉCEMBRE',
      'TOUT'
    ];

    final List<DropdownMenuEntry<String>> monthEntries =
        <DropdownMenuEntry<String>>[];
    for (final String month in months) {
      monthEntries.add(
        DropdownMenuEntry<String>(
            value: months.indexOf(month).toString(), label: month),
      );
    }
    var currentFoods = <Widget>[];

    if (foods == []) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    else {
      setState(() {
        currentFoods = foods
            .where((food) => food.monthsGetter.contains(months[monthSelected!].toLowerCase()))
            .map((food) => FoodCard(food: food))
            .toList();
      });
    }
    

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Khand'),
      home: Scaffold(
        backgroundColor: monthSelected! < 2 || monthSelected! > 10
            ? winter
            : monthSelected! < 5
                ? spring
                : monthSelected! < 8
                    ? summer
                    : autumn,
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0.0,
            leading: IconButton(
              icon: const Icon(Icons.filter_list),
              color: Colors.black,
              onPressed: () {},
            ),
            title: DropdownMenu(
                dropdownMenuEntries: monthEntries,
                initialSelection: monthSelected.toString(),
                enableSearch: false,
                trailingIcon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                ),
                width: 140,
                inputDecorationTheme: const InputDecorationTheme(
                  outlineBorder: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                onSelected: (value) {
                  debugPrint(value);
                  setState(() {
                    monthSelected = int.parse(value!);
                    debugPrint(monthSelected.toString());
                  });
                }),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                color: Colors.black,
                onPressed: () {},
              )
            ]),
        body: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 7,
            mainAxisSpacing: 7,
            childAspectRatio: 0.85,
            padding: const EdgeInsets.all(7),
            children: currentFoods,
        )
      ),
    );
  }
}
