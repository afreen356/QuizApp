import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/functions/db_functions.dart';
import 'package:quiz_app/model/sharedclass.dart';
import 'package:quiz_app/pages/result_page.dart';

class Questions extends StatefulWidget {
  final String category;

  const Questions({super.key, required this.category});

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  late int numberOfQuestions;
  final _pageController = PageController();
  List<Color> colorsToShow = [];
  Color istrue = Colors.green;
  Color iswrong = Colors.red;
  Color restore = const Color.fromARGB(255, 255, 255, 255);
  int score = 0;
  int currentpageIndex = 0;
  int? selectedOptionIndex;
  int timer = 30;
  String showtimer = "30";
  bool canceltimer = false;

  @override
  void initState() {
    super.initState();
    starttimer();
    for (int i = 0; i < 4; i++) {
      colorsToShow.add(Colors.white);
    }
  }
  //  @override
  // void dispose() {
  //   _pageController.dispose();
  //   canceltimer=false;

  //   super.dispose();
  // }

  void starttimer() async {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      setState(() {

        
        if (timer < 1 && currentpageIndex != numberOfQuestions) {
          t.cancel();

          showtimer = "30";
          starttimer();

          if (currentpageIndex != numberOfQuestions - 1) {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 600),
              curve: Curves.ease,
            );
            timer = 30;
          } else {
           
            t.cancel();
            canceltimer = false;
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx) => Resultpage(score: score)));

            return;
          }
        } else if (canceltimer == true) {
          t.cancel();
        } else if (timer > 0) {
          timer = timer - 1;
        }
        showtimer = timer.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('question_db')
              .where('category', isEqualTo: widget.category)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CupertinoActivityIndicator());
            } else {
              numberOfQuestions = snapshot.data!.docs.length;
              return PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  itemCount: numberOfQuestions,
                  onPageChanged: (index) {

                    setState(() {
                      currentpageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final quizsnap = snapshot.data!.docs[index];
                    final List<dynamic> options = quizsnap['options'];
                    final int correctAnswer = quizsnap['correctanswer'];
                    // final questions =quizsnap.id;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 200,
                                width: 410,
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xffB81736),
                                        Color(0xff281537),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20)),
                                child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('category_db')
                                        .doc(quizsnap['category'])
                                        .snapshots(),
                                    builder: (context, AsyncSnapshot snapshot) {
                                      if (!snapshot.hasData) {
                                        return const CupertinoActivityIndicator();
                                      } else {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20, left: 120),
                                          child: Text(
                                            snapshot.data['name'],
                                            style: const TextStyle(
                                                fontSize: 30,
                                                color: Color.fromARGB(
                                                    255, 216, 164, 10),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        );
                                      }
                                    }),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 160),
                                child: Container(
                                  height: 170,
                                  width: 350,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: const [
                                        BoxShadow(
                                            blurRadius: 3,
                                            spreadRadius: 4,
                                            color: Colors.black12,
                                            offset: Offset(0, 1))
                                      ]),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white38, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20),
                                                child: Text(
                                                  ' ${index + 1}/$numberOfQuestions',
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 20,
                                                ),
                                                child: Text(
                                                  quizsnap['question'],
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                ),
                              ),
                              Positioned(
                                top: 80,
                                left: 130,
                                child: CircleAvatar(
                                  radius: 45,
                                  backgroundColor: Colors.white,
                                  child: Text(
                                    showtimer,
                                    style: const TextStyle(
                                        fontSize: 30, color: Colors.black),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 350,
                                ),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: options.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 10),
                                        child: GestureDetector(
                                          onTap: () async {
                                            setState(() {
                                              selectedOptionIndex = index;
                                              if (selectedOptionIndex ==
                                                  correctAnswer) {
                                                colorsToShow[correctAnswer] =
                                                    istrue;
                                                score += 5;
                                                // addScore();
                                                log('if entedere +5');
                                                updatescore();
                                                updatescorefb();
                                                // saveCorrectAnswer(quizsnap.id);
                                                firebasehistory(quizsnap.id);
                                              } else {
                                                log('if entedered nothing');

                                                colorsToShow[
                                                        selectedOptionIndex!] =
                                                    iswrong;
                                                colorsToShow[correctAnswer] =
                                                    istrue;
                                              }
                                              // print(score);
                                              canceltimer = true;
                                            });
                                            await Future.delayed(
                                                const Duration(seconds: 2));
                                            setState(() {
                                              canceltimer = true;
                                              Timer(const Duration(seconds: 0),
                                                  () async {
                                                if (currentpageIndex ==
                                                    numberOfQuestions - 1) {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (ctx) =>
                                                              Resultpage(
                                                                score: score,
                                                              )));
                                                }
                                                await _pageController.nextPage(
                                                  duration: const Duration(
                                                      milliseconds: 600), //
                                                  curve: Curves.linear,
                                                );
                                                canceltimer = false;
                                                timer = 30;
                                                starttimer();
                                              });

                                              colorsToShow[
                                                      selectedOptionIndex!] =
                                                  restore;
                                              colorsToShow[correctAnswer] =
                                                  restore;
                                            });
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 60,
                                            decoration: BoxDecoration(
                                                color: colorsToShow[index],
                                                boxShadow: const [
                                                  BoxShadow(
                                                      color: Colors.grey,
                                                      blurRadius: 2,
                                                      offset: Offset(0, 8))
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: ListTile(
                                              title: Center(
                                                  child: Text(
                                                quizsnap['options'][index],
                                                style: const TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              )),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            }
          }),
    );
  }
}

// ------------------------------------------
// to update scores of user in firebase firestore
// ------------------------------------------
updatescorefb() async {
// for refeence of current data to update
  final QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore
      .instance
      .collection('users')
      .where('mail', isEqualTo: SharedPref().sharedInstanceUSer)
      .get();

  FirebaseFirestore.instance
      .collection('users')
      .doc(data.docs.first.id)
      .update({
    'score': data.docs.first['score'] + 5,
  });
}
