import 'dart:ffi';
import 'dart:io';

import '../domain/quiz.dart';

class QuizConsole {
  Quiz quiz;

  QuizConsole({required this.quiz});

  void startQuiz() {
    print('--- Welcome to the Quiz ---\n');

    while (true) {
      stdout.write('Your name: ');
      String? nameInput = stdin.readLineSync();

      if (nameInput != null && nameInput.isNotEmpty) {
        Player newPlayer = Player(nameInput);
        quiz.addPlayer(newPlayer);
        for (var question in quiz.questions) {
          print('Question: ${question.title} - ( ${question.points} points )');
          print('Choices: ${question.choices}');
          stdout.write('Your answer: ');
          String? userInput = stdin.readLineSync();

          // Check for null input
          if (userInput != null && userInput.isNotEmpty) {
            Answer answer = Answer(question: question, answerChoice: userInput);
            quiz.addAnswer(newPlayer, answer);
          } else {
            print('No answer entered. Skipping question.');
          }

          print('');
        }

        int score = quiz.getScoreInPercentage(newPlayer);
        int points = quiz.getScoreInPoints(newPlayer);

        print('${newPlayer.name},Your score in percentage: $score%');
        print('${newPlayer.name}, Your score in points: $points');
        if(quiz.players.length > 1) {
          for(var player in quiz.players) {
            print("Player: ${player.name}\tScore: ${player.scoreInPoints}");
          }
        }
      } else {
        print('--- Quiz Finished ---');
        break;
      }
    }
  }
}
