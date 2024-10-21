import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/app_settings.dart'; // Import the AppSettings model
import 'pages/home_page.dart'; // Import your HomePage
import 'pages/login_page.dart'; // Import your LoginPage

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppSettings(), // Provide AppSettings
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appSettings = Provider.of<AppSettings>(context); // Access AppSettings

    return MaterialApp(
      theme: appSettings.isDarkMode
          ? ThemeData.dark() // Dark theme
          : ThemeData.light(), // Light theme
      home: LoginPage(), // Start with the login page
    );
  }
}
