
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final TextInputType? textInputType;
  const MyTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    required this.controller,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.sizeOf(context).width;
    double sizeheight = MediaQuery.sizeOf(context).height;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      height: sizeheight / 17.5,
      width: sizeWidth,
      margin: EdgeInsets.fromLTRB(
          sizeWidth / 25, sizeheight / 100, sizeWidth / 25, sizeheight / 100),
      child: TextField(
        keyboardType: textInputType,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(sizeWidth / 35),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide( width: 2.0),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide( width: 2.0),
            borderRadius: BorderRadius.circular(30),
          ),
          hintText: hintText,
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: sizeWidth / 25),
            child: prefixIcon,
          ),
        ),
      ),
    );
  }
}