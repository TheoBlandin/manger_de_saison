import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manger_de_saison/food_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'food.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList('likes', []);
  prefs.setStringList('dislikes', []);

  runApp(MainApp(prefs: prefs));

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
  const MainApp({super.key, required this.prefs});

  final SharedPreferences prefs;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int? monthSelected;
  int? sortSelected;

  @override
  void initState() {
    super.initState();
    monthSelected = DateTime.now().month - 1;
    sortSelected = 0;
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
    if (jsonParse == null)
      // ignore: curly_braces_in_flow_control_structures
      readJson();
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

    final sort = <String>[
      'TOUT',
      'FRUITS',
      'LÉGUMES'
    ];

    var currentFoods = <FoodCard>[];
    if (foods == []) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    else {
      setState(() {
        currentFoods = []; // reset
        if (monthSelected == 12) { // "All" selected
          currentFoods = foods
              .where((food) => sortSelected == 0 || food.typeGetter == sortSelected! - 1)
              .map((food) => FoodCard(food: food, prefs: widget.prefs))
              .toList();
        }
        else {
          currentFoods = foods
              .where((food) => (food.monthsGetter.contains(monthSelected!)) && (sortSelected == 0 || food.typeGetter == sortSelected! - 1))
              .map((food) => FoodCard(food: food, prefs: widget.prefs))
              .toList();
        }
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
            leading: DropdownButtonHideUnderline(
              child: DropdownButton2(
                customButton: const Icon(
                  Icons.filter_list,
                  color: Colors.black,
                ),
                items: sort.map((String s) => DropdownMenuItem<String> (
                  value: sort.indexOf(s).toString(),
                  child: Text(s, style: GoogleFonts.khand(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                  )),
                )).toList(),
                value: sortSelected.toString(),
                onChanged: (String? value) {
                  setState(() {
                    sortSelected = int.parse(value!);
                  });
                },
                dropdownStyleData: const DropdownStyleData(
                  width: 100,
                ),
              ),
            ),
            title: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                items: months.map((String month) => DropdownMenuItem<String>(
                  value: months.indexOf(month).toString(),
                  child: Text(month, style: GoogleFonts.khand(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                  )),
                )).toList(),
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
