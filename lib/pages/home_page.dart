import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/functions/db_functions.dart';
import 'package:quiz_app/model/sharedclass.dart';

import 'package:quiz_app/pages/category.dart';
import 'package:quiz_app/pages/correct_ans.dart';
import 'package:quiz_app/pages/leaderboards.dart';
import 'package:quiz_app/pages/levels.dart';
import 'package:quiz_app/pages/profile.dart';
import 'package:quiz_app/pages/settings/about_app.dart';
import 'package:quiz_app/pages/settings/policy.dart';
import 'package:quiz_app/pages/settings/terms.dart';

import 'package:quiz_app/screens/info.dart';
import 'package:quiz_app/widgets/alertdialogue.dart';

class HomePage extends StatefulWidget {

  // ignore: prefer_const_constructors_in_immutables
  HomePage({
    super.key,
   
  });

  @override
  State<HomePage> createState() => _homePageState();
}

// ignore: camel_case_types
class _homePageState extends State<HomePage> {
  int currentSelectedIndex = 0;
    

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 5,
                    ),
                    child: Icon(
                      Icons.settings,
                      size: 40,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 7,
                    ),
                    child: Text(
                      'Settings',
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              const Divider(
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => const TermsAndCondpage()));
                      },
                      child: const Text(
                        'Terms and Conditions',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 45),
                    const Icon(
                      Icons.navigate_next,
                      color: Colors.grey,
                      size: 30,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (ctx) => const Policypage()));
                      },
                      child: const Text(
                        'Privacy policy',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 110),
                    const Icon(
                      Icons.navigate_next,
                      color: Colors.grey,
                      size: 30,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 15),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (ctx) => const Aboutapp()));
                      },
                      child: const Text(
                        'About Us',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 145),
                    const Icon(
                      Icons.navigate_next,
                      color: Colors.grey,
                      size: 30,
                    )
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Row(
                  children: [
                    const Text(
                      'Logout',
                      style: TextStyle(fontSize: 20),
                    ),
                    IconButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          buildAlertDialog(context);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const InfoScreen()));
                        },
                        icon: const Icon(
                          Icons.exit_to_app,
                          size: 30,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            // color: Color.fromARGB(255, 10, 147, 118)
            gradient: LinearGradient(
              colors: [
                Color(0xffB81736),
                Color(0xff281537),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 30),
                child: Builder(builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.menu,
                          size: 30,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20, top: 10),
                          child: GestureDetector(
                              onTap: () async {
                                await getUser();
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => ProfilePage(
                                          id: FirebaseAuth
                                              .instance.currentUser!.uid,
                                        )));
                              },
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance.collection('users').where('mail',isEqualTo: SharedPref().sharedInstanceUSer).snapshots(),
                                builder: (context, snapshot) {
                                   if(snapshot.hasData && snapshot.data?.docs[0]['image'].isNotEmpty){
                            // image = snapshot.data?.docs[0]['image'];
                            return Image.network(snapshot.data?.docs[0]['image'],height: 50,width: 100,);
                                   }else{
                                  return const Image(
                                    image: AssetImage(
                                        'assets/user-removebg-preview 1 (1).png'),
                                    height: 50,
                                    fit: BoxFit.cover,
                                  );
                                }
                                }
                              )),
                        )
                      ],
                    ),
                  );
                }),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 30),
                child: Text(
                  "Let's Play Quiz",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: TabBar(
                  tabs: [
                    Tab(
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Text(
                            'Levels',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Text('Category',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ],
                  labelColor:
                      Colors.white, // Set the color of the selected tab label
                  unselectedLabelColor:
                      Colors.grey, // Set the color of unselected tab labels
                  indicatorColor: Colors.blue,
                ),
              ),
              Expanded(
                  child:
                      TabBarView(children: [const LevelPage(),
                       UserCategory()]))
            ],
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: const Color(0xffB81736),
          animationDuration: const Duration(milliseconds: 300),
          items: const [
            Icon(
              Icons.home,
              size: 30,
            ),
            Icon(
              Icons.history,
              size: 30,
            ),
            Icon(Icons.leaderboard),
            Icon(
              Icons.person,
              size: 30,
            ),
          ],
          index: currentSelectedIndex,
          onTap: (newIndex) {
            setState(() {
              currentSelectedIndex = newIndex;
              if (newIndex == 0) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => HomePage()));
              } else if (newIndex == 1) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => const HistoryPage()));
              } else if (newIndex == 2) {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const Leaderboardpage()));
              } else if (newIndex == 3) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => ProfilePage(
                          id: FirebaseAuth.instance.currentUser!.uid,
                        )));
              }
            });
          },
        ),
      ),
    );
  }
}
