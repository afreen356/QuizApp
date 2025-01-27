import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiz_app/model/question_model.dart';
import 'package:quiz_app/model/sharedclass.dart';
import 'package:quiz_app/model/user_model.dart';

Future addQuiz(QuestionModel data) async {
  await FirebaseFirestore.instance.collection('question_db').add({
    'question': data.question,
    'options': data.options,
    'correctanswer': data.correctanswerIndex,
    'levels': data.levels,
    'category': data.category,
  });
}

Future addUser() async {
  await FirebaseFirestore.instance.collection('user').add({});
}



Future updateQuiz(QuestionModel data, String id) async {
  await FirebaseFirestore.instance.collection('question_db').doc(id).update({
    'question': data.question,
    'options': data.options,
    'correctanswer': data.correctanswerIndex,
    'levels': data.levels,
    'category': data.category
  });
}

Future<void> deleteQuiz(String id) async {
  await FirebaseFirestore.instance.collection('category_db').doc(id).delete();
}

Future<void> deleteQuestion(String id)async{
 await FirebaseFirestore.instance.collection('question_db').doc(id).delete();
}

Future<bool> checkQuestion(String id) async {
  final data = await FirebaseFirestore.instance
      .collection('question_db')
      .where('category', isEqualTo: id)
      .get();
  if (data.docs.isEmpty) {
    return true;
  } else {
    return false;
  }
}

togetfunction() async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  await Future.forEach(userDB.values, (element) {
    if (element.gmail == SharedPref().sharedInstanceUSer) {
      log(element.username);
      log("  gmail ->> ${element.gmail}");
      log(element.score.toString());
    }

   
  });
}
