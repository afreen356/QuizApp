import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/functions/database_functions.dart';
import 'package:quiz_app/screens/admin/add_category.dart';
import 'package:quiz_app/screens/admin/edit_category.dart';
import 'package:quiz_app/screens/admin/show_questions.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final CollectionReference quiz =
      FirebaseFirestore.instance.collection('category_db');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => AddCategory()));
        },
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder(
        stream: quiz.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot quizsnap = snapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 3,
                      color: const Color.fromARGB(255, 172, 169, 169),
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>ShowQuestions(category: quizsnap.id)));
                              },
                              child: Text(
                                quizsnap['name'],
                                style: const TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              
                              children: [
                                IconButton(
                                  
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (ctx) => CategoryEdit(
                                              id: quizsnap.id,
                                            )));
                                  },
                                  icon: const Icon(Icons.edit),
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () async {
                                bool values = await checkQuestion(quizsnap.id);
                                if (values == true) {
                                 await deleteQuiz(quizsnap.id);
                                } else {
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.red,
                                          content: Text(
                                              "This category can't be deleted",style: TextStyle(fontSize: 20),)));
                                }
                              },
                              icon: const Icon(Icons.delete),
                              color: const Color.fromARGB(255, 153, 47, 39),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
          return Container();
        },
      ),
    );
  }
}
