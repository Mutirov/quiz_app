import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:quiz_app/model/questions_model.dart';

class QuestionsRepository {
  late final List<QuestionsModel> _questions;
  List<QuestionsModel> get questions => _questions;

  late final String data;
  late final dynamic jsonData;

  Future<void> loadQuestions() async {
    data = await rootBundle.loadString('assets/questions.json');
    jsonData = json.decode(data);

    _questions = (jsonData['questions'] as List)
        .map((e) => QuestionsModel.fromMap(e))
        .toList();
  }
}
