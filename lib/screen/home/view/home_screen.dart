import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseminer/screen/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/fire_helper/fireauth_helper.dart';
import '../../../utils/fire_helper/firedb_helper.dart';
import '../../profile/model/profile_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  ProfileController controller = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  Future<void> getProfile() async {
    await FireDbHelper.fireDbHelper.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: InkWell(
            onTap: () {
              Get.toNamed("profile");
            },
            child: Obx(
              () => controller.imagePath.value == null
                  ? const CircleAvatar(
                      radius: 70,
                      child: Icon(Icons.person, size: 30),
                    )
                  : CircleAvatar(
                      radius: 70,
                      backgroundImage:
                          FileImage(File(controller.imagePath.value!)),
                    ),
            ),
          ),
        ),
        title: const Text(
          "Explora",
          style: TextStyle(fontFamily: 'medium'),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await FireAuthHelper.fireAuthHelper.signOut();
              Get.offAllNamed('signin');
            },
            icon: const Icon(
              Icons.login,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FireDbHelper.fireDbHelper.chatContact(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else if (snapshot.hasData) {
            List<ProfileModel> chatList = [];
            QuerySnapshot? qs = snapshot.data;
            if (qs != null) {
              List<QueryDocumentSnapshot> qsList = qs.docs;
              for (var x in qsList) {
                List mainList = [];
                Map data = x.data() as Map;

                data.entries.forEach((e) {
                  mainList.add(e.value);
                });

                if (mainList[0]
                    .contains(FireAuthHelper.fireAuthHelper.user!.uid)) {
                  ProfileModel p1 = ProfileModel(
                    name: mainList[1][0],
                    uid: mainList[1][1],
                    image: mainList[1][2],
                    address: mainList[1][3],
                    bio: mainList[1][4],
                    email: mainList[1][5],
                    mobile: mainList[1][6],
                    notificationToken: mainList[1][7],
                    docId: x.id,
                  );
                  chatList.add(p1);
                } else if (mainList[1]
                    .contains(FireAuthHelper.fireAuthHelper.user!.uid)) {
                  ProfileModel p1 = ProfileModel(
                    name: mainList[0][0],
                    uid: mainList[0][1],
                    image: mainList[0][2],
                    address: mainList[0][3],
                    bio: mainList[0][4],
                    email: mainList[0][5],
                    mobile: mainList[0][6],
                    notificationToken: mainList[0][7],
                    docId: x.id,
                  );
                  chatList.add(p1);
                }
              }
            }
            return ListView.builder(
              itemCount: chatList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.toNamed('chat', arguments: chatList[index]);
                  },
                  child: Container(
                    height: MediaQuery.sizeOf(context).height * 0.09,
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color(0xff6C63FF),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${chatList[index].name}",style: const TextStyle(fontFamily: "semiBold"),),
                            Text("${chatList[index].mobile}",style: const TextStyle(fontFamily: "light"),),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
