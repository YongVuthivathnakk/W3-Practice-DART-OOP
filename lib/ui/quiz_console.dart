import 'dart:io';
import '../domain/quiz.dart';

class QuizConsole {
  final Quiz quiz;

  QuizConsole({required this.quiz});

  void startQuiz() {
    print('--- Welcome to the Quiz ---\n');
    while (true) {
      stdout.write('Your name: ');
      String? nameInput = stdin.readLineSync();

      if (nameInput == null || nameInput.isEmpty) {
        print('\n--- Quiz Finished ---');
        printAllScores();
        break;
      }

      // Remove old record if exists
      int existingIndex = quiz.players.indexWhere((p) => p.name == nameInput);
      if (existingIndex != -1) {
        quiz.players.removeAt(existingIndex);
      }

      // Create new player
      Player player = Player(nameInput);
      quiz.addPlayer(player);

      // Ask each question
      for (var question in quiz.questions) {
        print('Question: ${question.title}  (${question.points} points)');
        print('Choices: ${question.choices.join(", ")}');
        stdout.write('Your answer: ');

        String? userAnswer = stdin.readLineSync();
        if (userAnswer == null || userAnswer.isEmpty) {
          print('No answer entered. Skipping question.\n');
          continue;
        }

        Answer answer =
            Answer(question: question, answerChoice: userAnswer.trim());
        quiz.addAnswer(player, answer);
      }

      // Show player score
      int percent = quiz.getScoreInPercentage(player);
      int points = quiz.getScoreInPoints(player);

      print('--- ${player.name}, your results ---');
      print('Score: $points points');
      print('Percentage: $percent%\n');
    }
  }

  void printAllScores() {
    if (quiz.players.isEmpty) {
      print('No players participated.');
      return;
    }

    print('\n=== Final Results ===');
    for (var p in quiz.players) {
      print(
          'Player: ${p.name} | Points: ${quiz.getScoreInPoints(p)} | Percentage: ${quiz.getScoreInPercentage(p)}%');
    }
  }
}
