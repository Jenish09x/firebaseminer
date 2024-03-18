import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../contact/view/contact_screen.dart';
import '../../home/view/home_screen.dart';
import '../../setting/view/setting_screen.dart';
import '../controller/dash_controller.dart';

class DashScreen extends StatefulWidget {
  const DashScreen({super.key});

  @override
  State<DashScreen> createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  DashController controller = Get.put(DashController());
  List screen = [
    const HomeScreen(),
    const ContactScreen(),
    const SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() => screen[controller.stepIndex.value]),
        bottomNavigationBar: Obx(
              () => NavigationBar(
            onDestinationSelected: (value) {
              controller.stepIndex.value = value;
            },
            selectedIndex: controller.stepIndex.value,
            destinations: const [
              NavigationDestination(icon: Icon(CupertinoIcons.home), label: "home"),
              NavigationDestination(icon: Icon(CupertinoIcons.person), label: "contact"),
              NavigationDestination(icon:  Icon(CupertinoIcons.settings), label: "setting"),
            ],
          ),
        ),
      ),
    );
  }
}
