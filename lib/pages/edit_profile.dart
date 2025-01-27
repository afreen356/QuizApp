import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quiz_app/model/sharedclass.dart';

class EditProfile extends StatefulWidget {
  final String nameController;
  final String url;

  // ignore: prefer_const_constructors_in_immutables
  EditProfile({super.key, required this.nameController, required this.url});

  @override
  State<EditProfile> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<EditProfile> {
  TextEditingController usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    usernameController.text = widget.nameController;
  }

  String? selectedImage;
  final picker = ImagePicker();
  String image = '';

  @override
  Widget build(BuildContext context) {
    log('helooo value ethi ${widget.nameController}');

    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xffB81736),
              Color(0xff281537),
            ]),
          ),
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 40,
                left: 20,
              ),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 30,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 120, top: 130),
              child: CircleAvatar(
                radius: 70,
                backgroundColor: const Color.fromARGB(255, 227, 221, 221),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .where('mail',
                            isEqualTo: SharedPref().sharedInstanceUSer)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.data?.docs[0]['image'].isNotEmpty) {
                        image = snapshot.data?.docs[0]['image'];
                        return ClipOval(
                            child: Image.network(
                          snapshot.data?.docs[0]['image'],
                          fit: BoxFit.cover,height: 140,width: 140,
                        ));
                      } else {
                        return const Padding(
                          padding: EdgeInsets.only(bottom: 25),
                          child: Image(
                              image: AssetImage(
                                  'assets/user-removebg-preview 1 (1).png')),
                        );
                      }
                    }),
              ),
            ),
            Stack(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 250),
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                160,
                              ),
                              topRight: Radius.circular(160))),
                      child: Column(
                        children: [
                          Container(
                            width: 100,
                            height: 50,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 5,
                                      spreadRadius: 1)
                                ]),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, bottom: 20),
                              child: IconButton(
                                  onPressed: () {
                                    pickImage();
                                  },
                                  icon: const Icon(
                                    Icons.photo_camera,
                                    size: 35,
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              controller: usernameController,
                              decoration: const InputDecoration(
                                  hintText: 'username',
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Card(
                            elevation: 5,
                            child: GestureDetector(
                              onTap: () {
                                editProfile(usernameController.text);
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                height: 50,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 20, top: 10),
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ]),
        )
      ]),
    ));
  }

  void pickImage() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage != null) {
      selectedImage = returnedImage.path;
      var val = await imagesendtoSTorage(returnedImage);

      log("  valu url $val");
    }
    setState(() {
      if (returnedImage != null) {
        selectedImage = returnedImage.path;
      }
    });
  }
}

editProfile(String uname) async {
  final data = await FirebaseFirestore.instance
      .collection('users')
      .where('mail', isEqualTo: SharedPref().sharedInstanceUSer)
      .get();

  data.docs.first.reference.update({' username': uname});
  log('updated vlaue to  $uname');
}

imagesendtoSTorage(XFile imagexfile) async {
  // List<String> downloadUrls = [];
  // final name=DateTime.now();
  final storageRef = FirebaseStorage.instance.ref();
  String fname = DateTime.now().toString();
  String fileName = "userimage/$fname.jpg";
  Reference refernece = storageRef.child(fileName);
  TaskSnapshot upload = await refernece.putFile(File(imagexfile.path));
  String url = await upload.ref.getDownloadURL();
  putImageinfb(url);
  return url;
}

putImageinfb(String url) async {
  final data = await FirebaseFirestore.instance
      .collection('users')
      .where('mail', isEqualTo: SharedPref().sharedInstanceUSer)
      .get();
  data.docs.first.reference.update({'image': url});
}
