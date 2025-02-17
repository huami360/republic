import 'package:flutter/material.dart';
import 'package:republic/ChoiceQuizPage.dart';
import 'package:republic/QuizPage.dart';
import 'package:republic/RecordPage.dart';

class FourthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: CompetitionCard(),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.topCenter,
              child: RecordLink(),
            )
          ),
        ],
      ),
    );
  }
}

class CompetitionCard extends StatelessWidget {

  void _showQuizOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Center(child: Text('填空题', style: TextStyle(fontSize: 20),)),
                  onTap: () {
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.push(context, MaterialPageRoute(builder: (context) => QuizPage()));
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Center(child: Text('选择题', style: TextStyle(fontSize: 20),)),
                  onTap: () {
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChoiceQuizPage()));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      color: Colors.orangeAccent,
      child: InkWell(
        onTap: () {
          _showQuizOptions(context);
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "开始竞赛",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "点击进入 >>>",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecordLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => RecordPage()));
      },
      child: Text(
        "我的记录",
        style: TextStyle(
          fontSize: 20,
          color: Colors.orange,
        ),
      ),
    );
  }
}