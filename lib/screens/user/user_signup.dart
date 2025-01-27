import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/functions/db_functions.dart';
import 'package:quiz_app/model/user_model.dart';
import 'package:quiz_app/pages/home_page.dart';
import 'package:quiz_app/screens/user/user_login.dart';
import 'package:quiz_app/user_auth/firebase_auth.dart';
import 'package:quiz_app/widgets/text.dart';

class SignUpscreen extends StatefulWidget {
  const SignUpscreen({super.key});

  @override
  State<SignUpscreen> createState() => _SignUpscreenState();
}

class _SignUpscreenState extends State<SignUpscreen> {
  final _key = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passController = TextEditingController();

  final TextEditingController confirmController = TextEditingController();

  bool _obscuretext = true;
  bool _ispassword = true;

  final FirebaseAuthService _auth = FirebaseAuthService();
  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passController.dispose();
    confirmController.dispose();
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
              'Create your\nAccount !',
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
            child: SingleChildScrollView(
              child: Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: usernameController,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              hintText: ' Username',
                              hintStyle: TextStyle(color: Colors.grey)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter username';
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
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              hintText: 'Email',
                              hintStyle: TextStyle(color: Colors.grey)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter a valid email';
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
                          keyboardType: TextInputType.text,
                          controller: passController,
                          obscureText: _obscuretext,
                          decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscuretext = !_obscuretext;
                                    });
                                  },
                                  child: _obscuretext
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility)),
                              prefixIcon: const Icon(Icons.lock),
                              hintText: ' create a Password',
                              hintStyle: const TextStyle(color: Colors.grey)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please create a password';
                            } else if (passController.text.length < 8) {
                              return 'password should be atleast 8 charecters';
                            } else if (value == '12345678') {
                              return 'please enter strong password';
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
                          controller: confirmController,
                          obscureText: _ispassword,
                          decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _ispassword = !_ispassword;
                                    });
                                  },
                                  child: _ispassword
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility)),
                              prefixIcon: const Icon(Icons.lock),
                              hintText: 'Confirm Password',
                              hintStyle: const TextStyle(color: Colors.grey)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please confirm your pssword';
                            } else if (passController.text !=
                                confirmController.text) {
                              return 'please check your password';
                            } else {
                              return null;
                            }
                          },
                        )),
                    const SizedBox(
                      height: 100,
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
                          if (_key.currentState!.validate()) {
                            signUp(UserModel(
                                firebaseId: '',
                                username: usernameController.text,
                                gmail: emailController.text,
                                age: '',
                                question: '',
                                correctAnswerIndex: {},
                                score: 0));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent),
                        child: const Text(
                          'SIGN UP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 90,
                    ),
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (ctx) => const UserLogin()));
                        },
                        child: styledText('Sign in',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            Color: Colors.blue))
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }

  void signUp(UserModel value) async {
    String username = usernameController.text;
    String email = emailController.text;
    String pass = passController.text;
    // FirebaseAuth user = FirebaseAuth.instance;

    User? user = await _auth.signUpWithEmailandPass(email, pass);
    if (user != null) {
      firebsaeUserStore(username, email);
      // SharedPref.sharedprefset(username, email);
      final newUser = UserModel(
          firebaseId: FirebaseAuth.instance.currentUser!.uid,
          username: username,
          gmail: email,
          age: '',
          question: '',
          correctAnswerIndex: {},
          score: 0);
      await addUser(newUser);
      //   final _sharedprefs = await SharedPreferences.getInstance();
      //   final userloggedin = _sharedprefs.setString('user_login', user.uid);
      // print('user is successfully created');
      Navigator.of(context)
          .pushAndRemoveUntil(MaterialPageRoute(builder: (ctx1) =>  HomePage()), (route) => false);
    } else {
      print('some error occured');
    }
  }
}

// ------------------------------------------
// to store users credentinals in firebase
// ------------------------------------------

firebsaeUserStore(String username, String email) async {
  //  final fdata = await FirebaseFirestore.instance
  //     .collection('users')
  //     .where('mail', isEqualTo: email)
  //     .get();

  FirebaseFirestore.instance
      .collection('users')
      .add({' username': username, 'mail': email, 'score': 0, 'image':'' });
}
