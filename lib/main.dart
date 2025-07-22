import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/view/home_page.dart';
import 'package:quiz_app/view_model/home_page_view_model.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     home: MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => HomePageViewModel()),
     // ChangeNotifierProvider(create: (_) => QuizPageViewModel()),
     ],
     child: HomePage(),
     ),
    );
  }
}