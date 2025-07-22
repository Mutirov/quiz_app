import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/view_model/result_page_view_model.dart';

class ResultPage extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final result;
  const ResultPage({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Geri butonunu gizler
        title: Text('Result page', style: TextStyle(fontSize: 20)),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[400],
      ),
      body: _buildBody(),
    );
  }
  
  _buildBody() {
    return Consumer<ResultPageViewModel>(builder: (context, vm, child) {
      return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Correct answers: $result', style: TextStyle(fontSize: 24),),
          SizedBox(height: 30,),
          // ElevatedButton(
          //   onPressed: (){
          //     vm.playAgain(context);
          //   },
          //    child: Text('Play again'),
          //    ),
          //    SizedBox(height: 24,),
             ElevatedButton(
            onPressed: (){
             vm.goToHome(context);
            },
             child: Text('Go to start')),

        ],
      ));
    });
  }
}
