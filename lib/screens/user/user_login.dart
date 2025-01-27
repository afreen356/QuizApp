
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/model/sharedclass.dart';
import 'package:quiz_app/pages/home_page.dart';
import 'package:quiz_app/screens/user/user_signup.dart';
import 'package:quiz_app/user_auth/firebase_auth.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => UserLoginState();
}

class UserLoginState extends State<UserLogin> {
  final TextEditingController usernameContoller =TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool obscureText = true;
  final FirebaseAuthService _auth = FirebaseAuthService();
  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();

    super.dispose();
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
          child: const Padding(
            padding: EdgeInsets.only(top: 60, left: 22),
            child: Text(
              'Hello\nSign in!',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 200),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: 'Enter Your Email',
                          hintStyle: TextStyle(color: Colors.grey)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your email';
                        } else {
                          return null;
                        }
                      },
                    )),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: _passController,
                      obscureText: obscureText,
                      decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              child: obscureText
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility)),
                          prefixIcon: const Icon(Icons.lock),
                          hintText: 'Enter Your Password',
                          hintStyle: const TextStyle(color: Colors.grey)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your password';
                        } else {
                          return null;
                        }
                      },
                    )),
                const SizedBox(
                  height: 70,
                ),
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                      gradient: const LinearGradient(
                          colors: [Color(0xffB81736), Color(0xff281537)])),
                  child: ElevatedButton(
                    onPressed: () {
                      signIn();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent),
                    child: const Text(
                      'SIGN IN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Don't have an account?",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => const SignUpscreen()));
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue),
                    ))
              ],
            ),
          ),
        ),
      ],
    ));
  }

  void signIn() async {
    
    String email = _emailController.text;
    String pass = _passController.text;

    User? user = await _auth.signInWithEmailandPass(email, pass);

    if (user != null) {
      log('user is successfully signedin');
      log(usernameContoller.text);
        // questionListNotifier.value.clear();
      SharedPref.sharedprefset(usernameContoller.text, email);
      
        SharedPref().sharedisntancefucniton();
            
      log(SharedPref().sharedInstanceUSer);
      // ignore: use_build_context_synchronously
      Navigator.of(context)
          .pushAndRemoveUntil(MaterialPageRoute(builder: (ctx1) =>  HomePage()), (route) => false);
    
         
    } else {
      log('some error occured');
    }
  }
}
