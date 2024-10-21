import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'jeepneys_page.dart'; // Import for JeepneysPage
import 'location_page.dart'; // Import for LocationPage
import 'settings_page.dart'; // Import for SettingsPage
import 'account_page.dart';  // Import for AccountPage

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.transparent, // Set background color to transparent
      ),
      darkTheme: ThemeData.dark(), // Add dark theme
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    JeepneysPage(),
    LocationPage(),
    SettingsPage(),
    AccountPage(),
  ];

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark; // Determine if dark mode is active

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color.fromARGB(255, 0, 1, 85), const Color.fromARGB(255, 0, 0, 0)!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: PageView(
          controller: _pageController,
          children: _pages,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      bottomNavigationBar: Container(
        color: isDarkMode ? Colors.black : Colors.white, // Set solid background color based on theme
        child: GNav(
          backgroundColor: Colors.transparent, // Set background to transparent
          color: isDarkMode ? Colors.white : Colors.black, // Text color based on theme
          activeColor: isDarkMode ? Colors.white : Colors.black, // Active icon color
          gap: 8,
          padding: EdgeInsets.all(16),
          tabBackgroundColor: isDarkMode ? const Color.fromARGB(255, 28, 0, 153)! : const Color.fromARGB(255, 28, 0, 153)!, // Tab background color
          selectedIndex: _selectedIndex,
          onTabChange: _onTabChange,
          tabs: const [
            GButton(
              icon: Icons.car_crash_rounded,
              text: 'Jeepneys',
            ),
            GButton(
              icon: Icons.pin_drop_rounded,
              text: 'Navigations',
            ),
            GButton(
              icon: Icons.settings,
              text: 'Settings',
            ),
            GButton(
              icon: Icons.account_circle_rounded,
              text: 'Accounts',
            ),
          ],
        ),
      ),
    );
  }
}
