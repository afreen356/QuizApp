

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/functions/db_functions.dart';
import 'package:quiz_app/model/sharedclass.dart';

import 'package:quiz_app/pages/home_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    getCorrectQuestions();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Container(
            height: 120,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(
                      20,
                    )),
                gradient: LinearGradient(colors: [
                  Color(0xffB81736),
                  Color(0xff281537),
                ])),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => HomePage()));
                    },
                    child: const Icon(
                      Icons.navigate_before,
                      size: 40,
                      color: Colors.white,
                    )),
                const SizedBox(
                  width: 50,
                ),
                const Center(
                  child: Text(
                    'Review answers',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          )),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('history')
            .where('mail', isEqualTo: SharedPref().sharedInstanceUSer)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isNotEmpty) {
              return SingleChildScrollView(
                child: Column(
                  children: List.generate(
                      snapshot.data!.docs[0]['recent_ans'].length, (index) {
                    return StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('question_db')
                            .doc(snapshot.data!.docs[0]['recent_ans'][index])
                            .snapshots(),
                        builder: ((context, snapshot) {
                          if (!snapshot.hasData) {
                            return const CupertinoActivityIndicator();
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                          blurRadius: 2,
                                          spreadRadius: 1,
                                          color: Colors.black54)
                                    ]),
                                child: ListTile(
                                  title: Text(
                                    snapshot.data!['question'],
                                    style: const TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: Text(
                                    'Correct Answer:${snapshot.data!['options'][snapshot.data!['correctanswer']]}',
                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            );
                          }
                        }));
                  }),
                ),
              );
            } else {
              return const Center(child: Text('No history'));
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
     
    );
  }
}
