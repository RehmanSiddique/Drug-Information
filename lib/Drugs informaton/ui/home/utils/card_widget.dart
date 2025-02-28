import 'package:flutter/material.dart';

class Card_Widget extends StatefulWidget {
  const Card_Widget({super.key, required this.title, required this.content});
  final String title;
  final String content;

  @override
  State<Card_Widget> createState() => _Card_WidgetState();
}

class _Card_WidgetState extends State<Card_Widget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 2.0, horizontal: 2.0), // Padding around the card
      child: Card(
        margin: EdgeInsets.all(8.0), // Margin around the card
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.black87, // Border color
            width: 1.0, // Border width
          ),
          borderRadius: BorderRadius.circular(8.0), // Border radius of the card
        ),
        child: ExpansionTile(
          leading: Icon(
            Icons.arrow_drop_down_circle_outlined,
            color: Colors.deepPurple[900], // Color of the icon
          ),
          title: Padding(
            padding:
                EdgeInsets.symmetric(vertical: 8.0), // Padding around the title
            child: Text(
              widget.title,
              style: TextStyle(
                color:
                    Colors.deepPurple[900], // Text color same as border color
                fontSize: 18.0,
                fontWeight: FontWeight.bold, // Make text bold
                letterSpacing: 1.2, // Add spacing between letters
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3), // Shadow color
                    offset: Offset(1, 0), // Shadow offset
                    blurRadius: 1, // Shadow blur radius
                  ),
                ],
              ),
            ),
          ),
          children: <Widget>[
            ListTile(
              title: Text(
                widget.content,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.black, // Text color
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
