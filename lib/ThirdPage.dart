import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  List<String> titles = [
    '“党史系列全切贴纸”',
    '“党史系列明信片”',
    '“党风党纪”帆布包',
    '“廉”花扇',
    '“清廉”挂件',
    '“走进党史系列”集章折页',
    '”反四风“金属徽章'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,

        children: List.generate(7, (index) {
          return ProductTile(title: titles[index]);
        }),
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  String title;

  ProductTile({required this.title});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Image.asset('assets/sale/' + title + '.png', fit: BoxFit.cover),
          ),
          Row(children: [
            Container(
              width: 110,
              padding: EdgeInsets.all(8.0),
              child: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis, )),
            ),
            Expanded(child: Container()),
            Icon(Icons.add, color: Colors.orange),
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.shopping_cart, color: Colors.orange),
            ),
          ],)

        ],
      ),
    );
  }
}