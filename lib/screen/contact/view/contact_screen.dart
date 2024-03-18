import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/fire_helper/firedb_helper.dart';
import '../../profile/model/profile_model.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: FireDbHelper.fireDbHelper.getAllContact(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              List<ProfileModel> contactData = [];
              QuerySnapshot? qs = snapshot.data;
              if(qs!=null){
                List<QueryDocumentSnapshot> qsList = qs.docs;

                for (var x in qsList) {
                  Map m1 = x.data() as Map;
                  ProfileModel p1 = ProfileModel(
                      uid: m1['uid'],
                      image: m1['image'],
                      name: m1['name'],
                      bio: m1['bio'],
                      email: m1['email'],
                      mobile: m1['mobile'],
                      address: m1['address'],
                      notificationToken: m1['notificationToken']
                  );
                  contactData.add(p1);
                }
              }
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Find your friends ;)",style: TextStyle(fontFamily: "medium",fontSize: 20),),
                    const SizedBox(height: 20,),
                    Expanded(
                      child: ListView.builder(
                        itemCount: contactData.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              Get.toNamed('chat',arguments: contactData[index]);
                            },
                            leading: contactData[index].image != null
                                ? CircleAvatar(
                              radius: 30,
                              backgroundImage:
                              NetworkImage("${contactData[index].image}"),
                            )
                                : CircleAvatar(
                              radius: 30,
                              child: Text(
                                contactData[index].name!.substring(0, 1).toUpperCase(),
                                style: const TextStyle(fontFamily: "semiBold"),
                              ),
                            ),
                            title: Text("${contactData[index].name}",style: const TextStyle(fontFamily: "medium"),),
                            subtitle: Text("${contactData[index].mobile}",style: const TextStyle(fontFamily: "light"),),
                          );
                        },
                      ),
                    ),
                  ],
                ),
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