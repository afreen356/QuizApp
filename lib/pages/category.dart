import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/pages/categories/questions.dart';

class UserCategory extends StatelessWidget {
   UserCategory({super.key});
 final CollectionReference category = FirebaseFirestore.instance.collection('category_db');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: Container(
             height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              
              gradient: LinearGradient(
                colors: [
                  Color(0xffB81736),
                  Color(0xff281537),
                ],
              ),
            ),
            child: StreamBuilder(
              stream: category.snapshots(), 
            builder: (context,snapshot){
              if(snapshot.hasData){  
               return GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 10,
                
                
               ),
               itemCount: snapshot.data!.docs.length, 
               itemBuilder:(context,index){
                final quizsnap = snapshot.data!.docs[index];
               return Card(
                
                elevation: 5,margin: const EdgeInsets.all(10),
                // color: Color.fromARGB(255, 213, 209, 209),
                color: Colors.white,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(21),bottomRight: Radius.circular(21))),
                child: Center(child: GestureDetector(
                 
                onTap: () {
                 Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>Questions(category: quizsnap.id)));
                },
                  child: Text(quizsnap['name'],style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black),))));
                
               } ,
                             
               );
              }return Container();
            },
            ),
          ))
        ],
      ),
      
    );
  }
 
}
