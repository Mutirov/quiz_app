import 'dart:convert';

class QuestionsModel {
  final String question;
  final List<String> options;
  final int correctIndex;

  QuestionsModel({
    required this.question,
    required this.options,
    required this.correctIndex,
  });

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'options': options,
      'correctIndex': correctIndex,
    };
  }

  factory QuestionsModel.fromMap(Map<String, dynamic> map) {
    return QuestionsModel(
      question: map['question'] as String,
      options: List<String>.from(map['options']),
      correctIndex: map['correctIndex'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionsModel.fromJson(String source) =>
      QuestionsModel.fromMap(json.decode(source));
}
