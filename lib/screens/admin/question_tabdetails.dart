import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/functions/database_functions.dart';
import 'package:quiz_app/screens/admin/edit.question.dart';
import 'package:quiz_app/widgets/snackbar.dart';
import 'package:quiz_app/widgets/text.dart';

class QuestionDetails extends StatefulWidget {
  final String question;
  const QuestionDetails({super.key, required this.question});

  @override
  State<QuestionDetails> createState() => _QuestionDetails();
}

class _QuestionDetails extends State<QuestionDetails> {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('question_db')
              .where('question', isEqualTo: widget.question)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return PageView.builder(
                  controller: _pageController,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    final quizsnap = snapshot.data.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                topLeft: Radius.circular(30)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 3,
                                blurRadius: 6,
                              )
                            ],
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 50),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('category_db')
                                        .doc(quizsnap['category'])
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return const CupertinoActivityIndicator();
                                      } else {
                                        return Row(
                                          children: [
                                            
                                              IconButton(onPressed: (){
                                                Navigator.of(context).pop();
                                                // Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>const QuestionList()));
                                              }, icon: const Icon(Icons.arrow_back_ios)),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 80),
                                              child: styledText(
                                                snapshot.data!['name'],
                                              )
                                            ),
                                          ],
                                        );
                                      }
                                    }),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                    height: 100,
                                    // width: double.infinity,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(
                                          30,
                                        )),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        quizsnap['question'],
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                    width: double.infinity,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        quizsnap['options'][0],
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    width: double.infinity,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        quizsnap['options'][1],
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    width: double.infinity,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        quizsnap['options'][2],
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    width: double.infinity,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        quizsnap['options'][3],
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'correct answer is : ${quizsnap['correctanswer'].toString()}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'level :${quizsnap['levels']}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Align(
                                  alignment: Alignment.bottomCenter,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      Questionedit(
                                                        id: quizsnap.id,
                                                      )));
                                        },
                                        child: const Icon(
                                          Icons.edit,
                                          size: 30,
                                        )),
                                    GestureDetector(
                                      onTap: () async {
                                       await deleteQuestion(quizsnap.id);
                                        // ignore: use_build_context_synchronously
                                        Navigator.of(context).pop();
                                        // ignore: use_build_context_synchronously
                                        customSnackBar(context,
                                         'Successfully deleted', 
                                         Colors.red);
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
            return Container();
          }),
    );
  }
}
