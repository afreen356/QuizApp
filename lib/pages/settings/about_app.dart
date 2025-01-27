

import 'package:flutter/material.dart';
import 'package:quiz_app/pages/home_page.dart';

class Aboutapp extends StatelessWidget {
  const Aboutapp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Container(
              height: 100,
               decoration: const BoxDecoration(
             
                  gradient: LinearGradient(colors: [
                   
                    Color(0xffB81736),
                    Color(0xff281537),
                  ])),
                   child: Center(child: Row(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>HomePage()));
                      }, icon: const Icon(Icons.arrow_back,color: Colors.white,)),
                      const Padding(
                        padding:  EdgeInsets.only(left: 40),
                        child: Text('About App',style: TextStyle(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                      
                    ],
                  )),
            ),
            
      ),
      body:  const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 120,top: 50),
              child: Text('Quizzland',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: EdgeInsets.only(left:170,),
              child: Text('1.0.0'),
            ),
            SizedBox(height: 40,),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Welcome to Quizzland,the ultimate destination for online quizzes!Here's what you need to know about our app:",style: TextStyle(fontWeight: FontWeight.w500),),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Our mission',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('At Quizzland , our mission is to provide an engaging and enjoyable quiz experience for users of all levels and interests.We aim to offer a wide variety of quizzes across different categoris and difficulty levels to cater to every quiz enthusiast.'),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: EdgeInsets.only(left: 20,top: 20),
              child: Text('Features',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ),
           
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.only(left: 10,),
              child: Text('.Extensive Quiz Library :',style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10,),
              child: Text('Access a vaste collection of quizzes covering various categories and difficulty levels.'
                    ),
            ),
                  SizedBox(height: 5,),
                  Padding(
                    padding: EdgeInsets.only(left: 10,),
                    child: Text('.User Authentication:',style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10,),
                    child: Text('Securely signup and login to your account to track your progress and compete  on leaderboards.'),
                  ),
                  SizedBox(height: 5,),
                  Padding(
                    padding: EdgeInsets.only(left: 10,),
                    child: Text('.Admin Control:',style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10,),
                    child: Text('Our admin panel allows administrators to manage quiz content efficiently,including adding , updating ,deleting questions and categories.'),
                  ),
                  SizedBox(height: 5,),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('.Time-Limited Questions:',style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10,),
                    child: Text('Test your knowledge under pressure with questions that have a limited time of 30 seconds each'),
                  ),
                  SizedBox(height: 5,),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('.Score Tracking:',style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10,),
                    child: Text('After completing a quiz,view your score and compare it with others on the leaderboard.'),
                  )
        
           
          ],
        ),
      ),
    );
  }
}