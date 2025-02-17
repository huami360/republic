import 'package:flutter/material.dart';
import 'package:republic/FourthPage.dart';
import 'package:republic/SecondPage.dart';

import 'FirstPage.dart';
import 'ThirdPage.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  final widgets = [
    FirstPage(),
    SecondPage(),
    ThirdPage(),
    FourthPage(),
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Container(
          height: 60,
          padding: EdgeInsets.all(10),
          child: TextField(
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          )
        ),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          SizedBox(width: 10,)
        ],
      ),
      body: widgets[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            this.index = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: '学党史',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: '学党纪',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_paint),
            label: '趣党创',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cabin_sharp),
            label: '知识竞赛',
          ),
        ],
      ),
    );
  }
}

