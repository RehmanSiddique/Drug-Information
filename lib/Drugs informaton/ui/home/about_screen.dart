import 'package:flutter/material.dart';

class AboutAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[900],
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text('About App',style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About the App',
              style: TextStyle(
                fontSize: 24,
                color: Colors.deepPurple[900],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Our Drug Information App provides comprehensive information about various drugs, including dosages, indications, contraindications, side effects, warnings, and more.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Divider( // Thick horizontal line
              height: 2, // Specify the thickness here
              color: Colors.deepPurple[900], // Set the color of the line
            ),
            SizedBox(height: 16),
            Text(
              'Key Features',
              style: TextStyle(
                fontSize: 20,
                color: Colors.deepPurple[900],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '- Detailed drug information for various medications',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              '- Easy-to-use interface for quick access to drug details',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              '- Search functionality to find specific drugs',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              '- Favorite feature to save frequently accessed drugs',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Our mission is to provide accurate and reliable drug information to help users make informed decisions about their medications.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
