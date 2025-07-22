import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/view/quiz_page.dart';
import 'package:quiz_app/view_model/quiz_page_view_model.dart';

class HomePageViewModel with ChangeNotifier {
  void openQuizPage(BuildContext context) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) {
        return ChangeNotifierProvider(
          create: (_) => QuizPageViewModel(),
          child: QuizPage(),
        );
      },
    );
    Navigator.push(context, route);
  }
}
