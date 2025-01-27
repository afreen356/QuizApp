import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/screens/admin/add_question.dart';
import 'package:quiz_app/screens/admin/question_tabdetails.dart';


class QuestionList extends StatelessWidget {
  const QuestionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => const AddQuestionPage()));
        },
        backgroundColor: const Color.fromARGB(255, 39, 38, 38),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
      body: StreamBuilder(stream:FirebaseFirestore.instance.collection('question_db').snapshots() ,
       builder: (context,snapshot){
        if(!snapshot.hasData){
          return const CupertinoActivityIndicator();
        }else{
          return ListView.builder(itemCount: snapshot.data!.docs.length,
          itemBuilder: (context,index){
            final quizsnap = snapshot.data!.docs[index];
            return GestureDetector(
              onTap: () {
                 Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>QuestionDetails(question: quizsnap['question'],)));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: const Color.fromARGB(255, 172, 169, 169),
                  elevation: 5,
                  child:ListTile(
                    title: Text(quizsnap['question'],style: const TextStyle(fontWeight: FontWeight.bold),),
                  )
                ),
              ),
            );
          });
        }
      }),
    );
  }
}