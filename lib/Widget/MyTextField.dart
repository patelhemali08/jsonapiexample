

import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {

  TextEditingController? controller;
  String? text;
  TextInputType? keyboardtype;
  bool obscuretext = false;

  MyTextField({super.key,this.controller,this.text,this.keyboardtype,required this.obscuretext});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          hintText: text),
      obscureText: obscuretext,
      controller: controller,
      keyboardType: keyboardtype,
    );
  }
}
