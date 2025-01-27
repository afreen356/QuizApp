import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/functions/database_functions.dart';
import 'package:quiz_app/screens/admin/edit.question.dart';
import 'package:quiz_app/widgets/snackbar.dart';


class ShowQuestions extends StatefulWidget {
  final String category;
  const ShowQuestions({super.key, required this.category});

  @override
  State<ShowQuestions> createState() => _ShowQuestionsState();
}

class _ShowQuestionsState extends State<ShowQuestions> {
  // ignore: prefer_final_fields
  PageController _pagecontroller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('question_db')
                .where('category',isEqualTo: widget.category)
                .snapshots(),
            builder: ((context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CupertinoActivityIndicator());
              } else {
                return PageView.builder(
                    controller: _pagecontroller,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final quizsnap = snapshot.data!.docs[index];
                      final List<dynamic> options = quizsnap['options'];
                      return Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40),
                                  topLeft: Radius.circular(40)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 3,
                                  blurRadius: 6,
                                )
                              ],
                              color: Colors.white),
                          child: Column(
                            children: [
                              StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('category_db')
                                      .doc(quizsnap['category'])
                                      .snapshots(),
                                  builder: (context,AsyncSnapshot snapshot) {
                                    if (!snapshot.hasData) {
                                      return const CupertinoActivityIndicator();
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                 
                                                },
                                                icon: const Icon(
                                                    Icons.arrow_back)),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 100,
                                              ),
                                              child: Text(
                                                snapshot.data['name'],
                                                style: const TextStyle(
                                                    fontSize: 23,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  }),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    height: 100,
                                    // width: double.infinity,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(
                                          30,
                                        )),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Center(
                                        child: Text(
                                          quizsnap['question'],
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    )),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: options.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: ListTile(
                                            title: Center(
                                                child: Text(quizsnap['options']
                                                    [index])),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 100,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'correct answer is : ${quizsnap['correctanswer'].toString()}',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'level :${quizsnap['levels']}',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          onTap: () async{
                                           await deleteQuestion(quizsnap.id);
                                            // ignore: use_build_context_synchronously
                                            Navigator.of(context).pop();
                                            // ignore: use_build_context_synchronously
                                            customSnackBar(context,
                                             'Successfully Deleted',
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
                            ],
                          ),
                        ),
                      );
                    });
              }
            })));
  }
}
