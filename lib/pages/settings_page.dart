import 'package:flutter/material.dart';
import 'about_page.dart';  // Ensure the correct import
import 'help_support_page.dart';  // Import the Help & Support page if you have it
import 'package:provider/provider.dart';
import '../models/app_settings.dart'; // Assuming this contains your dark mode and locale logic

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isAppSettingsExpanded = false; // To toggle the visibility of app settings options

  @override
  Widget build(BuildContext context) {
    final appSettings = Provider.of<AppSettings>(context); // Access the AppSettings provider

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: appSettings.isDarkMode ? null : Colors.white, // Set background color based on theme
          gradient: appSettings.isDarkMode
              ? LinearGradient(
                  colors: [const Color.fromARGB(255, 2, 0, 94), Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : null, // Use gradient only in dark mode
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              _buildSettingsCard(
                Icons.help_outline,
                'Help & Support',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HelpSupportPage()), // Navigate to Help & Support
                  );
                },
              ),
              _buildSettingsCard(
                Icons.app_settings_alt,
                'App Settings',
                onTap: () {
                  setState(() {
                    _isAppSettingsExpanded = !_isAppSettingsExpanded; // Toggle expansion
                  });
                },
              ),
              if (_isAppSettingsExpanded) _buildAppSettingsOptions(appSettings),
              _buildSettingsCard(
                Icons.info_outline,
                'About',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()), // Navigate to About page
                  );
                },
              ),
              _buildSettingsCard(Icons.map_outlined, 'Map display'),
            ],
          ),
        ),
      ),
    );
  }

  // App settings options (Theme and Language)
  Widget _buildAppSettingsOptions(AppSettings appSettings) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          // Dark Mode Switch
          SwitchListTile(
            title: Text(
              'Dark Mode',
              style: TextStyle(color: appSettings.isDarkMode ? Colors.white : Colors.black), // Adjust text color
            ),
            value: appSettings.isDarkMode,
            onChanged: (bool value) {
              appSettings.toggleDarkMode(value);
            },
          ),
          SizedBox(height: 10),
          // Language Selection Dropdown
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select Language',
                style: TextStyle(color: appSettings.isDarkMode ? Colors.white : Colors.black), // Adjust text color
              ),
              DropdownButton<String>(
                value: appSettings.appLocale.languageCode, // Current language
                items: [
                  DropdownMenuItem(value: 'en', child: Text('English')),
                  DropdownMenuItem(value: 'es', child: Text('Spanish')),
                  // Add more languages here
                ],
                onChanged: (String? newLanguage) {
                  // No functionality for changing language
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Build the card for each setting
  Widget _buildSettingsCard(IconData icon, String title, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 128, 128, 128),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(16),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: Icon(icon, color: const Color.fromARGB(255, 2, 0, 94)),
          trailing: Icon(Icons.arrow_forward_ios, color: const Color.fromARGB(255, 2, 0, 94)),
          onTap: onTap,
        ),
      ),
    );
  }
}
