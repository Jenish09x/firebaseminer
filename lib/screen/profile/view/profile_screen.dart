import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseminer/utils/fire_helper/firedb_helper.dart';
import 'package:firebaseminer/utils/widget/custom_textField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/fire_helper/fire_storage.dart';
import '../../../utils/fire_helper/fireauth_helper.dart';
import '../controller/profile_controller.dart';
import '../model/profile_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController controller = Get.put(ProfileController());
  TextEditingController txtName = TextEditingController();
  TextEditingController txtBio = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  String? image;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: FireDbHelper.fireDbHelper.getProfileData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              DocumentSnapshot? ds = snapshot.data;
              Map? data = ds?.data() as Map?;
              if (data != null) {
                txtName.text = data['name'];
                txtEmail.text = data['email'];
                txtMobile.text = data['mobile'];
                image = data['image'];
                txtAddress.text = data['address'];
                txtBio.text = data['bio'];
              }
              return Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.3,
                    width: double.infinity,
                    child: Obx(
                      () => controller.imagePath.value == null && image == null
                          ? Container()
                          : controller.imagePath.value != null
                              ? Image(
                                  image: FileImage(
                                      File(controller.imagePath.value!)),
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  image!,
                                  fit: BoxFit.cover,
                                ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.3,
                    width: double.infinity,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.notes),
                        const Text(
                          "PROFILE",
                          style: TextStyle(fontFamily: "light", fontSize: 20),
                        ),
                        IconButton(
                          icon: const Icon(Icons.settings_outlined),
                          onPressed: () {
                            Get.toNamed("setting");
                          },
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0, -0.5),
                    child: InkWell(
                      onTap: () async {
                        ImagePicker picker = ImagePicker();
                        XFile? file =
                            await picker.pickImage(source: ImageSource.gallery);
                        controller.imagePath.value = file?.path;
                      },
                      child: Obx(
                        () => controller.imagePath.value == null &&
                                image == null
                            ? const CircleAvatar(
                                radius: 70,
                                child:
                                    Icon(Icons.camera_alt_outlined, size: 30),
                              )
                            : controller.imagePath.value != null
                                ? CircleAvatar(
                                    radius: 70,
                                    backgroundImage: FileImage(
                                        File(controller.imagePath.value!)),
                                  )
                                : CircleAvatar(
                                    radius: 70,
                                    backgroundImage: NetworkImage(image!),
                                  ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0, 0.95),
                    child: Container(
                      height: MediaQuery.sizeOf(context).height * 0.59,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomTextField(
                            hintText: "Full name",
                            controller: txtName,
                            icon: const Icon(CupertinoIcons.pen),
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.015,
                          ),
                          CustomTextField(
                            hintText: "Bio",
                            controller: txtBio,
                            icon: const Icon(CupertinoIcons.pencil),
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.015,
                          ),
                          CustomTextField(
                            hintText: "Valid email",
                            controller: txtEmail,
                            icon: const Icon(CupertinoIcons.mail),
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.015,
                          ),
                          CustomTextField(
                            hintText: "Enter phone",
                            controller: txtMobile,
                            icon: const Icon(CupertinoIcons.phone),
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.015,
                          ),
                          CustomTextField(
                            hintText: "Address",
                            controller: txtAddress,
                            icon: const Icon(CupertinoIcons.map),
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.08,
                          ),
                          InkWell(
                            onTap: () async {
                              String? path;
                              if (controller.imagePath.value != null) {
                                path = await FireStorage.fireStorage
                                    .uploadProfile(controller.imagePath.value!);
                              }
                              ProfileModel p1 = ProfileModel(
                                uid: FireAuthHelper.fireAuthHelper.user!.uid,
                                name: txtName.text,
                                mobile: txtMobile.text,
                                bio: txtBio.text,
                                email: txtEmail.text,
                                address: txtAddress.text,
                                image: controller.imagePath.value != null
                                    ? path
                                    : image,
                              );
                              FireDbHelper.fireDbHelper.addProfileData(p1);
                              Get.offAllNamed('dash');
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
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}