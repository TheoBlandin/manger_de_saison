import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manger_de_saison/food_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'filter_overlay.dart';
import 'food.dart';

Key myGridViewKey = UniqueKey();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.getStringList("likes") ?? prefs.setStringList("likes", []);
  prefs.getStringList("dislikes") ?? prefs.setStringList("dislikes", []);

  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MainApp(prefs: prefs) ));

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
}

const MaterialColor primary = MaterialColor(
  0xFF489949,
  <int, Color> {
    100: Color(0xFF489949),
  },
);
const MaterialColor background = MaterialColor(
  0xFFE6F1E6,
  <int, Color> {
    100: Color(0xFFE6F1E6),
  },
);
const MaterialColor text = MaterialColor(
  0xFF010F01,
  <int, Color> {
    100: Color(0xFF010F01),
  },
);
const MaterialColor secondaryText = MaterialColor(
  0xFF4E5A4E,
  <int, Color> {
    100: Color(0xFF4E5A4E),
  },
);
// const MaterialColor winter = MaterialColor(
//   0xFF99B2D6,
//   <int, Color>{
//     100: Color(0xFF99B2D6),
//   },
// );
// const MaterialColor spring = MaterialColor(
//   0xFFBDE38C,
//   <int, Color>{
//     100: Color(0xFFBDE38C),
//   },
// );
// const MaterialColor summer = MaterialColor(
//   0xFFFFFA70,
//   <int, Color>{
//     100: Color(0xFFFFFA70),
//   },
// );
// const MaterialColor autumn = MaterialColor(
//   0xFFF2C37D,
//   <int, Color>{
//     100: Color(0xFFF2C37D),
//   },
// );
// const MaterialColor all = MaterialColor(
//   0xFF9C9C9C,
//   <int, Color>{
//     100: Color(0xFF9C9C9C),
//   },
// );
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
  const MainApp({super.key, required this.prefs});

  final SharedPreferences prefs;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int? monthSelected;
  int? sortSelected;
  int? prefSelected;
  String? searchValue;
  var currentFoods = <FoodCard>[];

  final months = <String>[
    'Tout',
    'Janvier',
    'Février',
    'Mars',
    'Avril',
    'Mai',
    'Juin',
    'Juillet',
    'Août',
    'Septembre',
    'Octobre',
    'Novembre',
    'Décembre'
  ];

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
  void initState() {
    super.initState();
    monthSelected = DateTime.now().month;
    sortSelected = 0;
    prefSelected = 0;
  }

  @override
  Widget build(BuildContext context) {
    if (jsonParse == null) {
      readJson();
    }
    else if (foods.isEmpty) {
      jsonParse.forEach((key, value) {
        var newFood = Food(
          name: key,
          type: value['type'],
          months:
              (value['season'] as List).map((item) => item as int).toList(),
          image: value['pic'] ?? 'assets/pics/unknown.svg',
        );
        foods.add(newFood);
      });
    }

    if (foods != []) {
      if (monthSelected == 0) { // "Tout" selected
        currentFoods = foods
            .where((food) => (sortSelected == 0 || food.typeGetter == sortSelected! - 1) && (prefSelected == 0 || (prefSelected == 1 ? widget.prefs.getStringList("likes")!.contains(food.nameGetter) : widget.prefs.getStringList("dislikes")!.contains(food.nameGetter))) && (searchValue == null || RegExp("^${searchValue!.toLowerCase()}").hasMatch(food.nameGetter.toLowerCase())))
            .map((food) => FoodCard(food: food, prefs: widget.prefs))
            .toList();
      }
      else {
        currentFoods = foods
            .where((food) => (food.monthsGetter.contains(monthSelected!)) && (sortSelected == 0 || food.typeGetter == sortSelected! - 1) && (prefSelected == 0 || (prefSelected == 1 ? widget.prefs.getStringList("likes")!.contains(food.nameGetter) : widget.prefs.getStringList("dislikes")!.contains(food.nameGetter))) && (searchValue == null || RegExp("^${searchValue!.toLowerCase()}").hasMatch(food.nameGetter.toLowerCase())))
            .map((food) => FoodCard(food: food, prefs: widget.prefs))
            .toList();
      }
      myGridViewKey = UniqueKey();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: GoogleFonts.dosis().fontFamily),
      home: Scaffold(
        // backgroundColor: monthSelected == 0 ? all :
        //   monthSelected! <= 2 || monthSelected! == 12
        //     ? winter
        //     : monthSelected! <= 5
        //       ? spring
        //       : monthSelected! <= 8
        //         ? summer
        //         : autumn,
        backgroundColor: background,
        appBar: EasySearchBar(
          onSearch: (value) => setState(() { searchValue = value; }),
          title: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              items: months.map((String month) => DropdownMenuItem<String>(
                value: months.indexOf(month).toString(),
                child: Text(month, style: const TextStyle(
                  color: text,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                )),
              )).toList(),
              buttonStyleData: const ButtonStyleData(
                width: 100,
              ),
              value: monthSelected.toString(),
              onChanged: (String? value) {
                setState(() {
                  monthSelected = int.parse(value!);
                });
              },
              dropdownStyleData: const DropdownStyleData(
                maxHeight: 350,
              ),
            ),
          ),
          searchBackgroundColor: Colors.white,
          searchCursorColor: Colors.black,
          searchHintText: 'Rechercher un aliment',
          backgroundColor: Colors.white,
          searchBackIconTheme: const IconThemeData(color: Colors.black),
          searchClearIconTheme: const IconThemeData(color: Colors.black),
          elevation: 0.0,
          leading: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: const Icon(
                Icons.tune,
                color: text,
              ),
              onPressed: () {
                showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return FiltersOverlay(
                        sortSelected: sortSelected!,
                        prefSelected: prefSelected!,
                        onSelected: (int n, int m) => setState(() { sortSelected = n; prefSelected = m; }),
                      );
                    },
                );
              }
            )
          ),
        ),
        body: GridView.count(
            key: myGridViewKey,
            crossAxisCount: 3,
            crossAxisSpacing: 7,
            mainAxisSpacing: 7,
            childAspectRatio: 0.85,
            padding: const EdgeInsets.all(7),
            children: currentFoods,
        )
      )
    );
  }
}
