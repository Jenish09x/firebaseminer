import 'package:firebaseminer/utils/widget/custom_textField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../utils/fire_helper/fireauth_helper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtContact = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Align(
                      alignment: const Alignment(0, -0.32),
                      child: Image.asset("assets/image/map.png",
                          height: MediaQuery.sizeOf(context).height * 0.23),
                    ),
                    const Align(
                      alignment: Alignment(0, 0.3),
                      child: Text(
                        "Get Started",
                        style: TextStyle(fontFamily: 'medium', fontSize: 36),
                      ),
                    ),
                    const Align(
                      alignment: Alignment(0, 0.6),
                      child: Text(
                        "by creating a free account.",
                        style: TextStyle(fontFamily: 'light', fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              CustomTextField(
                controller: txtName,
                hintText: "Full name",
                icon: Icon(CupertinoIcons.person,
                    color: const Color(0xffC4C4C4).withOpacity(0.80)),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              CustomTextField(
                controller: txtEmail,
                hintText: "Valid email",
                icon: Icon(CupertinoIcons.mail,
                    color: const Color(0xffC4C4C4).withOpacity(0.80)),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              CustomTextField(
                controller: txtContact,
                hintText: "Phone number",
                icon: Icon(CupertinoIcons.device_phone_portrait,
                    color: const Color(0xffC4C4C4).withOpacity(0.80)),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              CustomTextField(
                controller: txtPassword,
                hintText: "Strong password",
                icon: Icon(CupertinoIcons.lock,
                    color: const Color(0xffC4C4C4).withOpacity(0.80)),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (value) {},
                  ),
                  const Text(
                    "By Checking the box you agree to our Terms and Conditions.",
                    style: TextStyle(fontSize: 10, fontFamily: "medium"),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.065,
              ),
              InkWell(
                onTap: ()
                  async {
                    String msg = await FireAuthHelper.fireAuthHelper.singUp(email: txtEmail.text, password: txtPassword.text);
                    Get.back();
                    Get.snackbar(msg,"");
                  },
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    color: const Color(0xff6C63FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      "Next.",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "semiBold",
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: Get.back,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already a member?",
                      style: TextStyle(fontFamily: "semiBold"),
                    ),
                    Text(
                      "Log in",
                      style: TextStyle(
                          fontFamily: "semiBold", color: Color(0xff6C63FF)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
