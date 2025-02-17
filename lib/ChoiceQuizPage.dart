import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bot_toast/bot_toast.dart';
import 'Record.dart';
import 'package:hive/hive.dart';

import 'RecordPage.dart';


class ChoiceQuizPage extends StatefulWidget {
  @override
  _ChoiceQuizPageState createState() => _ChoiceQuizPageState();
}

class _ChoiceQuizPageState extends State<ChoiceQuizPage> {
  List<Map<String, dynamic>> questions = [];
  int currentQuestionIndex = 0;
  int score = 0;
  bool answered = false;
  String userAnswer = "";

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    final String response = await rootBundle.loadString('assets/选择题.txt');
    final lines = response.split('\n');
    Map<String, dynamic> now = {
      'options': [],
    };
    for (var block in lines) {
      if (block.contains('。')) {
        now['question'] = block;
      } else if (block.contains('.')) {
          now['options'].add(block);
      } else if (block.contains('答案：')) {
        now['answer'] = block.split('答案：').last.trim();
        questions.add({
          'question': now['question'],
          'options': now['options'],
          'answer': now['answer'],
        });
        print(now);
        now = {'options': []};
      }
    }

    setState(() {});
  }

  void checkAnswer(String selectedOption) {
    if (userAnswer.substring(0, 1) == questions[currentQuestionIndex]['answer']) {
      score += 10;
      BotToast.showText(text: "回答正确, 得分：$score");
    } else {
      BotToast.showText(text: "回答错误, 正确答案是：${questions[currentQuestionIndex]['answer']}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("选择题"),
      ),
      body: questions.isNotEmpty
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "${questions[currentQuestionIndex]['question']}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ...questions[currentQuestionIndex]['options'].map<Widget>((option) {
            return ListTile(
              title: Text(option),
              leading: Radio(
                value: option,
                groupValue: userAnswer,
                onChanged: (value) {
                  setState(() {
                    answered = true;
                    userAnswer = value;
                  });
                },
              ),
            );
          }).toList(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: answered
                  ? TextButton(
                onPressed: () {
                  if (currentQuestionIndex < questions.length - 1) {
                    checkAnswer(userAnswer);
                    setState(() {
                      currentQuestionIndex++;
                      userAnswer = "";
                      answered = false;
                    });
                  } else {

                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text("完成"),
                        content: Text("你已完成所有题目，总分为：$score"),

                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                              addRecord("选择题", score);
                              Navigator.of(context).pop();
                            },
                            child: Text("好的"),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Text('下一题'),
              )
                  : SizedBox.shrink(),
            ),
          ),
        ],
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}