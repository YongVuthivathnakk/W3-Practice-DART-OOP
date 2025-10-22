import 'package:my_first_project/domain/quiz.dart';
import 'package:my_first_project/ui/quiz_console.dart';
import 'package:test/test.dart';

main() {
  test('My first test', () {
     
  List<Question> questions = [
    Question(
        title: "Capital of France?",
        choices: ["Paris", "London", "Rome"],
        goodChoice: "Paris",
        points: 10,
        ),
    Question(
        title: "2 + 2 = ?", 
        choices: ["2", "4", "5"], 
        goodChoice: "4",
        points: 50,
        ),
  ];

  Quiz quiz = Quiz(questions: questions);
  QuizConsole console = QuizConsole(quiz: quiz);

  console.startQuiz();

    // Check something
    expect( 60, equals(quiz.players[1].scoreInPoints));
  });
}
