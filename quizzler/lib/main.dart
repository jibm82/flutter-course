import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

QuizBrain quizBrain = new QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  int questionIndex = 0;

  void moveToNextQuestion() {
    setState(() {
      if (questionIndex < quizBrain.questions.length - 1) {
        questionIndex++;
      } else {
        Alert(context: context, title: "Quizzler", desc: "You reached the end of the game").show();
        questionIndex = 0;
        scoreKeeper = [];
      }
    });
  }

  void checkAnswer(bool answer) {
    bool correctAnswer = quizBrain.questions[questionIndex].answer;
    Color color;
    IconData icon;

    if (answer == correctAnswer) {
      color = Colors.green;
      icon = Icons.check;
    } else {
      color = Colors.red;
      icon = Icons.clear;
    }

    setState(() {
      scoreKeeper.add(Icon(
        icon,
        color: color,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            child: Center(
              child: Text(
                quizBrain.questions[questionIndex].text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            padding: EdgeInsets.all(10),
          ),
          flex: 5,
        ),
        Expanded(
          child: Padding(
            child: TextButton(
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
                moveToNextQuestion();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
            padding: EdgeInsets.all(15.0),
          ),
        ),
        Expanded(
          child: Padding(
            child: TextButton(
              child: Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
                moveToNextQuestion();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
            padding: EdgeInsets.all(15.0),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
