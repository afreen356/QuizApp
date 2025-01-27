import 'package:flutter/material.dart';

Widget customTextfield({
   required TextEditingController controller,
  required TextInputType keyboardTYpe,
  required String labelText,
  required String? Function(String?)? validator,
  required AutovalidateMode autovalidateMode,
}){
return Column(
   children: [
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardTYpe,
          decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),
            labelText: labelText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          validator: validator,
          autovalidateMode: autovalidateMode,
        ),
      ),
    ],
);
}