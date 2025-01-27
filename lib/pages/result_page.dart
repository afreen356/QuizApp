import 'package:flutter/material.dart';
import 'package:quiz_app/pages/home_page.dart';
import 'package:quiz_app/pages/leaderboards.dart';

// ignore: must_be_immutable
class Resultpage extends StatelessWidget {
  int score;
  Resultpage({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 521,
          width: 400,
          child: Stack(
            children: [
              Container(
                height: 340,
                width: 410,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xffB81736),
                        Color(0xff281537),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: CircleAvatar(
                    radius: 85,
                    backgroundColor: Colors.white.withOpacity(.3),
                    child: CircleAvatar(
                      radius: 71,
                      backgroundColor: Colors.white.withOpacity(.4),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                  top: 0,
                                ),
                                child: Text(
                                  'Your Score',
                                  style: TextStyle(
                                    color: Color(0xffB81736),
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Text('$score',style: const TextStyle(fontSize: 25,color: Colors.black),)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 60,
                  left: 22,
                  child: Container(
                    height: 190,
                    width: 350,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow:const [
                           BoxShadow(
                              blurRadius: 3,
                              spreadRadius: 1,
                              color: Color(0xffB81736),
                              offset: Offset(0, 1))
                        ]),
                    child: const Image(
                      image: AssetImage('assets/download-removebg-preview.png'),
                      height: 400,
                      width: 400,
                    ),
                  ))
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Center(
          child: Column(
            children: [
              Container(
                height: 60,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow:const [
                       BoxShadow(
                          blurRadius: 3, spreadRadius: 2, color: Colors.black26)
                    ]),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>const Leaderboardpage()));
                    },
                    child: const Text(
                      'Leaderboards',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) => HomePage()), (route) => false);
                     
                },
                child: const CircleAvatar(
                  radius: 25,
                  backgroundColor: Color.fromARGB(255, 22, 161, 108),
                  child: Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              const Text(
                'Play again',
              )
            ],
          ),
        )
      ],
    ));
  }
}
