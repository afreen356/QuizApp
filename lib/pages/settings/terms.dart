
import 'package:flutter/material.dart';
import 'package:quiz_app/pages/home_page.dart';

class TermsAndCondpage extends StatelessWidget {
  const TermsAndCondpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(60), child: Center(child: Container(
        height: 150,
        width: double.infinity,
      
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
           Color(0xffB81736),
                  Color(0xff281537),
          ])
        ),
        child: 
         Center(child: Row(
          children: [
             IconButton(onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>HomePage()));
                      }, icon: const Icon(Icons.arrow_back,color: Colors.white,)),
            const Padding(
              padding: EdgeInsets.only(left: 30,top: 10),
              child: Text('Terms and Conditions',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
            ),
          ],
        ))))),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Divider(),

         Padding(
           padding: EdgeInsets.only(top: 20,),
           child: Text('Welcome to Quizland!',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
         ),
         SizedBox(height: 30,),
         Text('These Terms and Conditions govern your use of Quizland.'),
         SizedBox(height: 10,),
         Text('   .Users must be of a certain age or have parental consent to \n    use the application'),
         Text('.Users may be required to register an account to use the \n application, and they agree to provide accurate and \n complete information.'),
         Text(".The application's content, including questions, answers, \n and any other materials, are protected by copyright or \n other intellectual property rights, and users agree not to \n use them in unauthorized ways"),
         Text(' .The developers reserve the right to modify the terms and \n  conditions at any time, with or without notice to users.'),
         SizedBox(height: 20,),
         Padding(
           padding: EdgeInsets.only(right: 170),
           child: Text('Prohibited Activities',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
         ),
         SizedBox(height: 10,),
         Text('Users agree not to engage in certain activities, such as\nhacking, distributing spam, or violating the rights of\nothers.')
        ],
      ),
    );
  }
}