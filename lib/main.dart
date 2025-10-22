import 'domain/quiz.dart';
import 'ui/quiz_console.dart';

void main() {
  var repo = QuizRepository('lib/data/quiz.json');
  var quiz = repo.readQuiz();

  // Create console-based UI and start quiz
  QuizConsole console = QuizConsole(quiz: quiz);
  console.startQuiz();
}
