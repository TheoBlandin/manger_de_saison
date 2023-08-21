import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  0xFFFFF81F,
  <int, Color>{
    100: Color(0xFFFFF81F), 
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
  @override
  Widget build(BuildContext context) {
    final months = <String>[
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
      'Décembre',
      'Tout'
    ];

    final List<DropdownMenuEntry<String>> monthEntries =
        <DropdownMenuEntry<String>>[];
    for (final String month in months) {
      monthEntries.add(
        DropdownMenuEntry<String>(
            value: month.toUpperCase(), label: month.toUpperCase()),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.pink,
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
              initialSelection: "TOUT",
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
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            padding: const EdgeInsets.all(10),
            children: <Widget>[
              FoodCard(
                food: Food(
                  name: 'Carotte',
                  type: 0,
                  months: ['Janvier', 'Février', 'Mars'],
                  image: 'assets/images/carrot.svg'
                )
              ),
              FoodCard(
                food: Food(
                  name: 'Carotte',
                  type: 0,
                  months: ['Janvier', 'Février', 'Mars'],
                  image: 'assets/images/carrot.svg'
                )
              ),
              FoodCard(
                food: Food(
                  name: 'Carotte',
                  type: 0,
                  months: ['Janvier', 'Février', 'Mars'],
                  image: 'assets/images/carrot.svg'
                )
              ),
              FoodCard(
                food: Food(
                  name: 'Carotte',
                  type: 0,
                  months: ['Janvier', 'Février', 'Mars'],
                  image: 'assets/images/carrot.svg'
                )
              ),
            ]),
      ),
    );
  }
}
