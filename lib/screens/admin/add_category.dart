import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/widgets/snackbar.dart';
import 'package:quiz_app/widgets/text.dart';
import 'package:quiz_app/widgets/textfield.dart';

// ignore: must_be_immutable
class AddCategory extends StatelessWidget {
  AddCategory({super.key});

  final CollectionReference quiz =
      FirebaseFirestore.instance.collection('category_db');

  TextEditingController categoryName = TextEditingController();
  final _key = GlobalKey<FormState>();

  void addCategory() {
    if (_key.currentState!.validate()) {
      final data = {'name': categoryName.text};
      if (data.isNotEmpty) {
        quiz.add(data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Container(
            height: 100,
            decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.only(
                right: 340,
              ),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  )),
            ),
          )),
      body: Form(
        key: _key,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow:const [
                         BoxShadow(
                          blurRadius: 1,
                          spreadRadius: 2,
                          color: Colors.black12,
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 5,
                    ),
                    child: styledText('Add Category',
                        fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                )),
            customTextfield(
                controller: categoryName,
                keyboardTYpe: TextInputType.name,
                labelText: 'Enter a category name',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter a category';
                  } else {
                    return null;
                  }
                },
                autovalidateMode: AutovalidateMode.onUserInteraction),
            Padding(
              padding: const EdgeInsets.only(left: 280, top: 30),
              child: Container(
                height: 50,
                width: 80,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        addCategory();

                        Navigator.of(context).pop();
                        customSnackBar(context, 'Category added successfully',
                            Colors.green);
                      }
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
