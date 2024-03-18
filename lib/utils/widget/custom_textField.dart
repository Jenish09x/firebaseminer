import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController? controller;
  Color? labelColor;
  String? hintText;
  Icon? icon;

  CustomTextField({this.icon,this.controller,this.hintText,this.labelColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.85,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
            filled: true,
            suffixIcon: icon,
            // suffixIcon: Icon(
            //   icon,
            //   color: const Color(0xffC4C4C4).withOpacity(0.80),
            // ),
            fillColor: const Color(0xffC4C4C4).withOpacity(0.20),
            hintText: hintText??"",
            hintStyle:
            const TextStyle(fontFamily: "light", fontSize: 14)),
      ),
    );
  }
}
