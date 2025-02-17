import 'package:flutter/material.dart';
import 'package:republic/PassagePage.dart';

class SecondPage extends StatelessWidget {
  final List<Map<String, String>> items = [
    {'imagePath': 'assets/discipline/1.jpg', 'text': 'assets/passage/1.txt'},
    {'imagePath': 'assets/discipline/2.jpg', 'text': 'assets/passage/2.txt'},
    {'imagePath': 'assets/discipline/3.jpg', 'text': 'assets/passage/3.txt'},
    {'imagePath': 'assets/discipline/4.png', 'text': 'assets/passage/4.txt'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PassagePage(filePath: items[index]['text']!)),
            );
          }, child: ItemCard(
            imagePath: items[index]['imagePath']!,
            text: items[index]['text']!,
          ));
        },
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final String imagePath;
  final String text;

  const ItemCard({
    Key? key,
    required this.imagePath,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Image.asset(imagePath, fit: BoxFit.cover),
        ],
      ),
    );
  }
}