import 'package:flutter/material.dart';
import 'login_page.dart'; // Import LoginPage to navigate after logout

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  void _logout() {
    // Show confirmation dialog before logging out
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false, // Remove all previous routes
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? null : Colors.white, // White background for light mode
          gradient: isDarkMode
              ? LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 32, 0, 119), 
                    const Color.fromARGB(255, 0, 0, 0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : null, // No gradient in light mode
        ),
        child: Column(
          children: [
            // Top Section with Profile Picture and Name
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 18, 0, 116), // Use secondary color from theme
                    const Color.fromARGB(255, 12, 1, 117),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(70),
                  bottomRight: Radius.circular(70),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  // Profile picture
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 15),
                  // Name
                  Text(
                    'Test Example',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black, // Change text color based on theme
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Profile Info Fields
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildInfoRow(Icons.person, 'Test Example'),
                  _buildInfoRow(Icons.cake, 'Birthday'),
                  _buildInfoRow(Icons.phone, '123 456 7890'),
                  _buildInfoRow(Icons.email, 'test@example.com'),
                  _buildInfoRow(Icons.lock, 'Password'),
                ],
              ),
            ),
            // Edit Profile Button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {}, // Implement edit profile logic here
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: const Color.fromARGB(255, 12, 0, 119), // Use secondary color from theme
                ),
                child: Text(
                  'Edit profile',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Logout Button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: _logout,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: const Color.fromARGB(255, 12, 0, 119), // Use secondary color from theme
                ),
                child: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String info) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          color: isDarkMode ? Theme.of(context).cardColor : Colors.grey[200], // Light background in light mode
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: isDarkMode ? const Color.fromARGB(135, 63, 62, 62) : const Color.fromARGB(136, 150, 149, 149), // Change shadow color based on theme
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color.fromARGB(255, 12, 0, 119)), // Use secondary color from theme
            SizedBox(width: 15),
            Expanded(
              child: Text(
                info,
                style: TextStyle(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white : Colors.black87, // Change text color based on theme
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
