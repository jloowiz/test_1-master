import 'package:flutter/material.dart';

class HelpSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Support'),
        backgroundColor: const Color.fromARGB(255, 2, 0, 94),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color.fromARGB(255, 2, 0, 94), Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          children: [
            // Logo and greeting
            Center(
              child: Column(
                children: [
                  // Replace logo with large text
                  Text(
                    'JeepWay',
                    style: TextStyle(
                      fontSize: 48, // Adjust the size as needed
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Hello, how can we help you?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),

            // Send Email Button
            ElevatedButton.icon(
              onPressed: () {
                // Add email sending logic here
                print('Send us an Email clicked');
              },
              icon: Icon(Icons.email),
              label: Text('Send us an Email'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 2, 0, 94),
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),

            SizedBox(height: 20),

            // FAQs Section
            Text(
              'FAQs',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            _buildFaqTile('What are the jeepney routes available?', 'You can view all jeepney routes within Angeles City in the app.'),
            _buildFaqTile('How do I find the fare for a specific route?', 'Select a route and the fare will be displayed along with it.'),
            _buildFaqTile('How do I report inaccurate route information?', 'Send us an email or use the feedback feature in the app.'),
            _buildFaqTile('Is the jeepney information updated?', 'Yes, we strive to keep the data up-to-date with regular updates.'),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqTile(String question, String answer) {
    return ExpansionTile(
      title: Text(
        question,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            answer,
            style: TextStyle(color: Colors.white70),
          ),
        ),
      ],
    );
  }
}
