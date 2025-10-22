import 'dart:ffi';

class Question{
  final String title;
  final List<String> choices;
  final String goodChoice;
  final int points;
  Question({required this.title, required this.choices, required this.goodChoice, required this.points});
}

class Answer{
  final Question question;
  final String answerChoice;
  

  Answer({required this.question, required this.answerChoice});

  bool isGood(){
    return this.answerChoice == question.goodChoice;
  }
}

class Player{
  final String name;
  int scoreInPoints = 0;
  int scoreInPercentage = 0;
  List <Answer> answers =[];

  Player(this.name);

}

class Quiz{
  List<Question> questions;
  List<Player> players = [];

  Quiz({required this.questions});

  void addAnswer(Player player, Answer answer) {
     player.answers.add(answer);
  }

  void addPlayer(Player player) {
    this.players.add(player);
  }

  int getScoreInPoints(Player player) {
    player.scoreInPoints = 0;
    for(Answer answer in player.answers) {
      if(answer.isGood()) {
        player.scoreInPoints += answer.question.points;
      }
    }
    return player.scoreInPoints;
  }

  int getScoreInPercentage(Player player){
    player.scoreInPercentage = 0;
    for(Answer answer in player.answers){
      if (answer.isGood()) {
        player.scoreInPercentage++;
      }
    }
    return ((player.scoreInPercentage/ questions.length)*100).toInt();
  }

  
}