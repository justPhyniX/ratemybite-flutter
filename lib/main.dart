import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:ratemybite/Models/DTOs/ProductDto.dart';
import 'package:ratemybite/Models/Ingredient.dart';
import 'package:ratemybite/pages/history.dart';
import 'package:ratemybite/pages/more.dart';
import 'package:ratemybite/pages/scan.dart';
import 'package:ratemybite/theme.dart';



void main() async {
  // Initialize Hive (Local db)
  await Hive.initFlutter();

  Hive.registerAdapter(ProductDtoAdapter());
  Hive.registerAdapter(IngredientAdapter());
  
  // Open a hive box
  await Hive.openBox('HISTORY_BOX');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rate My Bite',
      theme: darkMode,
      //darkTheme: ,    For future use
      home: const MyHomePage(title: 'Scan'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> pages = [
    const HistoryPage(),
    const ScanPage(),
    const MorePage(),
  ];

  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Container(
          color: Colors.blue[50],
          child: Align(
            alignment: Alignment.topCenter,
            child: pages[currentIndex]
          ),
        ),
      ),

      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(),
        child: BottomNavigationBar(
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          elevation: 0.0,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(
                  'lib/assets/icons/navigation_bar/history_icon.png'
                ),
                color: Colors.white,
              ),
              label: 'History',
              activeIcon: ImageIcon(
                AssetImage(
                  'lib/assets/icons/navigation_bar/history_icon.png'
                ),
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(
                  'lib/assets/icons/navigation_bar/scan_icon.png'
                ),
                color: Colors.white,
              ),
              label: 'Scan',
              activeIcon: ImageIcon(
                AssetImage(
                  'lib/assets/icons/navigation_bar/scan_icon.png'
                ),
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(
                  'lib/assets/icons/navigation_bar/more_icon.png'
                ),
                color: Colors.white,
              ),
              label: 'More',
              activeIcon: ImageIcon(
                AssetImage(
                  'lib/assets/icons/navigation_bar/more_icon.png'
                ),
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
          selectedItemColor: Theme.of(context).colorScheme.primary,
          ),
        ),
      );
  }
}