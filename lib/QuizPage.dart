import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:hive/hive.dart';
import 'Record.dart';
import 'RecordPage.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Map<String, String>> questions = [];
  int currentQuestionIndex = 0;
  String userAnswer = "";
  int score = 0;
  final TextEditingController _controller = TextEditingController();


  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    final String response = await rootBundle.loadString('assets/填空题.txt');
    final lines = response.split('\n');

    for (var line in lines) {
      if (line.contains('答案：')) {
        final question = line.split('答案：')[0];
        var answer = line.split('答案：')[1];
        answer = answer.trim();
        questions.add({
          "question": question,
          "answer": answer,
        });
        print(question);
        print(answer);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("填空题"),
      ),
      body: questions.isNotEmpty
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "${questions[currentQuestionIndex]['question']}",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '输入答案',
              ),
              onChanged: (value) {
                userAnswer = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (currentQuestionIndex < questions.length - 1) {
                      setState(() {
                        if (userAnswer == questions[currentQuestionIndex]['answer']) {
                          score += 10;
                          BotToast.showText(text: "回答正确，当前分数为：$score");
                          currentQuestionIndex++;
                        } else {
                          BotToast.showText(text: "回答错误，正确答案是：${questions[currentQuestionIndex]['answer']}");
                          currentQuestionIndex++;
                        }
                        _controller.clear();
                      });
                    } else {
                      if (userAnswer == questions[currentQuestionIndex]['answer']) {
                        score += 10;
                        BotToast.showText(text: "回答正确，总分为：$score");
                      } else {
                        BotToast.showText(text: "回答错误，正确答案是：${questions[currentQuestionIndex]['answer']}\n总分为：$score");
                      }
                      _controller.clear();
                      addRecord("填空题", score);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(currentQuestionIndex == questions.length - 1 ? '提交' : '下一题'),
                ),
              ],
            ),
          ),
        ],
      )
          : const Center(
        child: Text("正在加载问题..."),
      ),
    );
  }
}