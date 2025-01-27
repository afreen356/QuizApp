
import 'package:flutter/material.dart';
import 'package:quiz_app/pages/home_page.dart';

class Policypage extends StatelessWidget {
  const Policypage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80),
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
                        padding: EdgeInsets.only(left: 40),
                        child: Text('Privacy Policy',style: TextStyle(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold),),
                      ),

                    ],
                  )),
            )
      ),
      body: const SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'User Authentication and Account Management :',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              ),
            ),
           Padding(
             padding: EdgeInsets.all(10.0),
             child: Text('When you sign up for an account on the App,We collect personal information such as your name,email address to create and manage your account.Your authentication information,including usernames and passwords is securely stored and  used for account authentication and management purposes.',style: TextStyle(fontWeight: FontWeight.w500
             ),),
           ),
           SizedBox(height: 20,),
           Padding(
             padding: EdgeInsets.only(right: 280),
             child: Text('Quiz Data:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
           ),
          //  SizedBox(height: 5,),
           Padding(
             padding: EdgeInsets.all(10.0),
             child: Text('We collect data on your quiz performance including answers chosen,time spent on each questions and quiz scores,to improve our quizzes and provide personal recommendations.',style: TextStyle(fontWeight: FontWeight.w500),),
           ),
           SizedBox(height: 10,),
        
          Padding(
            padding: EdgeInsets.only(right: 250,),
            child: Text('Data sharing',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: 5,),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text('We dont sell or rent your personal information to third parties.However we may share data with trusted service providers who assist us in operating our application,conducting business or servicing users.this includes hosting services and analytics services. ',style: TextStyle(fontWeight: FontWeight.w500),),
        
          ),
          SizedBox(height: 5,),
           Padding(
             padding: EdgeInsets.only(right: 250,),
             child: Text('Data Security',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
           ),
          SizedBox(height: 5,),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text('We take appropriate measures to protect your personal information from unauthorized access,alteration,disclosure or destruction. This includes encryption of sensitive data and regular security audits.',style: TextStyle(fontWeight: FontWeight.w500),),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.only(right: 240,),
            child: Text('Quiz Features',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.only(right: 195,),
            child: Text('Time Limited Questions:',style: TextStyle(fontWeight: FontWeight.w600,),),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20,),
            child: Text('Each question has a limited time of 30 seconds for users to respond enhancing engagement and challenge.'),
          ),
          SizedBox(height: 9,),
          Padding(
            padding: EdgeInsets.only(right: 230,),
            child: Text('Score Calculation:',style: TextStyle(fontWeight: FontWeight.w600,),),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text('After completing all qustions users can view their scores,encouraging participation and competition. '),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.only(right: 265,),
            child: Text('Leaderboard:',style: TextStyle(fontWeight: FontWeight.w600),),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20,),
            child: Text('We offer a leaderboard feature to display top scores,promoting friendly competetion among users.',),
          )

        
          ],
        ),
      ),
    );
  }
}