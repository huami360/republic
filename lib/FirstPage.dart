import 'package:flutter/material.dart';
class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ImageCard(imagePath: 'assets/place/中共一大上海会址.png', title: '第一站: 中共一大上海会址'),
          ImageCard(imagePath: 'assets/place/浙江嘉兴南湖红船.png', title: '第二站: 浙江嘉兴南湖红船'),
          ImageCard(imagePath: 'assets/place/古田会议会址.png', title: '第三站: 古田会议会址'),
          ImageCard(imagePath: 'assets/place/瑞金革命遗址.png', title: '第四站: 瑞金革命遗址'),
        ],
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  final String imagePath;
  final String title;

  const ImageCard({Key? key, required this.imagePath, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(imagePath),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(title),
          ),
        ],
      ),
    );
  }
}