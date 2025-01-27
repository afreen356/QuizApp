import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiz_app/model/sharedclass.dart';
import 'package:quiz_app/model/user_model.dart';

UserModel? userData;
ValueNotifier<Set<String>> questionListNotifier =
    ValueNotifier<Set<String>>({});

Future<void> addUser(UserModel value) async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  int userId = await userDB.add(value);
  log(value.gmail);
  value.id = userId;
  await userDB.put(userId, value);
}


Future<void> getUser() async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  await Future.forEach(userDB.values, (element) {
    if (element.gmail == SharedPref().sharedInstanceUSer) {
      log(element.username);
      log("  gmail ->> ${element.gmail}");
      log(element.score.toString());
      userData = element;
    }
  });
}

Future<void> saveCorrectAnswer(String id) async {
 
  final userDB = await Hive.openBox<UserModel>('user_db');
  log('${userDB.values}');
  await Future.forEach(userDB.values, (element) {
    log('${element.gmail} --- gmail');
    log('${SharedPref().sharedInstanceUSer} --- sgmail');
    if (element.gmail == SharedPref().sharedInstanceUSer) {
     
      userData = element;
      UserModel? temp = userData;
      log('${temp!.correctAnswerIndex.runtimeType}');
      temp.correctAnswerIndex.add(id);
     
      log('${temp.correctAnswerIndex}');
      temp.score += 5;
      userDB.put(temp.id, temp);
    }
  });
}

Future<void> getCorrectQuestions() async {
  log('get correct fducntoion called');
  log(FirebaseAuth.instance.currentUser!.uid);

  final userDB = await Hive.openBox<UserModel>('user_db');
  log('user db data - - -- - - -');

  await Future.forEach(userDB.values, (element) {
    log('${element.gmail} ++++++++++++++++++');
    // if (element.firebaseId == FirebaseAuth.instance.currentUser!.uid)
    if (element.gmail == SharedPref().sharedInstanceUSer) {
      log('elemnt id == firebse id');
      log(element.correctAnswerIndex.toString());

      questionListNotifier.value.addAll(Set.from(element.correctAnswerIndex));
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      questionListNotifier.notifyListeners();
    }
  });
}

Future editUser(UserModel value) async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  await Future.forEach(userDB.values, (element) async {
    if (element.gmail == SharedPref().sharedInstanceUSer) {
      userData = element;
    }

    UserModel temp = UserModel(
        id: userData?.id,
        username: value.username,
        gmail: value.gmail,
        age: '',
        question: '',
        correctAnswerIndex: {},
        score: 0,
        firebaseId: '');
    await userDB.put(userData?.id, temp);
    await getUser();
  });
}

updatescore() async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  await Future.forEach(userDB.values, (element) async {
    if (element.gmail == SharedPref().sharedInstanceUSer) {
      userData = element;
      log('heloooo');
      log("${element.id.toString()}   id ivde an ulleth");
      UserModel temp = UserModel(
          id: userData?.id,
          username: userData!.username,
          gmail: userData!.gmail,
          age: '',
          question: '',
          correctAnswerIndex: {},
          score: userData!.score += 5,
          firebaseId: '');
      log("${temp.gmail}  >> ${temp.score}  >> ${temp.username} ");
      await userDB.put(userData?.id, temp);
      await getUser();
    }
  });
}

firebasehistory(String id) async {
  final QuerySnapshot<Map<String, dynamic>> fdata = await FirebaseFirestore
      .instance
      .collection('history')
      .where('mail', isEqualTo: SharedPref().sharedInstanceUSer)
      .get();

  if (fdata.docs.isEmpty) {
    await FirebaseFirestore.instance.collection('history').add({
      'mail': SharedPref().sharedInstanceUSer,
      'recent_ans': [id]
    });
  } else {
    log('entedere else >>>>>>>>>>>>');
    await fdata.docs.first.reference.update({
      'recent_ans': FieldValue.arrayUnion([id]),
    });
  }
}


