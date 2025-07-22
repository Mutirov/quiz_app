import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/view_model/home_page_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Geri butonunu gizler
        title: Text('Quiz App'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[400],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2193b0),
              Color(0xFF6dd5ed),
            ], //Color(0xFFcc2b5e), Color(0xFF753a88)
          ),
        ),
        child: _buildBody(context),
      ),
    );
  }

  _buildBody(BuildContext context) {
    HomePageViewModel vm = Provider.of<HomePageViewModel>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 375,
            width: 400,
            child: Image.asset('assets/images/quiz.png'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              vm.openQuizPage(context);
            },
            icon: Icon(Icons.play_arrow),
            label: Text('Start Quiz', style: TextStyle(fontSize: 28)),
          ),
        ],
      ),
    );
  }
}
