import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/model/questions_model.dart';
import 'package:quiz_app/repository/questions_repository.dart';
import 'package:quiz_app/view/result_page.dart';
import 'package:quiz_app/view_model/result_page_view_model.dart';

class QuizPageViewModel with ChangeNotifier {
  final repo = QuestionsRepository();
  List<QuestionsModel> myQuestions = [];

  int _currentQuestionIndex = 0;
  int get currentQuestionIndex => _currentQuestionIndex;

  int? _selectedIndex;
  int? get selectedIndex => _selectedIndex;
  set selectedIndex(int? value) {
    _selectedIndex = value;
    notifyListeners();
  }

  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;
  set isAnswered(bool value) {
    _isAnswered = value;
    notifyListeners();
  }

  int _correctCount = 0;
  int get correctCount => _correctCount;

  bool? _isQuizCompleted = false;
  bool? get isQuizComplated => _isQuizCompleted;

  QuizPageViewModel() {
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    await repo.loadQuestions();
    myQuestions = repo.questions.map((q) {
      // Yeni bir liste oluştur ki orijinali bozulmasın
      final shuffledOptions = List<String>.from(q.options)..shuffle();

      // Doğru cevabın yeni listedeki index'ini bul
      final correctAnswer = q.options[q.correctIndex];
      final newCorrectIndex = shuffledOptions.indexOf(correctAnswer);

      return QuestionsModel(
        question: q.question,
        options: shuffledOptions,
        correctIndex: newCorrectIndex,
      );
    }).toList();

    notifyListeners();
  }

  //Cevap verilmemişse (!_isAnswered) (!isAnswered (Yani cevap verilmedi mi?)) Bir şık seçilmişse (_selectedIndex != null)
  //İkisi aynı anda doğruysa, if bloğu çalışır. && şunu der: "Her iki şart da doğruysa işlem yap!"

  void checkAnswer() {
    if (myQuestions.isEmpty) {
      return; // soru listesi boşsa fonksiyondan hemen çıkar, hata olmasın
    }
    if (!_isAnswered && _selectedIndex != null) {
      _isAnswered = true;
      if (_selectedIndex == myQuestions[_currentQuestionIndex].correctIndex) {
        _correctCount++;
      }
      notifyListeners();
    }
  }

  void goToNextQuestion(BuildContext context) {
    if (isAnswered) {
      if (_currentQuestionIndex < myQuestions.length - 1) {
        _currentQuestionIndex++;
        isAnswered = false;
        selectedIndex = null;
        notifyListeners();
      } else {
        _isQuizCompleted = true;
        notifyListeners();
        _openResultPage(context);
      }
    }
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _correctCount = 0;
    _isAnswered = false;
    _selectedIndex = null;
    notifyListeners();
  }

  void goToHomePage(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void _openResultPage(BuildContext context) {
    final result = _correctCount;
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) {
        return ChangeNotifierProvider(
          create: (_) => ResultPageViewModel(),
          child: ResultPage(result: result),
        );
      },
    );
    Navigator.push(context, route);
  }
}
