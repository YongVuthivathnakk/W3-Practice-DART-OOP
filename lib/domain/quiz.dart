import 'dart:convert';
import 'dart:io';

import 'package:uuid/uuid.dart';

class Question {
  final String title;
  final List<String> choices;
  final String goodChoice;
  final int points;
  var id = Uuid();
  Question(
      {required this.title,
      required this.choices,
      required this.goodChoice,
      required this.points});

  // getter
  Uuid get getId => this.id;
}

class Answer {
  final Question question;
  final String answerChoice;

  Answer({required this.question, required this.answerChoice});

  bool isGood() {
    return this.answerChoice == question.goodChoice;
  }
}

class Player {
  final String name;
  int scoreInPoints = 0;
  int scoreInPercentage = 0;
  List<Answer> answers = [];

  Player(this.name);
}

class Quiz {
  Uuid id = Uuid();
  List<Question> questions;
  List<Player> players = [];

  Quiz({required this.questions});

  // getter
  Uuid get getId => this.id;

  void addAnswer(Player player, Answer answer) {
    player.answers.add(answer);
  }

  void addPlayer(Player player) {
    this.players.add(player);
  }

  int getScoreInPoints(Player player) {
    player.scoreInPoints = 0;
    for (Answer answer in player.answers) {
      if (answer.isGood()) {
        player.scoreInPoints += answer.question.points;
      }
    }
    return player.scoreInPoints;
  }

  int getScoreInPercentage(Player player) {
    player.scoreInPercentage = 0;
    for (Answer answer in player.answers) {
      if (answer.isGood()) {
        player.scoreInPercentage++;
      }
    }
    return ((player.scoreInPercentage / questions.length) * 100).toInt();
  }
}

class QuizRepository {
  final String filePath;
  QuizRepository(this.filePath);
  Quiz readQuiz() {
    final file = File(filePath);
    final content = file.readAsStringSync();
    final data = jsonDecode(content);
// Map JSON to domain objects
    var questionsJson = data['questions'] as List;
    var questions = questionsJson.map((q) {
      return Question(
        title: q['title'],
        choices: List<String>.from(q['choices']),
        goodChoice: q['goodChoice'],
        points: q['points'],
      );
    }).toList();
    return Quiz(questions: questions);
  }
}
