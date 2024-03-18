import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/fire_helper/fireauth_helper.dart';
import '../../../utils/fire_helper/firedb_helper.dart';
import '../../profile/model/profile_model.dart';
import '../model/chat_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ProfileModel profileModel = Get.arguments;
  TextEditingController txtMsg = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: profileModel.image != null
              ? CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage("${profileModel.image}"),
                )
              : CircleAvatar(
                  radius: 30,
                  child: Text(
                    profileModel.name!.substring(0, 1).toUpperCase(),
                    style: const TextStyle(fontFamily: "semiBold"),
                  ),
                ),
        ),
        title: Text(
          "${profileModel.name}",
          style: const TextStyle(fontFamily: "medium"),
        ),
        actions: const [
          Icon(Icons.call_outlined),
          SizedBox(width: 20,),
          Icon(Icons.video_camera_front_outlined),
          SizedBox(width: 20,),
        ],
      ),
      body: Stack(
        children: [
          profileModel.docId == null
              ? Container()
              : StreamBuilder(
                  stream:
                      FireDbHelper.fireDbHelper.readChat(profileModel.docId!),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else if (snapshot.hasData) {
                      List<ChatModel> massageList = [];

                      QuerySnapshot? qs = snapshot.data;

                      if (qs != null) {
                        List<QueryDocumentSnapshot> qsDocList = qs.docs;
                        for (var x in qsDocList) {
                          Map data = x.data() as Map;

                          ChatModel c1 = ChatModel(
                            name: data['name'],
                            msg: data['msg'],
                            time: data['time'],
                            date: data['date'],
                            id: data['id'],
                            docId: x.id,
                          );
                          massageList.add(c1);
                        }
                      }
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 100),
                        child: ListView.builder(
                          reverse: true,
                          itemCount: massageList.length,
                          itemBuilder: (context, index) {
                            return Align(
                              alignment: massageList[index].id ==
                                      FireAuthHelper.fireAuthHelper.user!.uid
                                  ? Alignment.centerRight
                                  : Alignment.bottomLeft,
                              child: GestureDetector(
                                onLongPress: () {
                                  if (massageList[index].id! ==
                                      FireAuthHelper.fireAuthHelper.user!.uid) {
                                    Get.defaultDialog(
                                        content:
                                            Text("${massageList[index].msg}"),
                                        actions: [
                                          IconButton(
                                            onPressed: () {
                                              FireDbHelper.fireDbHelper
                                                  .deleteMessage(
                                                      profileModel.docId!,
                                                      massageList[index]
                                                          .docId!);
                                              Get.back();
                                            },
                                            icon: const Icon(Icons.delete),
                                          ),
                                        ],
                                        title: "Delete");
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xff6C63FF),
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(10),
                                      topRight: const Radius.circular(10),
                                      bottomLeft: Radius.circular(
                                          massageList[index].id ==
                                                  FireAuthHelper
                                                      .fireAuthHelper.user!.uid
                                              ? 10
                                              : 0),
                                      bottomRight: Radius.circular(
                                          massageList[index].id ==
                                                  FireAuthHelper
                                                      .fireAuthHelper.user!.uid
                                              ? 0
                                              : 10),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: massageList[index].id ==
                                            FireAuthHelper
                                                .fireAuthHelper.user!.uid
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${massageList[index].name}",
                                        style: const TextStyle(
                                            fontFamily: "semiBold"),
                                      ),
                                      Text(
                                        "${massageList[index].msg}",
                                        style: const TextStyle(
                                            fontFamily: "medium"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: txtMsg,
                        textAlignVertical: TextAlignVertical.top,
                        style: const TextStyle(fontFamily: "medium"),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      color: const Color(0xff6C63FF),
                      onPressed: () {
                        ChatModel model = ChatModel(
                          id: FireAuthHelper.fireAuthHelper.user!.uid,
                          name: FireDbHelper.fireDbHelper.myProfileData.name,
                          msg: txtMsg.text,
                          time:
                              "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
                          date:
                              "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                        );
                        FireDbHelper.fireDbHelper.sendMessage(
                            model,
                            FireDbHelper.fireDbHelper.myProfileData,
                            profileModel);
                        txtMsg.clear();
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
