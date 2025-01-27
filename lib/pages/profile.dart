


import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:quiz_app/functions/db_functions.dart';
import 'package:quiz_app/model/sharedclass.dart';
import 'package:quiz_app/pages/edit_profile.dart';
import 'package:quiz_app/pages/home_page.dart';
import 'package:quiz_app/screens/constan.dart';


class ProfilePage extends StatefulWidget {



    // final UserModel userModel;
final String id ;
  const ProfilePage({super.key,required this.id});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
 String userN='';
  
  String image='';

  @override
  void initState() {
    getUser();
  
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xffB81736),
              Color(0xff281537),
            ]),
          ),
          child: Stack(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>HomePage()));
                },
                child: const Padding(
                  padding: EdgeInsets.only(top: 40,left: 20,
                  ),
                  child: Icon(Icons.navigate_before,size: 40,color: Colors.white,),
                )),
              Padding(
                padding: const EdgeInsets.only(left: 120, top: 130),
                child: CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 227, 221, 221),
                  radius: 70,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('users').where('mail',isEqualTo:SharedPref().sharedInstanceUSer ).snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData && snapshot.data?.docs[0]['image'].isNotEmpty){
                        image = snapshot.data?.docs[0]['image'];
                        return ClipOval(child: Image.network(snapshot.data?.docs[0]['image'],fit: BoxFit.cover,height: 140,width: 140,));
                        
                        
                      }else {
                      return 
                      const Padding(
                        padding: EdgeInsets.only(bottom: 25,),
                        child: Image(
                            image: AssetImage(
                                'assets/user-removebg-preview 1 (1).png'),height: 130,),
                      );
                    }
                    }
                  ),
                ),
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 250),
                    child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                  160,
                                ),
                                topRight: Radius.circular(160))),
                        child: Column(
                          //  mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 100,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                  
                                    BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 5,
                                        spreadRadius: 1)
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 50,
                                ),
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  EditProfile(nameController: userN,url: image,)));
                                    },
                                    icon: const Icon(Icons.edit)),
                              ),
                            ),
                            const SizedBox(
                              height: 80,
                            ),
                           
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Container(
                                height: 60,
                                width: double.infinity,
          
                            
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)
                                ),
                                child: StreamBuilder(
                                  stream: FirebaseFirestore.instance.collection('users').where('mail',isEqualTo:SharedPref().sharedInstanceUSer ).snapshots(),
                                  builder: (context, snapshot) {
                                   if(!snapshot.hasData){
                                    return const CircularProgressIndicator();
                                   }else{
                                    userN=snapshot.data?.docs[0][FbScoreConst.username];
                                    return Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(snapshot.data?.docs[0][FbScoreConst.username]),
                                    );
                                   
                                  }
                                  }
                                ),
                              )
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: TextFormField(
                                  decoration: InputDecoration(
                                      // hintText: '${userData?.gmail}',
                                      // hintText: SharedPref().sharedisntancefucniton();
                                      hintText: SharedPref().sharedInstanceUSer,
                                      border: const OutlineInputBorder())),
                            ),
                           
                          ],
                        )),
                  )
                ],
              )
            ],
          ),
        )
      ],
    ));
  }
}


