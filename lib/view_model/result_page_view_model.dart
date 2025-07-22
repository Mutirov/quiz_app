import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/view/home_page.dart';
//import 'package:quiz_app/view/quiz_page.dart';
import 'package:quiz_app/view_model/home_page_view_model.dart';
//import 'package:quiz_app/view_model/quiz_page_view_model.dart';

class ResultPageViewModel with ChangeNotifier {
  // void playAgain(BuildContext context) {
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //       builder: (_) => ChangeNotifierProvider(
  //         create: (_) => QuizPageViewModel(),
  //         child: QuizPage(),
  //       ),
  //     ),
  //   );
  // }

  void goToHome(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (_) => HomePageViewModel(),
          child: HomePage(),
        ),
      ),
      (route) => false,
    );
  }
}
