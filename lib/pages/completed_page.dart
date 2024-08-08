import 'package:flutter/material.dart';

class CompletedPage extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const CompletedPage(
      {super.key, required this.score, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/q_logo.png'),
              fit: BoxFit.cover)
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          Center(
            child: Padding(padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Congratulations',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenSize.width*0.08,
                  color: Colors.white
                ),),
                const SizedBox(height: 20,),
                Text('You have completed the quiz',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenSize.width*0.06,
                  color: Colors.white70
                ),),
                const 
                SizedBox(height: 20,),
                Text('Your Score : ',
                style: TextStyle(
                  fontSize: screenSize.width*0.07,
                  color: Colors.white
                ),),
                Text('$score/$totalQuestions',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenSize.width*0.1,
                  color: Colors.greenAccent
                ),),
                const SizedBox(height: 20,),
                ElevatedButton.icon(onPressed: (){
                  Navigator.restorablePushNamedAndRemoveUntil(context, '/', (route)=>false);

                },
                icon: const Icon(Icons.refresh,color: Colors.white,),
                 label:const Text('Retry'),
                 style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 221, 206, 224),
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                  elevation: 5

                 ),)
              ],),),
          )
        ],),
    );
  }
}
