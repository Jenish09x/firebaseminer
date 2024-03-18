import 'package:firebaseminer/utils/theme/theme_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/fire_helper/fireauth_helper.dart';
import '../../../utils/theme/shared_helper.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  ThemeController controller = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * 0.31,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xff6C63FF).withOpacity(0.65),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.notes),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.29,
                        ),
                        const Text(
                          "SETTINGS",
                          style:
                              TextStyle(fontFamily: "semiBold", fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed("profile");
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.person),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Account"),
                        Spacer(),
                        Icon(Icons.navigate_next)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Row(
                    children: [
                      Icon(Icons.notifications_active),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Notification"),
                      Spacer(),
                      Icon(Icons.navigate_next)
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.color_lens_rounded),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("theme"),
                      const Spacer(),
                      Obx(
                        () => Switch(
                          value: controller.isLight.value,
                          onChanged: (value1) {
                            SharedHelper shr = SharedHelper();
                            shr.setTheme(value1);
                            controller.changeTheme();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Row(
                    children: [
                      Icon(Icons.share),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Share"),
                      Spacer(),
                      Icon(Icons.navigate_next)
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () async {
                      await FireAuthHelper.fireAuthHelper.signOut();
                      Get.offAllNamed('signin');
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.logout),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Log Out"),
                        Spacer(),
                        Icon(Icons.navigate_next)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
