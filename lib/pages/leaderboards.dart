import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/functions/db_functions.dart';
import 'package:quiz_app/pages/home_page.dart';

import 'package:quiz_app/screens/constan.dart';

class Leaderboardpage extends StatefulWidget {
  const Leaderboardpage({super.key});

  @override
  State<Leaderboardpage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Leaderboardpage> {
  @override
  void initState() {
    updatescore();
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
              child: Center(
                  child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => HomePage()));
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 10,),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 100,top: 10,
                      ),
                      child: Text(
                        'Leaderboard',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              )),
            )),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .orderBy('score', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CupertinoActivityIndicator());
            }
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(10),
                  color: Colors.white,
                  child: ListTile(
                    title: Center(
                      child: Text(
                        snapshot.data?.docs[index][FbScoreConst.username],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      
                    ),
                    subtitle: Center(
                      child: Text(
                        'score:${snapshot.data?.docs[index][FbScoreConst.score].toString() as String}',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),trailing: Text('Rank${index+1}',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                );
              },
            );
          },
        ));
  }
}



// tofindmaximum() async {
//   final QuerySnapshot<Map<String, dynamic>> querySnapshot =
//       await FirebaseFirestore.instance
//           .collection('users')
//           .orderBy('score', descending: true)
//           .get();

//   ScoreModel first;
//   ScoreModel second;
//   ScoreModel third;

//   if (querySnapshot.docs.isNotEmpty) {
//     first = ScoreModel(
//         Username: querySnapshot.docs[0][FbScoreConst.username],
//         // Username: "shabeer",
//         email: querySnapshot.docs[0][FbScoreConst.mail],
//         score: querySnapshot.docs[0][FbScoreConst.score]);
//     log(querySnapshot.docs.length.toString());
//     log(first.Username);
//   }
//   if (querySnapshot.docs.length > 1) {
//     second = ScoreModel(
//         Username: querySnapshot.docs[1][FbScoreConst.username],
//         email: querySnapshot.docs[1][FbScoreConst.mail],
//         score: querySnapshot.docs[1][FbScoreConst.score]);
//     log(second.Username);
//   }
//   if (querySnapshot.docs.length > 2) {
//     third = ScoreModel(
//         Username: querySnapshot.docs[2][FbScoreConst.username],
//         email: querySnapshot.docs[2][FbScoreConst.mail],
//         score: querySnapshot.docs[2][FbScoreConst.score]);
//     log(third.Username);
//   }
// }
