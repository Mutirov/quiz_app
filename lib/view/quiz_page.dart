import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/view_model/quiz_page_view_model.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Geri butonunu gizler
        title: Text('Quiz Page', style: TextStyle(fontSize: 18)),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[400],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Consumer<QuizPageViewModel>(
      builder: (context, vm, child) {
        if (vm.myQuestions.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        final currentQuestion = vm.myQuestions[vm.currentQuestionIndex];
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Question ${vm.currentQuestionIndex + 1}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(currentQuestion.question, style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              ...List.generate(currentQuestion.options.length, (index) {
                final isSelected = vm.selectedIndex == index;
                final isCorrect = index == currentQuestion.correctIndex;
                final isWrong = isSelected && !isCorrect;
                final isAnswered = vm.isAnswered;

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 6),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith<Color>((
                        states,
                      ) {
                        if (!isAnswered) return Colors.grey[300]!;
                        if (isCorrect) return Colors.green;
                        if (isWrong) return Colors.red;
                        return Colors.grey;
                      }),
                      padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),

                    onPressed: vm.isAnswered
                        ? null
                        : () {
                            vm.selectedIndex = index;
                          },
                    child: Text(currentQuestion.options[index]),
                  ),
                );
              }),
              Spacer(),
              ElevatedButton(
                onPressed: vm.selectedIndex != null && !vm.isAnswered
                    ? () {
                        vm.checkAnswer();
                      }
                    : null,
                child: Text('Confirm Answer'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: vm.isAnswered
                    ? () {
                        vm.goToNextQuestion(context);
                      }
                    : null,
                child: Text('Next'),
              ),
            ],
          ),
        );
      },
    );
  }
}
