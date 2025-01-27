

import 'package:flutter/material.dart';
import 'package:quiz_app/pages/Levels/quiz.dart';


class LevelPage extends StatefulWidget {
 const LevelPage({super.key});

  @override
  State<LevelPage> createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
  final levels = ['Easy', 'Medium', 'Hard'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration:const BoxDecoration(
        // color: Color.fromARGB(255, 10, 147, 118)
       
        gradient: LinearGradient(
          colors: [
            Color(0xffB81736),
            Color(0xff281537),
          ],
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                    itemCount: levels.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>QuizPage(levels: levels[index])));
                          },
                          child: Container(
                              height: 80,
                              
                             decoration: BoxDecoration(
                                        color: Colors.white,
                                         boxShadow:const [ BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 2,
                                          offset: Offset(0, 10)
                                         )],
                                  borderRadius: BorderRadius.circular(30,)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 30, top: 16),
                                child: Text(
                                  levels[index],
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                        ),
                      );
                    })
          )
        ],
      ),
    ));
  }
}
