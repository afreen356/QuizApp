import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/functions/database_functions.dart';
import 'package:quiz_app/model/question_model.dart';
import 'package:quiz_app/widgets/snackbar.dart';
import 'package:quiz_app/widgets/textfield.dart';

class AddQuestionPage extends StatefulWidget {
  const AddQuestionPage({super.key});

  @override
  State<AddQuestionPage> createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  final CollectionReference quiz =
      FirebaseFirestore.instance.collection('category_db');
  String? value;
  final List<String> _levels = ["Easy", 'Medium', 'Hard'];
  String? level;

  TextEditingController qController = TextEditingController();
  TextEditingController op1Controller = TextEditingController();
  TextEditingController op2Controller = TextEditingController();
  TextEditingController op3Controller = TextEditingController();
  String category = '';
  TextEditingController op4Controller = TextEditingController();
  TextEditingController ansController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        backgroundColor: const Color.fromARGB(255, 25, 24, 24),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Add Quiz',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: const Color(0xFFececF8),
                        borderRadius: BorderRadius.circular(10)),
                    child: customTextfield(
                        controller: qController,
                        keyboardTYpe: TextInputType.name,
                        labelText: 'Enter a question',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Fill the question';
                          } else {
                            return null;
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction)),
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Option 1',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: const Color(0xFFececF8),
                        borderRadius: BorderRadius.circular(10)),
                    child: customTextfield(
                        controller: op1Controller,
                        keyboardTYpe: TextInputType.name,
                        labelText: 'Enter option 1',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please fill the field';
                          } else {
                            return null;
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction)),
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Option 2',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: const Color(0xFFececF8),
                        borderRadius: BorderRadius.circular(10)),
                    child: customTextfield(
                        controller: op2Controller,
                        keyboardTYpe: TextInputType.name,
                        labelText: 'Enter option 2',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Fill the field';
                          } else {
                            return null;
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction)),
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Option 3',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: const Color(0xFFececF8),
                        borderRadius: BorderRadius.circular(10)),
                    child: customTextfield(
                        controller: op3Controller,
                        keyboardTYpe: TextInputType.name,
                        labelText: 'Enter option 3',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Fill the field';
                          } else {
                            return null;
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction)),
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Option 4',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: const Color(0xFFececF8),
                        borderRadius: BorderRadius.circular(10)),
                    child: customTextfield(
                        controller: op4Controller,
                        keyboardTYpe: TextInputType.number,
                        labelText: 'Enter option 4',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Fill the field';
                          } else {
                            return null;
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction)),
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Correct answer',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: const Color(0xFFececF8),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: ansController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "   Enter correct answer",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter correct answer';
                      } else if (int.parse(value) < 0 || int.parse(value) > 4) {
                        return 'value must be between 0 and 3';
                      } else if (int.tryParse(value) == null) {
                        return 'charecters are not allowed';
                      }

                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFececF8),
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButtonFormField(
                    hint: const Text(
                      '   Choose level',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    onChanged: (value) {
                      setState(() {
                        level = value;
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    items: _levels.map((e) {
                      return DropdownMenuItem(value: e, child: Text(e));
                    }).toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please choose a level';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFececF8),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('category_db')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const CupertinoActivityIndicator();
                        } else {
                          return DropdownButtonFormField(
                            hint: category.isEmpty
                                ? const Text('Select a category')
                                : StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('category_db')
                                        .doc(category)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return const Text('Category');
                                      } else {
                                        return Text(snapshot.data!['name']);
                                      }
                                    }),
                            items: List.generate(snapshot.data!.docs.length,
                                (index) {
                              // final docId = snapshot.data!.docs[index].id;
                              return DropdownMenuItem(
                                value: snapshot.data!.docs[index].id,
                                child: Text(snapshot.data!.docs[index]['name']),
                              );
                            }),
                            onChanged: (value) {
                              setState(() {
                                category = value!;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return ' choose a category';
                              } else {
                                return null;
                              }
                            },
                          );
                        }
                      }),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 270),
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        uploaditem();
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: const Text(
                      'Upload',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  uploaditem() async {
    if (formkey.currentState!.validate()) {
      if (qController.text.isNotEmpty &&
          op1Controller.text.isNotEmpty &&
          op2Controller.text.isNotEmpty &&
          op3Controller.text.isNotEmpty &&
          op4Controller.text.isNotEmpty) {
        List<String> opt = [];
        opt.addAll([
          op1Controller.text,
          op2Controller.text,
          op3Controller.text,
          op4Controller.text
        ]);
        final data = QuestionModel(
            question: qController.text,
            options: opt,
            correctanswerIndex: int.parse(ansController.text),
            category: category,
            levels: level!);
        addQuiz(data);
        customSnackBar(context, 'Added successfully', Colors.green);
      }
    }
  }
}
