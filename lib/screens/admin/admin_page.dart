
import 'package:flutter/material.dart';
import 'package:quiz_app/screens/admin/category_tab.dart';
import 'package:quiz_app/screens/admin/question_list.dart';
import 'package:quiz_app/widgets/alertdialogue.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
         bottom: const TabBar(tabs: [
          Tab(child: Text('Category',style: TextStyle(fontSize: 20),),),
          Tab(child: Text('Question',style: TextStyle(fontSize: 20),),)
         ],labelColor: Colors.white, // Set the color of the selected tab label
              unselectedLabelColor: Colors.grey, // Set the color of unselected tab labels
              indicatorColor: Colors.grey
         ),
          backgroundColor: Colors.black,
          title: const Center(child: Text('AdminPanel',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),)),
          actions: [
            IconButton(onPressed: (){
              
            signout(context);
            }, icon: const Icon(Icons.exit_to_app),color: Colors.white,),
            
          ],
        ),
        body: const TabBarView(children:[
        CategoryPage(),
        QuestionList()
       

          ])
        ),
        
      );
    
  }
  void signout(BuildContext context)async{
    
     // ignore: no_leading_underscores_for_local_identifiers
     final _sharedPrefs = await SharedPreferences.getInstance();
     await _sharedPrefs.clear();
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (ctx1) {
          return buildAlertDialog(context);
        });
    
  }

}