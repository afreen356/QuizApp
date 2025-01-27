 import 'package:flutter/material.dart';
import 'package:quiz_app/screens/info.dart';


AlertDialog buildAlertDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Logout'),
      content: const Text('Do you want to exit the app'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) => const InfoScreen()), (route) => false);
          },
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('No'),
        ),
      ],
    );
  }
