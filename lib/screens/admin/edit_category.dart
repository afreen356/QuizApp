import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/widgets/snackbar.dart';

class CategoryEdit extends StatefulWidget {
  final String id;
  const CategoryEdit({super.key, required this.id});

  @override
  State<CategoryEdit> createState() => _categoryEditState();
}

// ignore: camel_case_types
class _categoryEditState extends State<CategoryEdit> {
  TextEditingController categoryName = TextEditingController();
  String category = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
         leading: GestureDetector(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>const QuestionList()));
              Navigator.of(context).pop();
            },
            child:const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('category_db')
              .doc(widget.id)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CupertinoActivityIndicator();
            } else {
              category = snapshot.data!['name'];
              categoryName.text = category;
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Text(
                    'Update Category',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: TextField(
                    controller: categoryName,
                    decoration:
                        const InputDecoration(hintText: '  Enter a category name'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 280, top: 30),
                  child: Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                        onPressed: () {
                          updateCategory(widget.id, categoryName.text);
                           
                        },
                        child: const Text(
                          'Update ',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                  ),
                )
              ],
            );
          }),
    );
  }

  void updateCategory(String categoryId, String newCategoryName) async {
    await FirebaseFirestore.instance
        .collection('category_db')
        .doc(widget.id)
        .update({'name': newCategoryName});
       // ignore: use_build_context_synchronously
       customSnackBar(context,
        'Category addedd successfully', 
        Colors.green);
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
  }
}
