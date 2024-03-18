import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../utils/fire_helper/fireauth_helper.dart';
import '../../../utils/widget/custom_textField.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool click = true;

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
                  children: [
                    Align(
                      alignment: const Alignment(0, -0.4),
                      child: Image.asset("assets/image/map.png",
                          height: MediaQuery.sizeOf(context).height * 0.23),
                    ),
                    const Align(
                      alignment: Alignment(0, 0.25),
                      child: Text(
                        "Welcome back",
                        style: TextStyle(fontFamily: 'medium', fontSize: 24),
                      ),
                    ),
                    const Align(
                      alignment: Alignment(0, 0.55),
                      child: Text(
                        "sign in to access your account",
                        style: TextStyle(fontFamily: 'light', fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("assets/image/facebook.png",height: 30,),
                  InkWell(onTap: ()async {
                    String msg=await FireAuthHelper.fireAuthHelper.googleSignIn();
                    Get.snackbar(msg, "Login success fully");
                    if(msg=="success")
                    {
                      FireAuthHelper.fireAuthHelper.checkUser();
                      Get.offAllNamed('profile');
                    }
                  },child: Image.asset("assets/image/google.png",height: 30,)),
                  InkWell(onTap: () async {
                    String msg=await FireAuthHelper.fireAuthHelper.guestLogin();
                    Get.snackbar(msg, "Login success fully");
                    if(msg=="success")
                    {
                      FireAuthHelper.fireAuthHelper.checkUser();
                      Get.offAllNamed('profile');
                    }
                  },child: Image.asset("assets/image/guest.png",height: 30,)),
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height*0.11,),
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
                    value: click,
                    onChanged: (value) {},
                  ),
                  const Text(
                    "Remember me",
                    style: TextStyle(fontSize: 12, color: Color(0xff6C63FF)),
                  ),
                  const Spacer(),
                  const Text(
                    "Forget password ?",
                    style: TextStyle(fontSize: 12, color: Color(0xff6C63FF)),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.1,
              ),
              InkWell(
                onTap: () async {
                  String msg = await FireAuthHelper.fireAuthHelper.singIn(
                      email: txtEmail.text, password: txtPassword.text);
                  Get.snackbar(msg, "");
                  if (msg == "success") {
                    FireAuthHelper.fireAuthHelper.checkUser();
                    Get.offAllNamed('profile');
                  }
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
                      "Continue",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "semiBold",
                          fontSize: 17),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Get.toNamed("signup");
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New Member? ",
                      style: TextStyle(fontFamily: "medium"),
                    ),
                    Text(
                      "Register now",
                      style: TextStyle(
                          fontFamily: "semiBold", color: Color(0xff6C63FF)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
